class ExampleHull{
  int numVertices = 100;
  float size = 800;
  ConvexHull hull;
  ArrayList<Vertex> vertices = new ArrayList<Vertex>();
  int seed = 0;
  
  ExampleHull(int dim){
    randomSeed(seed);
    for(int i = 0; i < numVertices; i++){
      switch(dim){
        case 2:
          vertices.add(new Vertex(0, random(-size, size), random(-size, size)));//id will be assigned later
          break;
        case 3:
          vertices.add(new Vertex(0, random(-size, size), random(-size, size), random(-size, size)));//id will be assigned later
          break;
        case 4:
          vertices.add(new Vertex(0, random(-size, size), random(-size, size), random(-size, size), random(-size, size)));//id will be assigned later
          break;
      }
    }
    
    hull = new ConvexHull(dim);
    hull.Generate(vertices);
  }
  
  void show(){
    stroke(255);
    for(Vertex vertex : vertices){
      point(vertex.pos);
    }
    stroke(255, 0, 0);
    point(hull.centroid);
    stroke(0);
    noFill();
    for(Simplex simplex : hull.simplexes){
      simplex.show();
    }
  }
}