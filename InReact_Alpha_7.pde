// Need G4P library
import g4p_controls.*;
import controlP5.*;
String[] lstLoading = {"Loading..."};
int[] fftTestData;
boolean mood_mode, UI_Loaded, first, NoDraw;
int sliSelectBands_PatternConfig_Min, sliSelectBands_PatternConfig_Max, sliSelectBands_PatternConfig_Diff, patDecayValA, patDecayValB, patDecayValSplit;
java.awt.Frame f; // hacky code for original window frame
String[] tabData;
int appfps  = 60;
int bgcol = color(25,25,25);


public void FillFFT()
{
  fftTestData = new int[50];
  for(int i=0;i<50;i++)
  {
    
    fftTestData[i] = 10+i*5;
    
  }
  
}

PVector getRootWindowLocation() {
  
  PVector l = new PVector();
 
    f =  (java.awt.Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
    l.x = f.getX();
    l.y = f.getY();
  
  return l;
  
}

public void winAttach(GWindow win, String pos, int addX, int addY)
{
  PVector loc = getRootWindowLocation();
  int w = win.width;
  int h = win.height;
  int X = int(loc.x);
  int Y = int(loc.y);
  if(pos == "left")
  {
    win.setLocation((X-w)+addX,Y+addY);
    
  }
  if(pos == "right")
  {
    win.setLocation((X+f.getWidth()-5)+addX,Y+addY);
  }
  
  
}


public void setup(){
 
  size(300, 200, JAVA2D);
  background(25);
  Load_MainWindow();
  Load_winPatternConfig();
  Load_winColourConfig();
  Lights = new Table();
  SPPD = new String[14];
  CreateTable(Lights,Lights_ColumnNames,Lights_ColumnFormat);
  FillFFT();
  SQL_Load();
  // Place your setup code here
  
}



public void draw(){
 background(25);
}


public void SaveProfile_Pattern()
{
  // SPPD[0] is reserved.
  SPPD[1] = lstPatternProfile_PatternConfig.getSelectedText();
  println("Saving profile "+lstPatternProfile_PatternConfig.getSelectedText());
  db.query("SELECT * FROM PatternType WHERE Name = '"+lstPattern_PatternConfig.getSelectedText()+"'");
  SPPD[2] = str(db.getInt("ID"));
  //SPPD[3] = str(floor(range.getArrayValue(0)));
  //SPPD[4] = str(floor(range.getArrayValue(1) - range.getArrayValue(0)));
  SPPD[5] = sliMul_PatternConfig.getValueXS();
  SPPD[6] = sliMul_PatternConfig.getValueYS();
  SPPD[7] = str(int(sliLowPass_PatternConfig.getValue()));
  //SPPD[8]  = txbGamma_PatternConfig.getText();
  //SPPD[9]  = txbMaxX_PatternConfig.getText();
  //SPPD[10] = txbMaxY_PatternConfig.getText();
  //SPPD[11] = txbDecayValA.getText();
  //SPPD[12] = txbDecayValB.getText();
  //SPPD[13] = txbDecayValSplit.getText();
  
  println("Attempting write to DB...");
  db.query("SELECT Count(*) AS count from PatternProfiles where PatternProfiles.Name = '"+SPPD[1]+"';");
  if(db.getInt("count") == 0)
  {
    db.execute("INSERT INTO `PatternProfiles`(`Name`,`Pattern_ID`,`Bands_Min`,`Bands_Amount`,`MulBright`,`MulColour`,`LowPass`,`GammaVal`,`MaxXVal`,`MaxYVal`,`DecayValA`,`DecayValB`,`DecayValSplit`) VALUES ('"+SPPD[1]+"',"+SPPD[2]+","+SPPD[3]+","+SPPD[4]+","+SPPD[5]+","+SPPD[6]+","+SPPD[7]+","+SPPD[8]+","+SPPD[9]+","+SPPD[10]+","+SPPD[11]+","+SPPD[12]+","+SPPD[13]+");");
    println("Executed INSERT");
  }
  else if(db.getInt("count") == 1)
  {
  db.execute("UPDATE `PatternProfiles` SET Pattern_ID ="+SPPD[2]+",Bands_Min = "+SPPD[3]+",Bands_Amount = "+SPPD[4]+", MulBright = "+SPPD[5]+",MulColour = "+SPPD[6]+", LowPass = "+SPPD[7]+", GammaVal = "+SPPD[8]+", MaxXVal = "+SPPD[9]+", MaxYVal = "+SPPD[10]+", DecayValA = "+SPPD[11]+", DecayValB = "+SPPD[12]+", DecayValSplit = "+SPPD[13]+" WHERE Name='"+SPPD[1]+"';");
  println("Executed UPDATE");
  }
 
    
  
  
    
  
}
public void LoadProfileToArray_Pattern()
{
  db.query("SELECT * FROM PatternProfiles WHERE Name = '"+lstPatternProfile_PatternConfig.getSelectedText()+"';");
  println("Loading profile "+lstPatternProfile_PatternConfig.getSelectedText());
  SPPD[1] = db.getString("Name");
  SPPD[2] = str(db.getInt("Pattern_ID"));
  SPPD[3] = str(db.getInt("Bands_Min"));
  SPPD[4] = str(db.getInt("Bands_Amount"));
  SPPD[5] = str(db.getFloat("MulBright"));
  SPPD[6] = str(db.getFloat("MulColour"));
  SPPD[7] = str(db.getInt("LowPass"));
  SPPD[8] = str(db.getFloat("GammaVal"));
  SPPD[9] = str(db.getFloat("MaxXVal"));
  SPPD[10] = str(db.getFloat("MaxYVal"));
  SPPD[11] = str(db.getInt("DecayValA"));
  SPPD[12] = str(db.getInt("DecayValB"));
  SPPD[13] = str(db.getInt("DecayValSplit"));

}
public void UpdateUIFromArray_Pattern()
{
  println("Updating UI...");
  Range range = sliSelectBands_PatternConfig;
  Slider lowpass = sliLowPass_PatternConfig;
  //range.setArrayValue(0,float(SPPD[3]));
  //range.setArrayValue(1,float(SPPD[4]) - float(SPPD[3]));
  range.setLowValue(float(SPPD[3]));
  range.setHighValue(float(SPPD[4]) + float(SPPD[3]));
  lowpass.setValue(float(SPPD[7]));
  sliMul_PatternConfig.setValueX(float(SPPD[5]));
  sliMul_PatternConfig.setValueY(float(SPPD[6]));
  db.query("SELECT * FROM PatternType");
  int cnt = 0;
  boolean finished = false;
  while(db.next())
  {
    if(db.getString("Name") == SPPD[1])
    {
      finished = true;
    }
    if(finished == false)
    {
    cnt++;
    }
  }
  
  lstPattern_PatternConfig.setSelected(cnt-1);
  
  
}



// Use this method to add additional statements
// to customise the GUI controls