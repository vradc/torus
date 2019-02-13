//torus based on shiffman spherical geometry and superhsape video 
// and paulbourke on torus'
import peasy.*;
PeasyCam cam;
float r0 = 150;
float r1 = 80;
float n1 = 1.0;
float n2 = 1.0;
int total = 40;
PVector [][] torus;

void setup(){
  size(600,600,P3D);
  cam = new PeasyCam(this, 200);
  torus = new PVector [total+1][total+1];
  colorMode(HSB);
}
  
void draw(){
  background(0);
  lights();
//calculations + setting up array
  for (int i = 0; i < total+1; i++){                  
    float lat = map(i, 0, total, 0, TWO_PI);    
    for (int j = 0; j < total+1; j++){
    float lon = map(j, 0, total, 0, TWO_PI);
    float x = pow(cos(lon),n1) * (r0 + r1 * pow(cos(lat),n2));                                   
    float y = pow(sin(lon),n1)*(r0 + r1 * pow(cos(lat),n2));
    float z = r1* pow(sin(lat), n2);
    torus [i][j] = new PVector(x,y,z);
    }}
    
    
//using array to set triangle strip mesh
   for (int i = 0; i < total; i++){  
    float hu = map(i, 0, total, 0, 255*6);
    fill(hu% 255, 255, 255);
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < total+1; j++){
    PVector v1 = torus[i][j];     //1st lon
    vertex(v1.x,v1.y,v1.z);
    PVector v2 = torus[i+1][j];   //1st lat
    vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
}
