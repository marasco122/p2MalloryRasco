import controlP5.*;

ControlP5 cp5;

PFont font;
PFont fontMiles;
PFont fontKilo;

PImage eTempI;
PImage gasI;
PImage doorsI;
PImage seatbeltI;
PImage cruiseControlI;
PImage cruiseControlOnI;

PImage airbag;
PImage antilock;
PImage battery;
PImage engine;
PImage oil;
PImage security;
PImage tire;
PImage traction;
PImage tractionMal;

Knob speedometer;
Knob tachometer;
Knob eTemp;
Knob gas;
Button brakeP;
Button gasP;

Textlabel celLabel;
Textlabel farenLabel;
Textlabel milesLabel;
Textlabel kiloLabel;
Textlabel mphTLabel;
Textlabel kmhTLabel;
Textlabel cruiseLabel;
Textlabel rightLabel;
Textlabel leftLabel;
Textlabel emerLabel;
Textlabel warningsLabel;

Textlabel speed0Label;
Textlabel speed20Label;
Textlabel speed40Label;
Textlabel speed60Label;
Textlabel speed80Label;
Textlabel speed100Label;
Textlabel speed120Label;
Textlabel speed140Label;
Textlabel speed160Label;
Textlabel speed180Label;
Textlabel speed200Label;
Textlabel speed220Label;
Textlabel speed240Label;

Textlabel tach1Label;
Textlabel tach2Label;
Textlabel tach3Label;
Textlabel tach4Label;
Textlabel tach5Label;
Textlabel tach6Label;
Textlabel tach7Label;
Textlabel tach8Label;

char tempType = 'F';
boolean cruiseOn = false;
boolean cruiseSet = false;
boolean rightSig = false;
boolean leftSig = false;
boolean sigLightOn = false;
float startTime;
float eTempSpeed = 3000;
float lasttimecheck;
float timeinterval;
int warningChoice = -1;

Toggle cel;
Toggle faren;

Toggle mph;
Toggle kmh;

Toggle cruise;
Toggle right;
Toggle left;
Toggle emergency;
Toggle warnings;

