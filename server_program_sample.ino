
#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include <ESP8266HTTPClient.h>

/* Set these to your desired credentials. */
const char *ssid = "GuestDnet";  //ENTER YOUR WIFI SETTINGS
const char *password = "Adr3nalin3";

//Web/Server address to read/write from 
const char *host = "http://iot.ticollege.org";   //https://circuits4you.com website or IP address of server (server url)

//=======================================================================
//                    Power on setup
//=======================================================================

int   a,b,i,c;
float   val[2000],d[2000];
float   value=0,sum=0;


void setup() {
  delay(1000);
  Serial.begin(115200);

  // Changed
  pinMode(A0,INPUT);
  pinMode(D5,INPUT);
  pinMode(D6,INPUT);


  
  WiFi.mode(WIFI_OFF); //Prevents reconnection issue (taking too long to connect)
  delay(1000);
  WiFi.mode(WIFI_STA); //This line hides the viewing of ESP as wifi hotspot
  
  WiFi.begin(ssid, password);     //Connect to your WiFi router
  Serial.println("");

  Serial.print("Connecting");
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  //If connection successful show IP address in serial monitor
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());  //IP address assigned to your ESP
}

//=======================================================================
//                    Main Program Loop
//=======================================================================
void loop() {
  HTTPClient http;    //Declare object of class HTTPClient

  String ADCData, station, postData;
  // int adcvalue=analogRead(A0);  //Read Analog value of LDR
  // ADCData = String(adcvalue);   //String to interger conversion
  ADCData = "B";
  station = "A";

  //Post Data
  postData = "status=" + ADCData + "&station=" + station ;
  
  http.begin("http://iot.ticollege.org/postdemo.php");              //Specify request destination
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");    //Specify content-type header

  while( (digitalRead(D5)==1) || (digitalRead(D6)==1) )
  {
    Serial.println("!");
    digitalRead(D5);
    digitalRead(D6);
  }
  
   for(a=0;a<=1999;a++)
  {
   value=analogRead(A0);
   //value=(800.0*5.0)/1023.0;
   
   //val[a]=(value*5.0)/1023.0 ;//omit
   val[a]=value;
   
 //   Serial.println(a);     // optional step // just for visualisation
        delay(10);     // 250HZ sampling frequency
        
  // Serial.println(val[a]);
  // Serial.println(value);

      }
      for(i=0;i<=1996;i++)
      {
        sum=val[i]+val[i+1]+val[i+2]+val[i+3];
        sum=sum/4;
        d[i]=sum;
      }
  for(b=0;b<=1996;b++)
  {
    Serial.println(d[b]);
    delay(10);
 }
  String ecg;
  
  for(c=0;c<=1999;c++)
  {
//    http.POST("data=" + String(d[c]));
    ecg += String(val[c]) + " ";
    delay(10);
  }
  http.POST("data="+ecg);
//  int httpCode = http.POST(postData);   //Send the request
  String payload = http.getString();    //Get the response payload

//  Serial.println(httpCode);   //Print HTTP return code
  Serial.println(payload);    //Print request response payload

  http.end();  //Close connection
  
  delay(5000);  //Post Data at every 5 seconds
}
//=======================================================================
