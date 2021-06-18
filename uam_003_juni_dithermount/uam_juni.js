let img;
let smallPoint, largePoint;
let canvas = document.getElementById('myP5Canvas');

function preload() {
  img = loadImage('assets/mtn.png');
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(20);
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  img.loadPixels();
}

function draw() {
  for(var i=0; i< 10000; i++) {
    let pointillize = map(mouseX, 0, width, smallPoint, largePoint);
    let x = floor(random(img.width));
    let y = floor(random(img.height));
    let pix = img.get(x, y);
    fill(pix, 128);
    rect(round(x/pointillize)*pointillize, round(y/pointillize)*pointillize, pointillize, pointillize);
  }
}

function windowResized() {
  background(20);
  resizeCanvas(windowWidth, windowHeight);
}
