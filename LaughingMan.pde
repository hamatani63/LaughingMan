import java.awt.Rectangle;
import hypermedia.video.*;
import processing.video.*;

OpenCV opencv;
PImage lman;
Movie myMovie;


void setup() {

    size( 640, 480 );

    opencv = new OpenCV(this);
    opencv.capture( width, height );                   // open video stream
    opencv.cascade( OpenCV.CASCADE_FRONTALFACE_ALT );  // load detection description, here-> front face detection : "haarcascade_frontalface_alt.xml"
    
    //静止画で顔を隠す場合
    lman = loadImage("Laughing.gif");
    
    //動画で顔を隠す場合
    //myMovie = new Movie(this, "Laughing.mov");
    //myMovie.loop();
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}


void draw() {

    // grab a new frame
    opencv.read();

    // proceed detection
    Rectangle[] faces = opencv.detect( 1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );

    // display the image
    image( opencv.image(), 0, 0 );

    // draw face area(s)

    for( int i=0; i<faces.length; i++ ) {
      //静止画で顔を隠す
      image(lman, faces[i].x-faces[i].width*.15, faces[i].y-faces[i].height*.3, faces[i].width*1.4, faces[i].height*1.4);
      //動画で顔を隠す
      //image(myMovie, faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }

}