void setup() {
  size(1000, 700);
  background(0);

  cp5 = new ControlP5(this);

  fill(255);
  font = createFont("Helvetica", 50);

  speedometer = (cp5.addKnob("speed").setRange(0, 140).setValue(0).setPosition(455, 215).setRadius(165).setFont(font)
    .setNumberOfTickMarks(14).snapToTickMarks(false).setTickMarkLength(25).setTickMarkWeight(7))
    .setColorBackground(color(0)).setColorForeground(color(255)).setColorActive(color(255));
  cp5.getController("speed").getCaptionLabel().setVisible(false); 
  
  speed0Label = cp5.addLabel("0").setColorValue(color(47, 139, 185)).setPosition(505, 430).setFont(font);
  speed20Label = cp5.addLabel("20").setColorValue(color(47, 139, 185)).setPosition(470, 360).setFont(font);
  speed40Label = cp5.addLabel("40").setColorValue(color(47, 139, 185)).setPosition(485, 280).setFont(font);
  speed60Label = cp5.addLabel("60").setColorValue(color(47, 139, 185)).setPosition(550, 230).setFont(font);
  speed80Label = cp5.addLabel("80").setColorValue(color(47, 139, 185)).setPosition(635, 230).setFont(font);
  speed100Label = cp5.addLabel("100").setColorValue(color(47, 139, 185)).setPosition(680, 280).setFont(font);
  speed120Label = cp5.addLabel("120").setColorValue(color(47, 139, 185)).setPosition(700, 360).setFont(font);
  speed140Label = cp5.addLabel("140").setColorValue(color(47, 139, 185)).setPosition(670, 430).setFont(font); 
  
  speed160Label = cp5.addLabel("160").setColorValue(color(47, 139, 185)).setVisible(false);
  speed180Label = cp5.addLabel("180").setColorValue(color(47, 139, 185)).setVisible(false);
  speed200Label = cp5.addLabel("200").setColorValue(color(47, 139, 185)).setVisible(false);
  speed220Label = cp5.addLabel("220").setColorValue(color(47, 139, 185)).setVisible(false);
  speed240Label = cp5.addLabel("240").setColorValue(color(47, 139, 185)).setVisible(false);

  tachometer = (cp5.addKnob("tach").setRange(0, 8).setValue(1).setPosition(133, 279).setRadius(132).setFont(font)
    .setNumberOfTickMarks(8).snapToTickMarks(false).setTickMarkLength(20).setTickMarkWeight(7))
    .setColorBackground(color(0)).setColorForeground(color(255)).setColorActive(color(255));
  cp5.getController("tach").getCaptionLabel().setVisible(false);
  cp5.getController("tach").getValueLabel().setVisible(false);

  tach1Label = cp5.addLabel("1").setPosition(150, 400).setFont(font).setColorValue(color(47, 139, 185));
  tach2Label = cp5.addLabel("2").setPosition(155, 345).setFont(font).setColorValue(color(47, 139, 185));
  tach3Label = cp5.addLabel("3").setPosition(190, 300).setFont(font).setColorValue(color(47, 139, 185));
  tach4Label = cp5.addLabel("4").setPosition(250, 280).setFont(font).setColorValue(color(47, 139, 185));
  tach5Label = cp5.addLabel("5").setPosition(310, 300).setFont(font).setColorValue(color(47, 139, 185));
  tach6Label = cp5.addLabel("6").setPosition(340, 345).setFont(font).setColorValue(color(47, 139, 185));
  tach7Label = cp5.addLabel("7").setPosition(350, 400).setFont(font).setColorValue(color(255, 0, 0));
  tach8Label = cp5.addLabel("8").setPosition(325, 445).setFont(font).setColorValue(color(255, 0, 0));

  eTemp = (cp5.addKnob("eTemp").setRange(60, 120).setValue(0).setPosition(35, 163).setRadius(67).setFont(font)
    .setNumberOfTickMarks(5).snapToTickMarks(false).setTickMarkLength(15).setTickMarkWeight(6).setStartAngle(PI/2).setAngleRange(PI))
    .setColorBackground(color(0)).setColorForeground(color(255)).setColorActive(color(255));
  cp5.getController("eTemp").getCaptionLabel().setVisible(false);
  cp5.getController("eTemp").getValueLabel().setVisible(false);
  startTime = millis();

  gas = (cp5.addKnob("gauge").setRange(0, 100).setValue(100).setPosition(813, 163).setRadius(67).setFont(font)
    .setNumberOfTickMarks(4).snapToTickMarks(false).setTickMarkLength(15).setTickMarkWeight(6).setStartAngle(3*PI/2).setAngleRange(PI))
    .setColorBackground(color(0)).setColorForeground(color(255)).setColorActive(color(255));
  cp5.getController("gauge").getCaptionLabel().setVisible(false);
  cp5.getController("gauge").getValueLabel().setVisible(false);

  eTempI = loadImage("engineTemp.jpg");
  gasI = loadImage("fuelPump.JPG");
  doorsI = loadImage("openDoor.jpg");
  seatbeltI = loadImage("seatbelt.JPG");
  cruiseControlI = loadImage("cruiseControl.jpg");
  cruiseControlOnI = loadImage("cruiseControlOn.JPG");
  
  airbag = loadImage("airbag.jpg");
  antilock = loadImage("antiLock.jpg");
  battery = loadImage("battery.jpg");
  engine = loadImage("engine.jpg");
  oil = loadImage("oil.jpg");
  security = loadImage("security.jpg");
  tire = loadImage("tire.jpg");
  traction = loadImage("traction.jpg");
  tractionMal = loadImage("tractionMal.jpg");

  cel = (cp5.addToggle("Cel").setSize(45, 45).setPosition(945, 25).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("Cel").getCaptionLabel().setVisible(false);
  cel.setState(false);
  faren = (cp5.addToggle("Faren").setSize(45, 45).setPosition(945, 80).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("Faren").getCaptionLabel().setVisible(false);
  faren.setState(true);

  celLabel = cp5.addLabel("C").setPosition(945, 15).setFont(font);
  farenLabel = cp5.addLabel("F").setPosition(945, 70).setFont(font);

  font = createFont("Helvetica", 40);

  milesLabel = cp5.addLabel("mph").setPosition(575, 450).setFont(font);
  kiloLabel = cp5.addLabel("km/h").setPosition(575, 450).setFont(font).setVisible(false);

  font = createFont("Helvetica", 25);

  mph = (cp5.addToggle("mphT").setSize(75, 50).setPosition(825, 465).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("mphT").getCaptionLabel().setVisible(false);
  mph.setState(true);
  kmh = (cp5.addToggle("km/hT").setSize(75, 50).setPosition(910, 465).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("km/hT").getCaptionLabel().setVisible(false);
  kmh.setState(false);

  mphTLabel = cp5.addLabel("MPH").setPosition(830, 470).setFont(font);
  kmhTLabel = cp5.addLabel("KM/H").setPosition(910, 470).setFont(font);

  font = createFont("Helvetica", 15);

  brakeP = (cp5.addButton("Brake").setSize(100, 160).setPosition(500, 520).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  gasP = (cp5.addButton("Accelerate").setSize(100, 160).setPosition(620, 520).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));

  right = (cp5.addToggle("Right").setSize(180, 75).setPosition(300, 520).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("Right").getCaptionLabel().setVisible(false);
  right.setState(false);
  left = (cp5.addToggle("Left").setSize(180, 75).setPosition(300, 605).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("Left").getCaptionLabel().setVisible(false);
  left.setState(false);
  emergency = (cp5.addToggle("Emer").setSize(100, 160).setPosition(180, 520).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("Emer").getCaptionLabel().setVisible(false); 
  emergency.setState(false);

  rightLabel = cp5.addLabel("RIGHT SIGNAL").setPosition(335, 550).setFont(font);
  leftLabel = cp5.addLabel("LEFT SIGNAL").setPosition(340, 635).setFont(font);
  emerLabel = cp5.addLabel("EMERGENCY").setPosition(180, 590).setFont(font);

  warnings = (cp5.addToggle("Warnings").setSize(100, 160).setPosition(60, 520).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
   cp5.getController("Warnings").getCaptionLabel().setVisible(false);
   warnings.setState(false);
   
  warningsLabel = cp5.addLabel("WARNINGS").setPosition(65,590).setFont(font);

  cruise = (cp5.addToggle("Cruise").setSize(180, 75).setPosition(740, 520).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));
  cp5.getController("Cruise").getCaptionLabel().setVisible(false);
  cruise.setState(false);
  Button setCruise = (cp5.addButton("Set").setSize(180, 75).setPosition(740, 605).setFont(font))
    .setColorBackground(color(25)).setColorForeground(color(150)).setColorActive(color(78, 173, 220));

  cruiseLabel = cp5.addLabel("CRUISE CONTROL").setPosition(765, 550).setFont(font);
}

void draw() {  

  fill(0);
  stroke(255);
  strokeWeight(5);
  circle(620, 375, 394); //around speedometer
  circle(265, 407, 320); //around tachometer

  noFill();
  strokeWeight(3);
  arc(102, 230, 173, 173, PI/2, 3*PI/2); //around engine temp
  arc(880, 230, 173, 173, 3*PI/2, 5*PI/2); //around gas gauge

  //DANGER
  fill(255, 0, 0);
  stroke(255, 0, 0);
  strokeWeight(1);
  arc(265, 412, 310, 310, 0, PI/4); //on tachometer
  arc(102, 230, 165, 165, 4*PI/3, 3*PI/2); //on engine temp

  //images
  image(eTempI, 175, 150);
  image(gasI, 760, 150);
  image(doorsI, 425, 20);
  image(seatbeltI, 510, 20);
  
  float currentETemp = eTemp.getValue();
  float currentSpeed = speedometer.getValue();
  float currentTach = tachometer.getValue();
  if (mouseX > 620 && mouseX < 720 && mouseY > 520 && mouseY < 680 && mousePressed) {
    currentSpeed++;
    speedometer.setValue(currentSpeed);
    
    
    currentTach = tachometer.getValue();
    currentTach += .1;
    tachometer.setValue(currentTach);
  }
  else {
    if (speedometer.getValue() > 0) {
      if (mph.getState() == true) {
        if (speedometer.getValue() < 20) {
          if (currentTach > 1.9) {
            currentTach = tachometer.getValue();
            currentTach -= .05;
            tachometer.setValue(currentTach);
          }
        }
        else {
          if (currentTach > 2.3) {
            currentTach = tachometer.getValue();
            currentTach -= .05;
            tachometer.setValue(currentTach);
           } 
         }
      }
      else {
        if (speedometer.getValue() < 40) {
          if (currentTach > 1.9) {
            currentTach = tachometer.getValue();
            currentTach -= .05;
            tachometer.setValue(currentTach);
          }
        }
        else {
          if (currentTach > 2.3) {
            currentTach = tachometer.getValue();
            currentTach -= .05;
            tachometer.setValue(currentTach);
           } 
         }
      }
      
      if (currentETemp < 90) {
        if (millis() > startTime + eTempSpeed) {
          startTime = millis();
          currentETemp++;
          eTemp.setValue(currentETemp);
        }
      }
    }
    else {
      if (currentTach > 0.9) {
        currentTach = tachometer.getValue();
        currentTach -= .05;
        tachometer.setValue(currentTach);
      } 
    }
  }
  if (mouseX > 500 && mouseX < 600 && mouseY > 520 && mouseY < 680 && mousePressed) {
      currentSpeed--;
      speedometer.setValue(currentSpeed);
  }

  if (cruiseOn == false) {
    image(cruiseControlI, 465, 100);
  } else {
    image(cruiseControlOnI, 465, 100);
  }

  fill(47, 139, 185);
  font = createFont("Helvetica", 25);
  textFont(font);
  if (cruiseSet == true && cruiseOn == true) {
    text("SET", 550, 140);
  } else {
    fill(0);
    stroke(0);
    rect(550, 120, 70, 50);
  }

  timeinterval = 500;
  if (leftSig == true) {
    if(sigLightOn == true) {
      fill(60, 220, 124);
      stroke(60, 220, 124);
      
      if(millis() > lasttimecheck + timeinterval) {
        lasttimecheck = millis();
        sigLightOn = false;
      }
    }
    else {
      fill(25);
      stroke(25);
      if(millis() > lasttimecheck + timeinterval) {
        lasttimecheck = millis();
        sigLightOn = true;
      }
    }
  }
  else {
    fill(25);
    stroke(25);
  }
  //left arrow
  rect(370, 40, 40, 40);
  triangle(330, 60, 370, 20, 370, 100);

  if (rightSig == true) {
    if(sigLightOn == true) {
      fill(60, 220, 124);
      stroke(60, 220, 124);
      
      if(millis() > lasttimecheck + timeinterval) {
        lasttimecheck = millis();
        sigLightOn = false;
      }
    }
    else {
      fill(25);
      stroke(25);
      if(millis() > lasttimecheck + timeinterval) {
        lasttimecheck = millis();
        sigLightOn = true;
      }
    }
  } else {
    fill(25);
    stroke(25);
  }
  //right arrow
  rect(595, 40, 40, 40);
  triangle(675, 60, 635, 20, 635, 100);
  
  fill(255);
  stroke(0);
  text("Warning",25,20);
  font = createFont("Helvetica", 15);
  switch(warningChoice) {
     case -1:
       fill(25);
       rect(25, 25, 190, 100); //warning box
       break;
     case 0:
       image(airbag,25,25);
       text("Airbag",135,100);
       break;
     case 1:
       textFont(font);
       image(antilock,25,25);
       text("Anti-Lock",135,80);
       text("Brake",150,100);
       break;
     case 2:
       image(battery,25,25);
       text("Battery",135,100);
       break;
     case 3:
       image(engine,25,25);
       text("Engine",135,100);
       break;
     case 4:
       image(oil,25,25);
       text("Oil",135,100);
       break;
     case 5:
       image(security,25,25);
       text("Security",125,100);
       break;
     case 6:
       textFont(font);
       image(tire,25,25);
       text("Tire",135,80);
       text("Pressure",135,100);
       break;
     case 7:
       textFont(font);
       image(traction,25,25);
       text("Traction",135,80);
       text("Control",135,100);
       break;
     case 8:
       textFont(font);
       image(tractionMal,25,25);
       text("Traction",135,80);
       text("Malfunction",135,100);
       break;
  }
  
  //gray out
  fill(25);
  stroke(25);

  rect(825, 380, 160, 80); //odometer box
  rect(745, 25, 190, 100); //outside temp box

  //bottom area
  fill(0);
  stroke(0);
  rect(0, 520, 1000, 700);

  //white
  fill(255);
  stroke(255);

  font = createFont("Helvetica", 35);
  textFont(font);
  text("H", 110, 160);
  text("C", 110, 318);

  triangle(750, 175, 760, 165, 760, 185);
  text("F", 850, 165);
  text("E", 850, 320);
  
  if (mph.getState() == true) {
    text("105366", 850, 430);
  }
  else {
    text("169570", 850, 430);
  }
    
  font = createFont("Helvetica", 20);
  textFont(font);
  text("ODOMETER", 870, 370);

  String temp;
  if (tempType == 'F') {
    temp = "65";
  } else {
    temp = "18";
  }

  font = createFont("Helvetica", 75);
  textFont(font);
  text(temp, 780, 100);
  font = createFont("Helvetica", 50);
  textFont(font);
  text(tempType, 895, 115);
  noFill();
  circle(875, 50, 15);
}

void controlEvent(ControlEvent theEvent) {
  
  switch(theEvent.getController().getName()) {
  case "mphT":
    if (mph.getState() == true) { 
      font = createFont("Helvetica", 25);
      kmh.setState(false);

      speedometer.setRange(0, 140).setValue(0).setNumberOfTickMarks(14);
      tachometer.setValue(0);
      cp5.getController("speed").setCaptionLabel("mph");
      milesLabel.setVisible(true);
      kiloLabel.setVisible(false);
      
      fontMiles = createFont("Helvetica",50);
      speed0Label.setPosition(505, 430).setFont(fontMiles);
      speed20Label.setPosition(470, 360).setFont(fontMiles);
      speed40Label.setPosition(485, 280).setFont(fontMiles);
      speed60Label.setPosition(550, 230).setFont(fontMiles);
      speed80Label.setPosition(635, 230).setFont(fontMiles);
      speed100Label.setPosition(680, 280).setFont(fontMiles);
      speed120Label.setPosition(700, 360).setFont(fontMiles);
      speed140Label.setPosition(670, 430).setFont(fontMiles);
      
      speed160Label.setVisible(false);
      speed180Label.setVisible(false);
      speed200Label.setVisible(false);
      speed220Label.setVisible(false);
      speed240Label.setVisible(false);
    }
    break;
  case "km/hT":
    if (kmh.getState() == true) {
      mph.setState(false);

      speedometer.setRange(0, 240).setValue(0).setNumberOfTickMarks(24);
      tachometer.setValue(0);
      cp5.getController("speed").setCaptionLabel("km/h");
      kiloLabel.setVisible(true);
      milesLabel.setVisible(false);
      
      fontKilo = createFont("Helvetica", 35);
      speed0Label.setPosition(515, 450).setFont(fontKilo);
      speed20Label.setPosition(485, 410).setFont(fontKilo);
      speed40Label.setPosition(470, 360).setFont(fontKilo);
      speed60Label.setPosition(480, 310).setFont(fontKilo);
      speed80Label.setPosition(505, 270).setFont(fontKilo);
      speed100Label.setPosition(535, 240).setFont(fontKilo);
      speed120Label.setPosition(590, 220).setFont(fontKilo);
      speed140Label.setPosition(645, 240).setFont(fontKilo);
      speed160Label.setVisible(true).setPosition(680, 270).setFont(fontKilo);
      speed180Label.setVisible(true).setPosition(700, 310).setFont(fontKilo);
      speed200Label.setVisible(true).setPosition(715, 360).setFont(fontKilo);
      speed220Label.setVisible(true).setPosition(705, 410).setFont(fontKilo);
      speed240Label.setVisible(true).setPosition(675, 450).setFont(fontKilo);
    }
    break;    

  case "Faren":
    if (faren.getState() == true) {
      cel.setState(false);
      tempType = 'F';
    }
    break;
  case "Cel":
    if (cel.getState() == true) {
      faren.setState(false);
      tempType = 'C';
    }
    break;

  case "Cruise":
    if (cruise.getState() == true) {
      cruiseOn = true;
    } else {
      cruiseOn = false;
      cruiseSet = false;
    }
    break;
  case "Set":
    if (cruiseOn == true) {
      cruiseSet = true;
    }
    break;

  case "Right":
    lasttimecheck = millis();
    sigLightOn = true;
    if (right.getState() == true) {
      emergency.setState(false);
      left.setState(false);
      leftSig = false;
      rightSig = true;
    } else {
      rightSig = false;
      sigLightOn = false;
    }
    break;
  case "Left":
    lasttimecheck = millis();
    sigLightOn = true;
    if (left.getState() == true) {
      emergency.setState(false);
      right.setState(false);
      rightSig = false;
      leftSig = true;
    } else {
      leftSig = false;
      sigLightOn = false;
    }
    break;
  case "Emer":
    lasttimecheck = millis();
    sigLightOn = true;
    if (emergency.getState() == true) {
      right.setState(false);
      left.setState(false);
      rightSig = true;
      leftSig = true;
    } else {
      rightSig = false;
      leftSig = false;
      sigLightOn = false;
    }
    break;
    
    case "Warnings":
      if(warnings.getState() == true) {
        warningChoice = int(random(9));
      }
      else {
        warningChoice = -1;
      }
      break;
  
  case "Brake":
    cruiseSet = false;
    break;
  }
}
