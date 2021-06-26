/**********************************
        Diffraction Simulator
        (c) K. Sinagire, 2021
***********************************/

int num_sw = 5;
int initial = 0;
int sw = 0;
int angle = 0;
float dp = 0.3;

Simulator sim;
//Pattern pat;
//ArrayList<Pattern> pat;
PatternControl pat;

void settings(){
  size(640, 320);
}

void setup(){
  sim = new Simulator();
  pat = new PatternControl ();
  pat.add(new Pattern("data/doubleSlit.data"));
  pat.add(new Pattern("data/Wslit.data"));
  pat.add(new Pattern("data/twoDS.data"));
  pat.add(new Pattern("data/DNA.data"));
  pat.add(new Pattern("data/DNA2.data"));
  pat.add(new Pattern("data/DNA3.data"));
}

void draw() { 
  background(0);
  stroke(255);
  fill(255);
  
  float scale = 1.0;
  
  pat.getcur().show();
  
  
  switch (initial){
    
    case(0):
    case(1):
      initial++;
      break;
    default:
    
    if (initial == 1) {initial = 2; break;}
    sim.scan();
    sim.calculate(pat.getcur().getScale());
    initial = 2;
    noLoop();
  }
  sim.show();

  PFont font = createFont("Helvetica",30);
  textFont(font,20);
  String s=pat.getcur().get_s();
  text(s,10,height-10);
} 

/*
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
  
  //  s = max (width/2.0, height);
  //  -1 <= x <= 1  --> 0 <= p.x <= width/2.0 
  //  -1 <= y <= 1  --> 0 <= p.y <= height
  
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
*/

void mouseClicked(){
  initial = 1;
  pat.step();
  loop();
}

void keyPressed(){
  if (key == CODED){
    switch(keyCode){
    case LEFT:
      pat.getcur().step("^h",-1);
      initial = 1;
      loop();
      break;
    case RIGHT:
      pat.getcur().step("^h", 1);
      initial = 1;
      loop();
      break;
    case UP: 
      pat.getcur().step("^v", 1);
      initial = 1;
      loop();
      break;
    case DOWN:
      pat.getcur().step("^v",-1);
      initial = 1;
      loop();
      break;
    default:
      break;
    }
  }
}
