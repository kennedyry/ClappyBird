import processing.serial.*;
Serial myPort;

float easing = 0.25;
int minInput = 0;
int maxInput = 200;
float jumpThreshold = (maxInput - minInput) * 0.5;
float val;

void initializeSerial() {
  String[] portsList = Serial.list();
  for (String portName : portsList) {
    println(portName);
  }
  String portName = Serial.list()[3]; //You may need to change this 3
  myPort = new Serial(this, portName, 9600);
}

float getEasedSensorValue() {
  if (myPort.available() > 0) {
    String sensorDistanceString = myPort.readStringUntil('\n');
    if (sensorDistanceString != null) {
      sensorDistanceString = sensorDistanceString.trim();
      try {
        int sensorDistanceInCM = Integer.parseInt(sensorDistanceString);
        sensorDistanceInCM = constrain(sensorDistanceInCM, minInput, maxInput);
        float delta = sensorDistanceInCM - val;
        if (abs(delta) < jumpThreshold) {
          val += delta * easing;
        }
      }  
      catch(NumberFormatException e) {
        println(e);
      }
    }
  }
  return val;
}