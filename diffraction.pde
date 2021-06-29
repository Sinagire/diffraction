/**********************************
        Diffraction Simulator
        (c) K. Sinagire, 2021
***********************************/

int initial = 0;

Simulator sim;
PatternControl pat;

void settings(){
  size(640, 320);
}

void setup(){
  sim = new Simulator();
  pat = new PatternControl ();
  pat.add(new Pattern("data/Poisson.data"));
  pat.add(new Pattern("data/circle.data"));
  pat.add(new Pattern("data/circle2.data"));
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
  
  pat.getcur().show();
  
  float scale   = pat.getcur().getScale();

  switch (initial){
    case(0):
    // In this stage, the program omit the
    // calculation for the renewed pattern,
    // and shows the previous results
    // in the right panel to reflect the change
    // in the left panel quickly.
      sim.show(pat.getcur().getIntensity());
      break;
    case(1):
    // Recalculate for the right panel.
      sim.scan();
      float zoomout = pat.getcur().getZoomout();
      sim.calculate(scale, zoomout);
      sim.show(pat.getcur().getIntensity());
      noLoop();
      break;
    default:
      break;
  }

  initial++;
  println(initial);

  PFont font = createFont("Helvetica",30);
  textFont(font,20);
  String s=pat.getcur().get_s();
  text(s,10,height-10);
} 

void mouseClicked(){
  initial = 0;
  switch(mouseButton){
    case LEFT:
      pat.step();
      break;
    case RIGHT:
      pat.step(-1);
      break;
    default:
      break;
  }  
  loop();
}

void keyPressed(){
  if (key == CODED){
    switch(keyCode){
    case LEFT:
      pat.getcur().step("^h",-1);
      initial = 0;
      loop();
      break;
    case RIGHT:
      pat.getcur().step("^h", 1);
      initial = 0;
      loop();
      break;
    case UP: 
      pat.getcur().step("^v", 1);
      initial = 0;
      loop();
      break;
    case DOWN:
      pat.getcur().step("^v",-1);
      initial = 0;
      loop();
      break;
    default:
      break;
    }
  }
}
