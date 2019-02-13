//////////////////////////////////////////////////////////////////////////////////////
//WITHOUT/WITHIN: An animated toroidal supershape based on the equation for         //
//Gray's Klein Bottle by Valeria Radchenko. A continuation of a series exploring    //
//the torus form, https://vvval.wordpress.com/torus-series/.                        //
//                                                                                  //  
//REFERENCES:                                                                       //
//- Daniel Shiffman's tutorials on Spherical Geometry and Supershapes               //
//https://www.youtube.com/watch?v=RkuBWEkBrZA                                       //
//https://www.youtube.com/watch?v=akM4wMZIBWg                                       //
//                                                                                  //
//- Paul Bourke on toroidal forms, specifically the equation for Gray's Klein Bottle//
//http://paulbourke.net/geometry/toroidal/                                          //
//                                                                                  //
//- V.K's code for saving frames                                                    //
//https://forum.processing.org/one/topic/saving-multiple-images-on-keypressed.html  //
//////////////////////////////////////////////////////////////////////////////////////

//3D SETUP
import peasy.*;
PeasyCam cam;
//TORUS VARIABLES
float a = 2;
float n = 2;
float m = 1;
float achange = 0;
//DETAIL
int total = 150;
//SCALING
int s = 50;
//ARRAY
PVector [][] torus;
//COUNTER FOR SAVING FRAMES
int number = 0;

void setup(){
  size(700,700,P3D);
  cam = new PeasyCam(this, 300);
  torus = new PVector [total+1][total+1];
  colorMode(HSB);
}

void draw(){
  background(0);
  lights();
  scale(s, s, s);
  
//MOVEMENT: EXPANDING AND CONTRACTING, FOLDING IN AND OUT OF ITSELF
  n = map(cos(achange+2), .5, 8, .5, 8);
  achange += 0.015;
  
 if ((n<0.24) || (n>-.24)){
   a = map(sin(achange), 0.2, 5, 1.2, 9);
 }
 else {
   a = map(sin(achange), noise(.6), 8, 0, 5);
 }

//CALCULATIONS AND SETTING UP ARRAY
  for (int i = 0; i < total+1; i++){                  
    float u = map(i, 0, total, 0, TWO_PI*2);    
    for (int j = 0; j < total+1; j++){
    float v = map(j, 0, total, 0, TWO_PI);
    //GRAY'S KLEIN BOTTLE EQUATION
    float x = (a + cos(n*u/2.0)*sin(v)-sin(n*u/2.0)*sin(2*v))*cos(m*u/2.0);                                   
    float y = (a + cos(n*u/2.0)*sin(v)-sin(n*u/2.0)*sin(2*v))*sin(m*u/2.0);
    float z = sin(n*u/2.0)*sin(v)+cos(n*u/2.0)*sin(2*v);
    torus [i][j] = new PVector(x,y,z);
    }}
    
//CREATING THE SHAPE
   for (int i = 0; i < total; i++){ 
    float hu = map(i, 0, total, 0, 255*2);  
    fill(hu% 255, 255, 255, 150);
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < total+1; j++){
    PVector v1 = torus[i][j];               
    vertex(v1.x,v1.y,v1.z);
    PVector v2 = torus[i+1][j];             
    vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
}
//SAVE FRAME
void keyPressed(){
  if(key == 's'){
    String s = "screen" + nf(number,4) +".tif";
    save(s);
    number++;
  }
}
