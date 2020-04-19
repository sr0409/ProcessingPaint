//Developers: Stanley Razumov, Micayla King, Allison Doggett
//Group color: Ultraviolet 
//Program Name: Processing Paint
//Date: 04/30/2020
//Credits to Ethan Smith for helping in the early to mid stages of development.

//Controls and usage info : 1. UP arrow key increases the stroke weight for the shapes up to 25 with an increment of 1 for each key press registered
//                          2. DOWN arrow key decreases the stroke weight for the shapes down to 1 with the increment of 1 for each key key press registered
//                          3. SPACE resets the image to its original state
//                          4. Click on the desired tool to use it
//                          5. The current picked color is shown as the color of the tool panel border (black by default)
//                          6. Colors can be picked from both the color spectrum on the toolbar as well as from the image itself

int sw = 5; // Stroke Weight
//Use files[0] for your desired image
String[] files = {"charlton vale 3.jpg", "png/001-pencil.png", "png/002-paintbrush.png", "png/016-paintbrush-1.png", "png/031-eyedropper.png"
, "png/024-eraser.png", "png/rectangle.png", "png/circle.png", 
"png/ellipse.png","png/triangle.png" ,"png/FruitBowl.jpg", "png/spectrum.jpg"};
PImage[] images = new PImage[files.length];
PImage grayFruit, negativeFruit, img, paintedImg, currentImg;
String fileName = files[0];
int iconMargin = 10;
int iconOffset;
int iconXOffset;
int iconYOffset;
int offset = 190;
color c = 0;
boolean pencil = true, brush = false, dropper = false,brush2 = false,eraser = false,rectangle = false,circle = false,oval = false,triangle = false;
int startX, startY, endX, endY;
int posX, posY, shapeWidth, shapeHeight;

void setup(){
  image(img,offset,0);
  
  for(int i = 0; i < files.length; i++){
    images[i] = loadImage(files[i]);
    if(i >= 1){
      images[i].resize(50,50);
    }
  }
  rectMode(CORNERS); 
  noFill();
  grayFruit = images[10].copy();
  negativeFruit = images[10].copy();
  negativeFruit.filter(INVERT);
  grayFruit.filter(GRAY);
}

public void settings(){
  img = loadImage(fileName);
  currentImg = img;
  println(img.height, " " , img.width);
  size(int(img.width+offset), int(img.height));
}

