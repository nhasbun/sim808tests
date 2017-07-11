  #include <DFRobot_sim808.h>
  #include <SoftwareSerial.h>
  
  DFRobot_SIM808 sim808(&Serial);
  
  #define PHONE_NUMBER "56976083295"  

  #define MESSAGE_LENGTH 20
  char gprsBuffer[64];
  char *s = NULL;

  float GPSlat = 0;
  float GPSlon = 0;
  int MSGsignal = 0;
  int val = 0; 
  int answered = 0;
  
  void setup() {
    //mySerial.begin(9600);
    Serial.begin(9600);
    pinMode(8, INPUT); 
    
    //******** Initialize sim808 module *************
    while(!sim808.init()) {
        delay(1000);
        Serial.print("Sim808 init error\r\n");
    }

    //************* Turn on the GPS power************
    if( sim808.attachGPS())
        Serial.println("Open the GPS power success");
    else
        Serial.println("Open the GPS power failure");

  }

  void loop() 
  {
    val = digitalRead(8);
    // Revisar GPS o llamada
    if(MSGsignal == 0)
    {
      GPSdata(GPSlat, GPSlon); 
    }
    else
    {
      answerCALL(answered);
      if (answered == 1)
      {
        answered = 0;
        MSGsignal = 0;
      }
    }
      
    // Revisar por boton
    if (val == 1)
    {
      const int BUF_MAX = 64;
      char buf[BUF_MAX];
      const int VAL_MAX = 16;
      char val[VAL_MAX];
      strcpy_P(buf, (const char*) F("SOS! latitud:"));
      dtostrf(GPSlat, 8, 6, val);
      strcat(buf, val);
      strcat_P(buf, (const char*) F("; longitud:"));
      dtostrf(GPSlon, 8, 6, val);
      strcat(buf, val);
      
      
      delay(1000);
      sim808.sendSMS(PHONE_NUMBER,buf);
      MSGsignal = 1;
      delay(5000);
    }
    
  }
  
  void GPSdata(float &GPSlat, float &GPSlon)
  {
         //************** Get GPS data *******************
     if (sim808.getGPS()) {
      Serial.print(sim808.GPSdata.year);
      Serial.print("/");
      Serial.print(sim808.GPSdata.month);
      Serial.print("/");
      Serial.print(sim808.GPSdata.day);
      Serial.print(" ");
      Serial.print(sim808.GPSdata.hour);
      Serial.print(":");
      Serial.print(sim808.GPSdata.minute);
      Serial.print(":");
      Serial.print(sim808.GPSdata.second);
      Serial.print(":");
      Serial.println(sim808.GPSdata.centisecond);
      Serial.print("latitude :");
      Serial.println(sim808.GPSdata.lat);
      Serial.print("longitude :");
      Serial.println(sim808.GPSdata.lon);
      Serial.print("speed_kph :");
      Serial.println(sim808.GPSdata.speed_kph);
      Serial.print("heading :");
      Serial.println(sim808.GPSdata.heading);
      Serial.println();
      
      GPSlat = sim808.GPSdata.lat;
      GPSlon = sim808.GPSdata.lon;

      //************* Turn off the GPS power ************
      sim808.detachGPS();
      //GPSsignal = 1;
    }
  }
  void answerCALL(int &answered)
  {
     //******** Wait serial data *************
     if(sim808.readable()){
        sim808_read_buffer(gprsBuffer,32,DEFAULT_TIMEOUT);
        //Serial.print(gprsBuffer);
  
     //************** Detect the current state of the telephone or SMS ************************
        if(NULL != strstr(gprsBuffer,"RING")) {
            sim808.answer();
            answered = 1;
        }else if(NULL != (s = strstr(gprsBuffer,"+CMTI: \"SM\""))) { //SMS: $$+CMTI: "SM",24$$
            char message[MESSAGE_LENGTH];
            int messageIndex = atoi(s+12);
            sim808.readSMS(messageIndex, message,MESSAGE_LENGTH);
            Serial.print("Recv Message: ");
            Serial.println(message);
       }
       sim808_clean_buffer(gprsBuffer,32);  
     }
   }
  
  



