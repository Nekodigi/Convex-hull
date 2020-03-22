//based on this code 

boolean mode3D = false;

ExampleHull hull2D = new ExampleHull(2);
ExampleHull hull3D = new ExampleHull(3);

void setup(){
  fullScreen(P3D);
  //size(500, 500, P3D);
  ortho();
}

void keyPressed(){
  if(key == 'm'){
    mode3D = !mode3D;
  }
}

void draw(){
  background(200);
  translate(width/2, height/2);
  if(mode3D){
    rotateX(float(frameCount)/100);
    rotateY(float(frameCount)/500);
    rotateZ(float(frameCount)/1000);
    hull3D.show();
  }else{
    hull2D.show();
  }
}