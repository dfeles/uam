/**
 * Dithering
 * by Daniel Feles. 
 */

PImage img, img2;
int smallPoint, largePoint;

float steps = 2;
int factor = 4;


void settings() {
  img = loadImage("Trump-1-2-1.jpg");
  img2 = img.copy();
  size(img.width, img.height);
  pixelDensity(2);
}

int index(int x, int y) {
  return x + y * img.width;
}

void setIndex (int index, float quantError, float errR, float errG, float errB) {
  if(index > img2.pixels.length-1) return;
  color c = img2.pixels[index];
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  r = r + errR * quantError;
  g = g + errG * quantError;
  b = b + errB * quantError;
  img2.pixels[index] = color(r, g, b);
}

color getColorFromPalette(float r, float g, float b) {
  color c = color(round(factor * r / 255) * (255/factor),round(factor * g / 255) * (255/factor),round(factor * b / 255) * (255/factor));

  
  return c;
}

void setup() {  
  imageMode(CENTER);
  noStroke();
  img2.filter(INVERT);
  background(0);
  
  for (int y = 0; y < img.height-1; y+=steps) {
    for (int x = 1; x < img.width-1; x+=steps) {
      color pix = img2.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);
      img2.pixels[index(x, y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      int sint = int(steps);
      setIndex(index(x+sint, y     ), 7/16.0, errR, errG, errB);
      setIndex(index(x-sint, y+sint), 3/16.0, errR, errG, errB); // 3/16
      setIndex(index(x     , y+sint), 5/16.0, errR, errG, errB); // 5/16.0
      setIndex(index(x+sint, y+sint), 1/16.0, errR, errG, errB);
      
      
      if(red(img2.pixels[index(x,y)])/255.0  > 0.4) {

      } else {
        fill(255);
        fill(colors[abs(floor(index(y+int(random(-5,5)), x+int(random(-5,5)))/100000.0) % 6)]);
        //strokeWeight(1);
        //noFill();
        //noStroke();
        circle(x+random(-1,1),y+random(-1,1),2);
      }
    }
  }
}

color[] colors = {#e40303, #ff8c00, #ffed00, #008026, #004dff, #750787};

int n = 0;
void draw() { 

  //fill(255);
  //rect(0,0,width,height);
  //println(n);
  //n++;
  for (int y = 0; y < img.height-1; y+=steps) {
    for (int x = 1; x < img.width-1; x+=steps) {
      
    }
  }
}
