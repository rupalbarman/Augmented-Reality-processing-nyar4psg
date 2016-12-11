// uses and demonstrates other attributes of nyar4psg

import jp.nyatla.nyar4psg.*;
import processing.video.*;

Capture cam;
MultiMarker marker;

void setup()
{
  size(640, 480, P3D);
  marker= new MultiMarker(this, width, height, "/data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  marker.addARMarker("/data/patt.hiro", 80);
  marker.addARMarker("/data/patt.kanji", 80);
  
  cam= new Capture(this, width, height);
  cam.start();
  
  frameRate(30);
}

void draw()
{
  //Display the camera's feed
  if (cam.available())
    cam.read();
  image(cam, 0, 0, width, height);
  
  //Detects markers from the live camera feed
  marker.detect(cam);
  
  for(int i=0;i<2;i++) {
  if (marker.isExist(i)) {

        //Set the AR perspective (required for a match in our world's perspective)
        //marker.setARPerspective();
        
        //get coordinates
        PVector [] pos2d = marker.getMarkerVertex2D(i);
        //draw coordinates
        ellipse(pos2d[0].x,pos2d[0].y,10,10);
        ellipse(pos2d[1].x,pos2d[1].y,10,10);
        ellipse(pos2d[2].x,pos2d[2].y,10,10);
        ellipse(pos2d[3].x,pos2d[3].y,10,10);
        
        marker.beginTransform(i);
        translate(0, 0, 40);
        lights();
        perspective();
        sphere(40);
        marker.endTransform();
    }
  }
}