import org.firmata.*;
import cc.arduino.*;

/*

  a very simple example that draws the camera pixels
  to the screen using the pixel[] array.

 last tested to work in Processing 0090
 
 JTNIMOY
 
 */
 
import JMyron.*;
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

JMyron m;//a camera object
int w=0;
int n=0;

void setup(){
  size(640,480);
  m = new JMyron();//make a new instance of the object
  m.start(width,height);//start a capture at 320x240
  m.findGlobs(0);//disable the intelligence to speed up frame rate
  println("Myron " + m.version()); 
  println(Arduino.list());
  arduino = new Arduino(this, "COM8", 57600);
  arduino.pinMode(13, Arduino.INPUT);

  

}

void draw(){
 
  m.update();//update the camera view
  int[] img = m.image(); //get the normal image of the camera
  loadPixels();
  for(int i=0;i<width*height;i++){ //loop through all the pixels
      pixels[i] = img[i]; //draw each pixel to the screen
  } 

  
  
  if(arduino.digitalRead(13)==Arduino.LOW){
    if(w==0)
    {
     
      w++;
    }
  }
  else
  {
    if(w>0)
    {
     
       n++;
       save("image"+n+".jpg");
      w=0;
      
        
    }
  }
  updatePixels();
}


public void stop(){
  m.stop();//stop the object
  super.stop();
}
