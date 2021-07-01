/**********************************
        Diffraction Simulator
        (c) K. Sinagire, 2021
***********************************/

int initial = 1;

Simulator sim;
PatternControl pat;

void settings(){
  size(640, 320);
}

void setup(){
  sim = new Simulator();
  pat = new PatternControl ();
  final String file = "data/datalist.txt";
  String[] lines = loadStrings(file);
  if (lines == null){
    javax.swing.JOptionPane.showMessageDialog(null, "Could not open \"" + file + "\".");
    exit();
  }
  for (int i = 0; i < lines.length; i++){
      Pattern p = new Pattern(lines[i]);
      if (p.isValid()) {pat.add(p);}
  }
}

void draw() { 
  background(0);
  stroke(255);
  fill(255);
  
  pat.getcur().show();
  
  
  int iold = 0;

  switch (initial){
    case(0):
    // In this stage, the program omit the
    // calculation for the renewed pattern,
    // and shows the previous results
    // in the right panel to reflect the change
    // in the left panel quickly.
      float intensity = pat.get(iold).getIntensity();
      sim.show(intensity);
      break;
    case(1):
    // Recalculate for the right panel.
      iold = pat.getIndex();
      sim.scan();
      float scale   = pat.getcur().getScale();
      float zoomout = pat.getcur().getZoomout();
      sim.calculate(scale, zoomout);
      intensity = pat.get(iold).getIntensity();
      sim.show(intensity);
      noLoop();
      break;
    default:
      break;
  }

  initial++;
  //println(initial);

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
