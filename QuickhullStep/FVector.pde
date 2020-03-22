float dot(float[] a, float[] b){
  float sum = 0;
  for(int i = 0; i < a.length; i++){
    sum += a[i] * b[i];
  }
  return sum;
}

float faceDist(float[] p, Simplex f){
  return f.offset + dot(f.normal, p);//because n dot p = |n||p|cosθ=|p|cosθ=distance between origin and position
}

float[] add(float[] a, float[] b){
  float[] result = new float[a.length];
  for (int i = 0; i < a.length; i++)
  {
    result[i] = a[i] + b[i];
  }
  return result;
}

float[] sub(float[] a, float[] b){
  float[] result = new float[a.length];
  for (int i = 0; i < a.length; i++)
  {
    result[i] = a[i] - b[i];
  }
  return result;
}

float[] normalize(float[] v){
  float norm = mag(v);
  for(int i = 0; i < v.length; i++){
    v[i] /= norm;
  }
  return v;
}

float mag(float[] v){
  return sqrt(sqrMag(v));
}

float sqrMag(float[] v){
  float sum = 0;
  for(int i = 0; i < v.length; i++){
    sum += v[i]*v[i];
  }
  return sum;
}

float dist(float[] a, float[] b){
  return sqrt(sqrDist(a, b));
}

float sqrDist(float[] a, float[] b){
  int dim_ = min(a.length, b.length);
  float sum = 0;
  for(int i = 0; i < dim_; i++){
    float x = a[i] - b[i];
    sum += x * x;
  }
  return sum;
}

float[] avg(float[] ... vecs){
  float[] result = new float[vecs[0].length];
  for(int i = 0; i < vecs.length; i++){
    float[] v = vecs[i];
    for(int j = 0; j < v.length; j++){
      result[j] += v[j];
    }
  }
  return result;
}

float[] mult(float[] v, float x){
  float[] result = new float[v.length];
  for(int i = 0; i < v.length; i++){
    result[i] = v[i] * x;
  }
  return result;
}

float[] div(float[] v, float x){
  return mult(v, 1f/x);
}

float[] calcNormal(Vertex ... vertices){
  switch(vertices.length){
    case 2:
      return calcNormal2D(vertices[0], vertices[1]);
    case 3:
      return calcNormal3D(vertices[0], vertices[1], vertices[2]);
    case 4:
      throw new IllegalArgumentException("this component will be implement");
    default:
      throw new IllegalArgumentException("Invalid number of dimension for Simplex:"+vertices.length);
  }
}

float[] calcNormal2D(Vertex v0, Vertex v1){
  float[] ntX = sub(v0.pos, v1.pos);
  float[] n = new float[2];
  n[0] = -ntX[1];
  n[1] = ntX[0];
  
  return normalize(n);
}

float[] calcNormal3D(Vertex v0, Vertex v1, Vertex v2){
  float[] ntX = sub(v1.pos, v0.pos);
  float[] ntY = sub(v2.pos, v1.pos);
  
  float[] n = new float[3];
  n[0] = ntX[1]*ntY[2] - ntX[2]*ntY[1];
  n[1] = ntX[2]*ntY[0] - ntX[0]*ntY[2];
  n[2] = ntX[0]*ntY[1] - ntX[1]*ntY[0];
  
  return normalize(n);
}