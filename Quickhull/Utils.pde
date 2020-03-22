import java.util.Comparator;

float[][] extractPos(Vertex ... vertices){
  float[][] result = new float[vertices.length][];
  for(int i = 0; i < vertices.length; i++){
    result[i] = vertices[i].pos;
  }
  return result;
}

ArrayList<Vertex> getNotIth(ArrayList<Vertex> vs, int i){
  ArrayList<Vertex> result = new ArrayList<Vertex>();
  for(int j = 0; j < vs.size(); j++){
    if(j == i){continue;}
    result.add(vs.get(j));
  }
  return result;
}

class VertexIdComparator implements Comparator<Vertex> {
  @Override
  public int compare(Vertex a, Vertex b) {
    return 0;
  }
}