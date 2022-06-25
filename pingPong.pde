class PingPong{
  PVector center;
  float velocity = 0;
  float acc = 0;
  float gravity = 1;
  float diameter;
  color fillColor;
  boolean dragging = false;
  float time = 1;
  boolean falling = true, startBounce = false;
  PingPong(float diameter, color fillColor){
    this.diameter = diameter;
    this.fillColor = fillColor;
    center = new PVector(width/2, height-diameter/2); 
  }
  
  void start(){
    update();
    drag();
    show();
  }
  
  void update(){
    if(!dragging){
      time+=0.1;
      acc=gravity*time;
      if(falling)velocity +=acc;
      else velocity-=acc;
      if(velocity<=0){
        falling = true;
        time=1;
      }
      velocity*=0.995;
    }
  }
  
  void show(){
    fill(fillColor);
    if(dragging)fill(175);
    if(!dragging && center.y<height-diameter/2 && falling)center.y+=(velocity*.2+0.5*gravity*.2*.2);
    else if(!dragging && startBounce){
      falling = false;
      center.y-=(velocity*.2+0.5*gravity*.2*.2);
    }
    circle(center.x, center.y, diameter);
  }
  
  void clicked(int mx, int my){
    float d = dist(mx, my, center.x, center.y);
    if(d < diameter/2)dragging = true;
  }
  
  void stopDragging(){
    if(dragging){
      velocity = 0;
      time = 0;
      acc = 0;
      dragging = false;      
      falling = true;
      startBounce = true;
    }
  }
  
  void drag(){
    if(dragging){
      center.x = mouseX;
      center.y = mouseY;
    }
  }
}
