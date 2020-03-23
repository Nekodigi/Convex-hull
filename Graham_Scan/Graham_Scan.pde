import java.util.Arrays;
import java.util.Random;
import java.util.Collections;
import java.util.Comparator;

//const
int point_count = 1000;
int point_size = 20;
int speed = 500;

//valiable
int[] sorted_index = new int[point_count+1];
PVector[] points = new PVector[point_count];
float[] thetas = new float[point_count];
ArrayList<Integer> plists = new ArrayList<Integer>();
void setup(){
  fullScreen();
  frameRate(speed);
  //createPoint
  for(int i = 0; i < point_count; i++){
    Random r = new Random();
    PVector point = new PVector(mapAndConstrain((float)r.nextGaussian(), -5, 5, 0, width), mapAndConstrain((float)r.nextGaussian(),-5,5,0,height));
    points[i] = point;
  }
  //findMinYPoint
  float minY = Float.POSITIVE_INFINITY;
  int minID = 0;
  for(int i = 0; i < points.length; i++){
    if(minY > points[i].y){
      minY = points[i].y;
      minID = i; 
    }
  }
  plists.add(minID);
  //sort_min_theta
  for(int i = 0; i < point_count; i++){
    int endid = plists.get(0);
    float theta = atan2(points[i].y-points[endid].y, points[i].x-points[endid].x);
    thetas[i] = theta;
  }
  //sorted_index = argsort(thetas);
  System.arraycopy(argsort(thetas), 0, sorted_index, 0, point_count);
  sorted_index[point_count] = plists.get(0);
  plists.add(sorted_index[1]);
}

void draw(){
  background(255);
  fill(0);
  noStroke();
  int target_id = sorted_index[1+frameCount%(point_count)];
  for(int i = 0; i < points.length; i++){
    if(i < 1+frameCount){
      fill(0, 0, 255);
    }
    else{
      fill(0);
    }
    drawPoint(sorted_index[i]);
  }
  drawPoint(plists.get(0), 50);
  stroke(0, 255, 0);
  strokeWeight(5);
  drawLine(plists.get(0), target_id);
  noStroke();
  fill(255, 0, 0);
  drawPoint(target_id, 30);
  plists.add(target_id);
  noFill();
  stroke(0);
  strokeWeight(10);
  PVector temp1 = points[plists.get(plists.size()-1)];
  PVector temp2 = points[plists.get(plists.size()-2)];
  PVector temp3 = points[plists.get(plists.size()-3)];
  PVector v1 = PVector.sub(temp2, temp3);
  PVector v2 = PVector.sub(temp1, temp2);
  float crossed = v1.x * v2.y - v1.y * v2.x;
  if(frameCount%(point_count+1) != point_count-1){
  while(crossed < 0){
    plists.remove(plists.size()-2);
    temp1 = points[plists.get(plists.size()-1)];
    temp2 = points[plists.get(plists.size()-2)];
    temp3 = points[plists.get(plists.size()-3)];
    v1 = PVector.sub(temp2, temp3);
    v2 = PVector.sub(temp1, temp2);
    crossed = v1.x * v2.y - v1.y * v2.x;
  }
  }
  else{
    beginShape();
    for(int i : plists){
      vertex(points[i].x, height-points[i].y);
    }
    endShape();
    frameRate(0);
  }
  beginShape();
  for(int i : plists){
    vertex(points[i].x, height-points[i].y);
  }
  endShape();
}