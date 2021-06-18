/**
 * Dithering
 * by Daniel Feles. 
 */

PImage img, img2;
int smallPoint, largePoint;

float steps = 8;
int factor = 3;
float scale = 0;
float ww = 1400;

float thres = .9;


void settings() {
  img = loadImage("ov.jpg");
  img.filter(GRAY);
  if (scale != 0) {
    img.resize(int(img.width * scale), int(img.height * scale));
  }
  if (ww != 0) {
    float ratio = img.height/img.width;
    img.resize(int(ww), int(ww*ratio));
  }
  img2 = img.copy();
  size(img.width, img.height);
  pixelDensity(2);
}

int index(int x, int y) {
  return x + y * img.width;
}

void setIndex (int index, float quantError, float errR, float errG, float errB) {
  if (index > img2.pixels.length-1) return;
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
  color c = color(round(factor * r / 255) * (255/factor), round(factor * g / 255) * (255/factor), round(factor * b / 255) * (255/factor));


  return c;
}

void setup() {  
  imageMode(CENTER);
  noStroke();
  //img2.filter(GRAY);
  //background(#333333);

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
      setIndex(index(x, y+sint), 5/16.0, errR, errG, errB); // 5/16.0
      setIndex(index(x+sint, y+sint), 1/16.0, errR, errG, errB);

    }
  }
  
  
  //for (int y = 0; y < img.height-1; y+=steps) {
  //  for (int x = 1; x < img.width-1; x+=steps) {
      
  //    if (red(img2.pixels[index(x, y)])/255.0 + random(-.1, .1)  > 1.5) {
  //    } else {
  //      fill(img2.pixels[index(x, y)]);
  //      fill(colors[round(red(img2.pixels[index(x, y)])/.7/255.0 * 6 % 5)]);
  //      //fill(colors[abs(floor(index(y+int(random(-5,5)), x+int(random(-5,5)))/100000.0) % 6)]);
  //      //strokeWeight(1);
  //      //noFill();
  //      //noStroke();
  //      rect(x, y, steps, steps);
  //    }
  //  }
  //}
  
  float animLength = 1;
  for(int nn = 0; nn < animLength; nn++) {
  //for (int y = 0; y < img.height-1; y+=steps) {
  //  for (int x = 1; x < img.width-1; x+=steps) {
      
  //    if (red(img2.pixels[index(x, y)])/255.0 + random(-.1, .1)  > thres) {
  //    } else {
  //      fill(img2.pixels[index(x, y)]);
  //      //fill(colors[round(red(img2.pixels[index(x, y)])/.7/255.0 * 6 % 5)]);
  //      //fill(colors[abs(floor(index(y+int(random(-5,5)), x+int(random(-5,5)))/100000.0) % 6)]);
  //      //strokeWeight(1);
  //      //noFill();
  //      //noStroke();
  //      rect(x, y, steps, steps);
  //    }
  //  }
  //}
  for (int y = 0; y < img.height-1; y+=steps/2) {
    for (int x = 1; x < img.width-1; x+=steps/2) {
      
      if (red(img2.pixels[index(x, y)])/255.0 + random(-.1, .1)  > .5) {
      } else {
        fill(img2.pixels[index(x, y)]);
        //fill(colors[round(red(img2.pixels[index(x, y)])/.7/255.0 * 6 % 5)]);
        //fill(colors[abs(floor(index(y+int(random(-5,5)), x+int(random(-5,5)))/100000.0) % 6)]);
        //strokeWeight(1);
        //noFill();
        //noStroke();
        rect(x, y, steps/2, steps/2);
      }
    }
  }
  
  for (int y = 0; y < img.height-1; y+=steps/4) {
    for (int x = 1; x < img.width-1; x+=steps/4) {
      
      if (red(img2.pixels[index(x, y)])/255.0  > 1 || red(img2.pixels[index(x, y)])/255.0  < .75) {
        
        fill(img2.pixels[index(x, y)]);
      } else {
        //fill(img2.pixels[index(x, y)]);
        fill(colors[round(red(img2.pixels[index(x, y)])/.7/255.0 * 30 % 5)]);
        //fill(colors[abs(floor(index(y+int(random(-5,5)), x+int(random(-5,5)))/100000.0) % 6)]);
        //strokeWeight(1);
        //noFill();
        //noStroke();
      }
      rect(x, y, steps/2, steps/2);
    }
  }
  saveFrame("anim/dithering###.png");
  }
}

color[] colors = {#750787, #e40303, #ff8c00, #ffed00, #008026, #004dff};
//color[] colors = {#202020, #202020, #202020, #7AFAD7, #7AFAD7, #7AFAD7};
//color[] colors = {#333333, #e40303, #e40303, #000000, #008026, #004dff};
//color[] colors = {#000000, #e40303, #e40303, #e40303, #e40303, #e40303};

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