void draw(){
  //Draw toolbar
  strokeWeight(1);
  rect(0,0,offset,height);
  iconXOffset = 0;
  iconYOffset = 15;
  //Draw rows of tools
  for(int i = 1; i < images.length-2; i++){
    switch(i%3){
      case 0:
      image(images[i], iconMargin + iconXOffset, iconMargin+iconYOffset);

      iconYOffset += 55;
      iconXOffset = 0;
      break;
      case 1:
      image(images[i], iconMargin + iconXOffset, iconMargin+iconYOffset);

      iconXOffset += 60;
      break;
      case 2:
      image(images[i], iconMargin + iconXOffset, iconMargin+iconYOffset);

      iconXOffset += 60;
      break;
    }
    stroke(c);
  }
  iconYOffset+= 11;
  line(0, iconYOffset, offset, iconYOffset);
  iconYOffset+= 30;
  //Filter icons
  image(images[10], iconMargin + iconXOffset, iconMargin+iconYOffset);

  iconXOffset += 60;
  image(grayFruit, iconMargin + iconXOffset, iconMargin+iconYOffset);
  iconXOffset += 60;
  image(negativeFruit, iconMargin + iconXOffset, iconMargin+iconYOffset);
  
  //spectrum
  images[11].resize(189,190);
  image(images[11], 1, 300);
  
  //text
  fill(0);
  textSize(18);
  text("Tools",100 , 10); 
  text("Filters",100 , 200); 
  textAlign(CENTER, CENTER);
  fill(255);
  //line after text
  line(0, 22, offset, 22);
  line(0, 215, offset, 215);
  line(0, 300, offset, 300);
  //mousepressed
  if(mousePressed){
    if(pencil){
      strokeWeight(1);
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
    else if(brush){
      strokeWeight(5);
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
    else if(brush2){
      strokeWeight(10);
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
    else if(dropper){
      c = get(mouseX, mouseY);
    }
    else if(eraser){ 
      PImage target =images[0].get(mouseX-offset, mouseY, 25,25);
      image(target, mouseX, mouseY);
    }
    else if(rectangle){
      noFill();
    }
    else if(circle){
      noFill();
      ellipseMode(CORNER);  // Set ellipseMode to CORNER
    }
    else if(oval){
      noFill();
      ellipseMode(CORNERS);  // Set ellipseMode to CORNERS
    }
    else if(triangle){
       noFill();
    }
  }
  
}//end draw

void keyPressed(){
 if(key == ' '){
  image(img, offset, 0);
 }
 else if(key == CODED){
    if(keyCode == UP){
      if(sw < 25){
        sw+=1;    
      }
    }
    else if(keyCode == DOWN){
      if(sw > 1){
        sw-=1;
         
       }  
     }
  }
}//end KeyPressed

void mousePressed(){
  // Get the selected tool and coordinates

  startX = mouseX; startY = mouseY;
   if((mouseX >= 10 && mouseX <= 60)&&(mouseY >= 25 && mouseY <= 75)) {
     print("Pencil");
     pencil = true; brush=false; dropper=false; brush2=false; eraser=false; 
     rectangle=false; circle=false; oval=false; triangle=false;
   }
   if((mouseX >= 70 && mouseX <= 130)&&(mouseY >= 25 && mouseY <= 75)) {
     print("Brush");
     pencil = false; brush=true; dropper=false; brush2=false; eraser=false; 
     rectangle=false; circle=false; oval=false; triangle=false;
   }
   if((mouseX >= 130 && mouseX <= 180)&&(mouseY >= 25 && mouseY <= 75)) {
     print("brush2");
     pencil = false; brush=false; dropper=false; brush2=true; eraser=false; 
     rectangle=false; circle=false; oval=false; triangle=false;
   }
   if((mouseX >= 10 && mouseX <= 60)&&(mouseY >= 80 && mouseY <= 130)){
     print("dropper");
     pencil = false; brush=false; dropper=true; brush2=false; eraser=false; 
     rectangle=false; circle=false; oval=false; triangle=false;
   }
   if((mouseX >= 70 && mouseX <= 130)&&(mouseY >= 80 && mouseY <= 130)){ 
     print("Eraser");
     pencil = false; brush=false; dropper=false; brush2=false; eraser=true; 
     rectangle=false; circle=false; oval=false; triangle=false;
   }
   if((mouseX >= 130 && mouseX <= 180)&&(mouseY >= 80 && mouseY <= 130)){
    print("rectangle");
     pencil = false; brush=false; dropper=false; brush2=false; eraser=false; 
     rectangle=true; circle=false; oval=false; triangle=false;
   
   }
   if((mouseX >= 10 && mouseX <= 60)&&(mouseY >= 135 && mouseY <= 185)) {
    print("circle");
     pencil = false; brush=false; dropper=false; brush2=false; eraser=false; 
     rectangle=false; circle=true; oval=false; triangle=false;
   
   }
   if((mouseX >= 70 && mouseX <= 130)&&(mouseY >= 135 && mouseY <= 185)) { 
     print("Oval");
     pencil = false; brush=false; dropper=false; brush2=false; eraser=false; 
     rectangle=false; circle=false; oval=true; triangle=false;
   }
   if((mouseX >= 130 && mouseX <= 180)&&(mouseY >= 135 && mouseY <= 185)) {
    print("Triangle");
     pencil = false; brush=false; dropper=false; brush2=false; eraser=false; 
     rectangle=false; circle=false; oval=false; triangle=true;
   
   }
   
   //Filters
   if((mouseX >= 10 && mouseX <= 60)&&(mouseY >= 231 && mouseY <= 281)){
     print("Normal");
     image(img, offset, 0);
   }
   if((mouseX >= 70 && mouseX <= 120)&&(mouseY >= 231 && mouseY <= 281)){
     print("GRAY");
     currentImg = img.copy();
     currentImg.filter(GRAY);
     image(currentImg, offset, 0);
   }
   if((mouseX >= 130 && mouseX <= 180)&&(mouseY >= 231 && mouseY <= 281)){
     print("Inverse");
     currentImg = img.copy();
     currentImg.filter(INVERT);
     image(currentImg, offset, 0);
   }
}//End MousePresed

//Wrapper for drawing triangles (not perfect, but it draws triangles)
void triangleWrapper(float startx,float starty,float endx,float endy){
  strokeWeight(sw);
  triangle(startx + (endx - startx)/2,endy, startx, starty, endx, starty); 
}

void mouseReleased() {
  if (mouseX < startX) {
    endX = startX;
    startX = mouseX;
  } else {
    endX = mouseX;
  }
  if (mouseY < startY) {
    endY = startY;
    startY = mouseY;
  } else {
    endY = mouseY;
  }
  posX = startX;
  posY = startY;
  shapeWidth = mouseX;
  shapeHeight = mouseY;
  //rectangle shape handling
  if(rectangle){
    strokeWeight(sw);
    rect(startX, startY, mouseX, mouseY);

  }
  //circle shape handling
  else if(circle){
    strokeWeight(sw);
    if(endX-startX>endY-startY){
      circle(startX, startY, endX-startX);
    }
    else{
      circle(startX, startY, endY-startY);
    }
    
  }
  // Oval shape handling
  else if(oval){
   if(posX < shapeWidth){
    int temp = shapeWidth;
    shapeWidth = posX;
    posX = temp;
   }
   if(posY < shapeHeight){
    int temp = shapeHeight;
    shapeHeight = posY;
    posY = temp;
   }
   strokeWeight(sw);
    ellipse(posX, posY, shapeWidth, shapeHeight);
  }
  //triangle shape handling
  else if(triangle){
     triangleWrapper(startX, startY, endX, endY);
     
  }
} // end MouseReleased
