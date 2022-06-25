class Pendulum{
  PVector origin;
  PVector bob;
  float diameter;
  float len;
  float angle;
  color fillColor;
  float angularVelocity;
  float angularAcc;
  boolean dragging;
  
  Pendulum(PVector origin, float len, float diameter, float angle, color fillColor){
    this.origin = origin;
    this.len = len;
    this.diameter = diameter;
    this.angle = angle;
    this.fillColor = fillColor;
    this.dragging = false;
  }
  void start(){
    update();
    drag();
    show();
  }
  
  void update(){
    if(!dragging){
      gravity = 0.4;                            
      angularAcc = (-1*gravity/len)*sin(angle);  
      angularVelocity += angularAcc;
      angularVelocity*=0.995;                   
      angle+=angularVelocity;
    }
  }
  
  void show(){
    bob = new PVector();
    bob.x = origin.x + len*sin(angle);
    bob.y = origin.y + len*cos(angle);
    stroke(0);
    strokeWeight(2);
    line(origin.x, origin.y, bob.x, bob.y);
    fill(fillColor);
    if(dragging)fill(175);
    circle(bob.x, bob.y, diameter);   
  }
  
  void clicked(int mx, int my){
    float d = dist(mx, my, bob.x, bob.y);
    if(d < diameter/2)dragging = true;
  }
  
  void stopDragging(){
    if(dragging){
      angularVelocity = 0;
      dragging = false;
    }
  }
  
  void drag(){
    if(dragging){   
      PVector newPosition = new PVector(mouseX, mouseY);
      if(origin.x == newPosition.x){
        if(origin.y <= newPosition.y)angle = 0;
        else angle = PI;
        len = abs(origin.y-newPosition.y);
      }
      else{
        float newLen = dist(origin.x, origin.y, newPosition.x, newPosition.y);
        float h = dist(origin.x, origin.y, origin.x, newPosition.y);
        angle = acos(h/newLen);
        if(newPosition.x < origin.x && newPosition.y < origin.y)angle= -PI -angle;
        if(newPosition.x > origin.x && newPosition.y < origin.y)angle= PI -angle;
        else if(newPosition.x < origin.x)angle*=-1; 
        len = newLen;
      }
      
    }
  }    
}
