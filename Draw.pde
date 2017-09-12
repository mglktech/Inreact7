int sliXPos, sliXsize;

boolean InRange(int val, int min, int max) {
  if(val >= min && val <= max)
  {
    return true;
  }
  else {
    return false;
  }
}
  

boolean MouseOver(GWindow win,int ox, int oy, int oxs, int oys)
{
  int test = ox+oxs;
  //println("InRange("+win.mouseX+","+ox+","+test+");");
  if(InRange(win.mouseX,ox,ox+oxs) && InRange(win.mouseY,oy,oy+oys)){
    return true;
  }
  else {
    return false;
  }
    
  
}

public void UpdateBackground(PApplet appc)
{
  
  appc.background(25);
}


public void UpdateUIElements(GWindow win)
{
  Range range = sliSelectBands_PatternConfig;
  
  if(win == winPatternConfig)
  {
    if(win.mousePressed)
    {
    SPPD[3] = str(floor(range.getArrayValue(0)));
    SPPD[4] = str(floor(range.getArrayValue(1)));
    //println("Min: "+sliSelectBands_PatternConfig_Min+" Max: "+sliSelectBands_PatternConfig_Max+" Diff: "+sliSelectBands_PatternConfig_Diff);
    //println("Actual: "+range.getArrayValue(0)+":"+range.getArrayValue(1));
    }
    
    
    
   
  }
  if(win == winColourConfig)
  {
    if(win.mousePressed)
    {
      int HO = int(knoHueOffset_ColourConfig.getValue());
      int SA = int(sliSat_ColourConfig.getValue());
     knoHueOffset_ColourConfig.setColorActive(HSBConvert(HO,SA,255,false));
     knoHueOffset_ColourConfig.setColorForeground(HSBConvert(HO,SA,255,false));
     //knoHueOffset_ColourConfig.setValueLabel(str(floor(knoHueOffset_ColourConfig.getValue())));
      
      
    }
  }
  
  
  
}












public void DrawSpectrum(GWindow win)
{
  Range range = sliSelectBands_PatternConfig;
  win.fill(50,50,50);
  win.noStroke();
  win.rect(10,35,400,255);
  // fill FFT test data
  win.fill(50,200,50);
  for(int i=0;i<50;i++)
  {
    win.fill(100,100,100);
    if(fftTestData[i]>255)
    {
      fftTestData[i] = 255;
    }
    if(InRange(i,int(SPPD[3]),int(SPPD[4])))
    {
      win.fill(50,200,50);
    }
    win.rect(10+i*8,290,8,-fftTestData[i]);
    
  }
 
  win.stroke(10,10,10);
  int cnt = 0;
   for(int i=0; i<=400;i++) // Vertical Lines
  {
   if(i % 8 == 0)
   {
    
    win.line(10+i,35,10+i,290);
   
   }
    
    
  } // END
  win.stroke(100,100,100);
  for(int i=0; i<=255;i++) // Horizontal Lines
  {
    if(i % 50 == 0)
    {
      win.line(10,35+i,410,35+i);
      
    }
    
    
  }
  
    

}