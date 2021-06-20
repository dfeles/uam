let img;
let smallPoint, largePoint;
let canvas = document.getElementById('myP5Canvas');

function preload() {
  img = loadImage('assets/mtn.png');
}

function setup() {
  noiseDetail(40);
  createCanvas(windowWidth, windowHeight);
  background(20);
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  img.loadPixels();

  var largestPoint = [createVector()];
  var noiseMap = [];
  for(var y=0; y< windowHeight; y++) {
    var nextPoint = largestPoint[largestPoint.length - 1].copy();
    var actPoint = largestPoint[largestPoint.length - 1];
    for(var x=0; x< windowWidth; x++) {
      let no = noise(x/500, y/500);
      let c = color(no*255,no*255,no*255);
      noiseMap.push(no);
      
      if(nextPoint.z < no) {
        nextPoint.x = x;
        nextPoint.y = y;
        nextPoint.z = no;
      }
      fill(c);
      rect(x,y, 1,1);
    }
    if(dist(actPoint.x, actPoint.y, nextPoint.x, nextPoint.y) > 100) {
      largestPoint.push(nextPoint);
      nextPoint.z = 0;
    }
  }
  var strokeColor = color("#ff0000");
  largestPoint.forEach(point => {
    fill("#222");
    // noFill();
    stroke(strokeColor);
    beginShape();
    vertex(0, windowHeight);
    for(var x = 0; x< windowWidth; x++) {
      if(x==0 || x == windowWidth-1) {

        print(x + point.y*windowHeight);
      }
      let noise = noiseMap[x + point.y*windowHeight];
      vertex(x,point.y - noise*500 + 500 );
      
    }
    
    vertex(windowWidth, windowHeight);
    endShape(CLOSE);
    circle(point.x,point.y, 10);
    strokeColor = color(random()*255,random()*255, 0);
    

  });
}

function draw() {
}

function windowResized() {
  background(20);
  resizeCanvas(windowWidth, windowHeight);
}
