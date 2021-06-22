/**********************************
        Diffraction Simulator
        (c) K. Sinagire, 2021
***********************************/

int num_sw = 5;
int initial = 0;
int sw = 0;
int angle = 0;
float dp = 0.3;
boolean triplex = false;
String s="";
float[][] value;
float[][] re;
float[][] im;



void setup() {
  size(640, 320);  // Size must be the first statement
  stroke(255);  // Set line drawing color to white
}

void draw() { 
  background(0);
  stroke(255);
  fill(255);
  
  float scale = 1.0;
  
  switch (sw % num_sw){
  
  //double-slit
  case 0:
  s="Control: ←→↑↓";
  rrect(0,-0.4+(0.3-dp),-radians(angle));
  rrect(0,+0.4,-radians(angle));
  break;
  
  //W-shaped slit (4 slits)
  case 1:
  s="";
  fill(255);
  rrect(0,-0.6,-radians(30));
  rrect(0,+0.2,-radians(30)); 
  fill(0,0,255);
  rrect(0,-0.2,+radians(30));
  rrect(0,+0.6,+radians(30)); 
  break;
  
  case 2:
  s="Control: ←→↑↓";
  // double double-slits
  fill(255,0,0);
  rrect(0,-0.4,    -radians(angle));
  rrect(0,+0.4,    -radians(angle));
  fill(0,255,0);
  rrect(0,-0.4-dp,-radians(angle));
  rrect(0,+0.4-dp,-radians(angle));
  break;
  
  case 3:
  s="Control: ↑↓";
  // DNA slit
  fill(255,0,0);
  rrect(0,-0.5,    -radians(30));
  rrect(0,+0.3,    -radians(30)); 
  rrect(0,-0.1,    +radians(30));
  rrect(0,+0.7,    +radians(30)); 
  fill(0,255,0);
  rrect(0,-0.5-(dp),-radians(30));
  rrect(0,+0.3-(dp),-radians(30)); 
  rrect(0,-0.1-(dp),+radians(30));
  rrect(0,+0.7-(dp),+radians(30)); 
  break;
  
  default:
  s="Control: ↑↓T";
  float f=(triplex ? 0.8/0.9 : 1.0);
  //float f = 1.0;
  scale = 0.8;
  // DNA slit
  fill(255,0,0);
  rrect(0,-0.5,    -radians(30), scale);
  rrect(0,+0.3,    -radians(30), scale); 
  rrect(0,-0.1,    +radians(30), scale);
  rrect(0,+0.7,    +radians(30), scale); 
  fill(0,255,0);
  rrect(0,-0.5-(dp*f),-radians(30), scale);
  rrect(0,+0.3-(dp*f),-radians(30), scale); 
  rrect(0,-0.1-(dp*f),+radians(30), scale);
  rrect(0,+0.7-(dp*f),+radians(30), scale); 
  if (triplex){
  fill(0,0,255);
  rrect(0,-0.5-(dp*2*f),-radians(30), scale);
  rrect(0,+0.3-(dp*2*f),-radians(30), scale); 
  rrect(0,-0.1-(dp*2*f),+radians(30), scale);
  rrect(0,+0.7-(dp*2*f),+radians(30), scale);   
  }
  break;
  }
  
  int Nx = 100;
  int Ny = 100;
  float dx = 2.0/Nx;
  float dy = 2.0/Ny;
  //int count = 0;
  
  switch (initial){
    
    case(0):
      value = new float[Nx+1][Ny+1];
      re = new float[Nx+1][Ny+1];
      im = new float[Nx+1][Ny+1];
    case(1):
      initial++;
      break;
    default:
    
    if (initial == 1) {initial = 2; break;}
  
    // To obtain data from the left panel
    for (int i=0; i<=Nx; i++){
      for (int j=0; j<=Ny; j++){
        float x = i*2.0/Nx - 1.0;
        float y = j*2.0/Ny - 1.0;
        PVector p = xy2screen(x,y);
        color c = get(int(p.x),int(p.y));
        value[i][j]=brightness(c)/255;
      }
    }
  
    // Fourier transform
    //float[][] rho = new float[Nx+1][Ny+1];
    //float alpha = 1.7*min(Nx,Ny)*.25;
    float alpha = 1.7/scale*min(Nx,Ny)*.25;
    for (int ki=0; ki<=Nx; ki++){
      float kx = (ki*2.0/Nx - 1.0)*alpha;
      for (int kj=0; kj<=Ny; kj++){
        float ky = (kj*2.0/Ny - 1.0)*alpha;
        re[ki][kj] = 0.0;
        im[ki][kj] = 0.0;
        for (int i=0; i<=Nx; i++){
          float x = i*2.0/Nx - 1.0;
          float temp = kx * x;
          for (int j=0; j<=Ny; j++){
            float y = j*2.0/Ny - 1.0;
            if (value[i][j] == 0) continue;
            float temp2 = temp + ky * y;
            re[ki][kj] += value[i][j] * cos(temp2); 
            im[ki][kj] += value[i][j] * sin(temp2);
          }
        }
      }
    }  
    initial = 2;
    noLoop();
  }
  
  // To draw the right panel
  fill(255);
  rect(width/2.0,0,width/2.0,height);
  for (int i=0; i<=Nx; i++){
    for (int j=0; j<=Ny; j++){
      float x = i*2.0/Nx - 1.0;
      float y = j*2.0/Ny - 1.0;
      PVector p = xy2screen(x,y);
      //color c = color((re[i][j]*re[i][j]+im[i][j]*im[i][j])/Nx/Ny*70);
      color c = color((re[i][j]*re[i][j]+im[i][j]*im[i][j])/Nx/Ny*100);
      c = color(255-brightness(c));
      //color c = color(value[i][j]*255);
      stroke(c);
      fill(c);
      rect(p.x+width/2.0,p.y,convScalar(dx),convScalar(dy));
    }
  }
  stroke(255);
  line(width/2,0,width/2,height);
  PFont font = createFont("Arial",30);
  textFont(font,20);
  text(s,10,height-10);
} 


