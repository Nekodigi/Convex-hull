//based on this code https://github.com/Scrawk/Hull-Delaunay-Voronoi

boolean mode3D = false;

ArrayList<Vertex> shapeA = new ArrayList<Vertex>(), shapeB = new ArrayList<Vertex>();
ExampleHull hull2D = new ExampleHull(2);
ExampleHull hull3D = new ExampleHull(3);
//ExampleHull hull4D = new ExampleHull(4);
ConvexHull hull = new ConvexHull(2);

void setup(){
  //fullScreen(P3D);
  size(500, 500, P3D);
  ortho();
  strokeWeight(10);
  shapeA.add(new Vertex(0, 200, 200));
  shapeA.add(new Vertex(0, 300, 200));
  shapeA.add(new Vertex(0, 200, 300));
  shapeB.add(new Vertex(0, 100, 0));
  shapeB.add(new Vertex(0, 0, 100));
  shapeB.add(new Vertex(0, 100, 100));//based on this site https://github.com/udacity/RoboND-MinkowskiSum/blob/master/src/minkowski_sum.cpp
  ArrayList<Vertex> C = new ArrayList<Vertex>();
  for(Vertex va : shapeA){
    for(Vertex vb : shapeB){
      C.add(new Vertex(0, add(va.pos, vb.pos)));
    }
  }
  hull.Generate(C);
  beginShape();
  for(Vertex v : shapeA){
    vertex(v.pos[0], v.pos[1]);
  }
  endShape(CLOSE);
  beginShape();
  for(Vertex v : shapeB){
    vertex(v.pos[0], v.pos[1]);
  }
  endShape(CLOSE);
  for(Simplex simplex : hull.simplexes){
    simplex.show();
  }
  //shapeA.add(new Vertex(0, 100, 100));
}

void keyPressed(){
  if(key == 'r'){
    hull2D = new ExampleHull(2);
    hull3D = new ExampleHull(3);
  }
  if(key == 'm'){
    mode3D = !mode3D;
  }
}

void draw(){
  //lights();
  //background(200);
  if(mode3D){
    rotateX(float(frameCount)/100);
    rotateY(float(frameCount)/500);
    rotateZ(float(frameCount)/1000);
    hull3D.show();
  }else{
    
  }
}
