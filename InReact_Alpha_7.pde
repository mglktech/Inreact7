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
  Bools = new Table();
  CreateTable(Bools,Bools_ColumnNames,Bools_ColumnFormat);
  AddBoolsRowData();
  FillFFT();
  SQL_Load();
  // Place your setup code here
  
}



public void draw(){
 background(25);
}


public void SaveProfile_Pattern()
{
  String Name = txtProfileName_WinNewProfile.getText();
  int PatternID = 8002; // would normally be result of query("SELECT ID FROM PatternType WHERE Name = "+lstPattern_PatternConfig.SelectedText());
  int Bands_Min =  sliSelectBands_PatternConfig_Min;
  int Bands_Amount = sliSelectBands_PatternConfig_Diff;
  float MulBright = sliMul_PatternConfig.getValueXF();
  float MulColour = sliMul_PatternConfig.getValueYF();
  int LowPass = int(sliLowPass_PatternConfig.getValue());
  float GammaVal = float(txbGamma_PatternConfig.getText());
  float MaxXVal = float(txbMaxX_PatternConfig.getText());
  float MaxYVal = float(txbMaxY_PatternConfig.getText());
  int DecayValA = patDecayValA;
  int DecayValB = patDecayValB;
  int DecayValSplit = patDecayValSplit;
  
  println("Attempting write to DB...");
  db.execute("INSERT INTO `PatternProfiles`(`Name`,`Pattern_ID`,`Bands_Min`,`Bands_Amount`,`MulBright`,`MulColour`,`LowPass`,`GammaVal`,`MaxXVal`,`MaxYVal`,`DecayValA`,`DecayValB`,`DecayValSplit`) VALUES ('"+Name+"',"+PatternID+","+Bands_Min+","+Bands_Amount+","+MulBright+","+MulColour+","+LowPass+","+GammaVal+","+MaxXVal+","+MaxYVal+","+DecayValA+","+DecayValB+","+DecayValSplit+");");
  
  
}


// Use this method to add additional statements
// to customise the GUI controls