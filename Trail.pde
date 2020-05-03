class Trail{
   
  int x, y, size, speed; 
  color c; 
  
  Trail(int x, int y){
    this.x = x; 
    this.y = y; 
    size = 30; 
    speed = 5; 
    //c = color(#EE08FF); 
    colorMode(HSB); 
    float diff = map(getEasedSensorValue(), minInput,maxInput,0,50); 
    //float diff = map(mouseX,0,width,0,50); 
    c = color(diff,255,255); 
    colorMode(RGB); 
  }
  void update(){
      fill(c); 
      ellipse(x,y,size,size); 
      x-= speed; 
      size--; 
      if (size <= 0) size = 1; 
  }
  
}