void rrect(float x, float y, float theta){
  float w=convScalar(0.8);
  float h=convScalar(0.05);
  
  PVector p, q;
  
  p = xy2screen(x,y);
  q = xy2screen(w,h);
  
  //rotateOrigin(theta);
  rotateXY(p,theta);
  rect(p.x-w/2.0,p.y-h/2.0,w,h);
  //rotateOrigin(-theta);
  rotateXY(p,-theta);
}

void rrect(float x, float y, float theta, float s){
  float w=convScalar(0.8)*s;
  float h=convScalar(0.05);
  
  PVector p, q;
  
  p = xy2screen(x*s,y*s);
  q = xy2screen(w,h);
  
  //rotateOrigin(theta);
  rotateXY(p,theta);
  rect(p.x-w/2.0,p.y-h/2.0,w,h);
  //rotateOrigin(-theta);
  rotateXY(p,-theta);
}

PVector xy2screen(float x,float y){
  
  PVector p = new PVector();
  /*
    s = max (width/2.0, height);
    -1 <= x <= 1  --> 0 <= p.x <= width/2.0 
    -1 <= y <= 1  --> 0 <= p.y <= height
  */
  float s = min (width/2.0, height);
  p.x = x * s / 2.0 + width  / 4.0;
  p.y = y * s / 2.0 + height / 2.0;
  
  return p;
}

float convScalar(float x){
  float s = min (width/2.0, height);
  float r = x * s / 2.0;
  return r;
}

void rotateOrigin(float x){
  translate(width/4, height/2);
  rotate(x);
  translate(-width/4, -height/2);
}

void rotateXY(PVector p, float x){
  PVector q;
  q = p;
  //q = xy2screen(p.x,p.y);
  translate(q.x, q.y);
  rotate(x);
  translate(-q.x, -q.y);
}

void mouseClicked(){
  sw = (sw + 1) % num_sw;
  angle = 0;
  initial = 1;
  loop();
}

void keyPressed(){
  if (key == 'T' || key == 't'){
      if (triplex) { triplex = false;}
      else {triplex = true;}
      loop();
  }
  if (key == CODED){
    switch(keyCode){
    case LEFT:
      angle += 10;
      initial = 1;
      loop();
      break;
    case RIGHT:
      angle -=10;
      initial = 1;
      loop();
      break;
    case UP: 
      dp +=0.05;
      initial = 1;
      loop();
      break;
    case DOWN:
      dp -=0.05;
      initial = 1;
      loop();
      break;
    default:
      break;
    }
  }
}
