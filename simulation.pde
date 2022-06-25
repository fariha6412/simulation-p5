import processing.sound.*;

float len;
float diameter = 60;
float angle = 0;
PVector origin;
color fillColor = 0;
float gravity = 9.8;
Pendulum pendulum;
PingPong pingPong;
SoundWaveForm fx;
Slime slime;
boolean pendulumSimulation = false;
boolean pingPongSimulation = false;
boolean soundAnalyzer = false;
boolean slimeSimulation = false;
void setup(){
  size(640,360);
  surface.setTitle("Simulation");
  surface.setResizable(true);
  surface.setLocation(100, 100);
}

void draw(){
  background(255);
  fill(0);
  rect(20, 20, 80, 40);
  rect(20,70, 80, 40);
  rect(20,120, 80, 40);
  rect(20,170, 80, 40);
  fill(255);
  textSize(16);
  text("Pendulum", 23, 43);
  text("Ping Pong", 23, 96);
  text("Sound\nAnalyzer", 30, 134);
  text("Slime", 30, 192);
  if(pendulumSimulation)pendulum.start();
  if(pingPongSimulation)pingPong.start();
  if(soundAnalyzer)fx.play();
  if(slimeSimulation)slime.start();
}

void mousePressed(){
  if(pendulumSimulation)pendulum.clicked(mouseX, mouseY);
  if(pingPongSimulation)pingPong.clicked(mouseX, mouseY);
  if(mouseX>20 && mouseX<100 && mouseY>20 && mouseY<60){
    pendulumSimulation = true;
    pingPongSimulation = false;
    soundAnalyzer = false;
    slimeSimulation = false;
    if(fx!=null)fx.stopSound();
    origin = new PVector(width/2, 130);
    len = height/2;
    pendulum = new Pendulum(origin, len, diameter, angle, fillColor);
  }
  else if(mouseX>20 && mouseX<100 && mouseY>70 && mouseY<110){
    pingPongSimulation = true;
    pendulumSimulation = false;
    soundAnalyzer = false;
    slimeSimulation = false;
    if(fx!=null)fx.stopSound();
    pingPong = new PingPong(diameter/2.3, fillColor);
  }
  else if(mouseX>20 && mouseX<100 && mouseY>120 && mouseY<160 && !soundAnalyzer){
    soundAnalyzer = true;
    pingPongSimulation = false;
    pendulumSimulation = false;
    slimeSimulation = false;
    fx = new SoundWaveForm(this,"not_alone.mp3");
  } 
  else if(mouseX>20 && mouseX<100 && mouseY>170 && mouseY<210){
    pingPongSimulation = false;
    pendulumSimulation = false;
    soundAnalyzer = false;
    slimeSimulation = true;
    if(fx!=null)fx.stopSound();
    slime = new Slime(diameter/1.2);
  }
}
  
void mouseReleased(){
  if(pendulumSimulation)pendulum.stopDragging();
  else if(pingPongSimulation)pingPong.stopDragging();
}
