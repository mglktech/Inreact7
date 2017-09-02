
import processing.serial.*;
Serial port;

String queue = "";
int ThreadFPS = 60;
int Arduino_Data_Length;
String Arduino_Data;
boolean Arduino_Connected = false;
boolean Arduino_Handshake = false;

void ProcessQueue()
{
  
    if(queue!="")
    {
      
    port.write(queue+'#');
    queue = "";
    delay(1000/ThreadFPS);
    }
}




void Serial_Read()
{
  if(Arduino_Data.substring(0,1) == "H")
  {
    Arduino_Handshake = true;
    println("Handshake Successful.");
  }
  if(Arduino_Data.substring(0,2) == "AL")
  {
    // Add Light(ProductID)
    
    int Add_Light = int(Arduino_Data.substring(2,5));
    println("Adding Light:" + Add_Light);
    SQL_Add_Light(Add_Light);
  }
  
  
  
  
}


void serialEvent(Serial p) { 
  
  char InChar = (char)p.read();
  
  if(InChar == '#')
  {
    Serial_Read();
    Arduino_Data_Length = 0;
    Arduino_Data = "";
    
  }
  else
  {
    Arduino_Data_Length+=1;
    Arduino_Data+=InChar;
  }
  
  
 
  
  
}