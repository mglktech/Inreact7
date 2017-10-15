
// CP5 controller events
String winNewProfile_FromWin;
float MaxXHandle, MaxYHandle;

public Boolean toBool(int i)
{
  if(i==1)
  {
    return true;
  }
  else
  {
    return false;
  }
}


public void HandleButtonEvents(GButton source,GEvent event)
{
  if(source == btnSave_PatternConfig && event == GEvent.CLICKED)
  {
    println("Attempting to save Pattern...");
    //SaveProfile("pattern","existing","");
  }
  if(source == btnSave_ColourConfig && event == GEvent.CLICKED)
  {
    println("Attempting to save Colour...");
    //SaveProfile("colour","existing","");
  }
  
  if(source == btnAddSettings_PatternConfig && event == GEvent.CLICKED)
  {
    if(!winAddPatConfig_Loaded)
    {
      Load_WinAddPatConfig();
    }
    
  }
  
  if(source == btnMoodMode_MainWindow && event == GEvent.CLICKED) 
  {
    if(mood_mode) {
      mood_mode = false;
      btnMoodMode_MainWindow.setLocalColorScheme(GCScheme.RED_SCHEME);
    }
    else if (mood_mode == false) {
      mood_mode = true;
      btnMoodMode_MainWindow.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    }
  }
  if(source == btnConnect && event == GEvent.CLICKED)
  {
    SQL_Add_Light(1101);
    SQL_Add_Light(1102);
    SQL_Add_Light(1103);
    //delay(500);
    SQL_Get_Light_Details(1);
    SQL_Get_Light_Details(2);
    SQL_Get_Light_Details(3);
    PullLightDataFromSQL();
    Load_winPatternConfig();
    Load_winColourConfig();
  }
  if(source == btnProfileNew && event == GEvent.CLICKED && !winNewProfile_Loaded)
  {
    
    Load_WinNewProfile();
    winNewProfile_FromWin = "main";
  }
  if(source == btnNewProfile_PatternConfig && event == GEvent.CLICKED && !winNewProfile_Loaded)
  {
    
    Load_WinNewProfile();
    winNewProfile_FromWin = "winPatternConfig";
  }
  if(source == btnNewProfile_ColourConfig && event == GEvent.CLICKED)
  {
    Load_WinNewProfile();
    winNewProfile_FromWin = "winColourConfig";
    
  }
  if(source == btnCreate_WinNewProfile && event == GEvent.CLICKED)
  {
    if(winNewProfile_FromWin == "winPatternConfig")
    {
      //SaveProfile("pattern","new",txtProfileName_WinNewProfile.getText());
      
    }
    if(winNewProfile_FromWin == "winColourConfig")
    {
      //SaveProfile("colour","new",txtProfileName_WinNewProfile.getText());
      
    }
    winNewProfile.close();
    print("Database has been saved!");
    
  }
  if(source == btnSave_AddPatConfig && event == GEvent.CLICKED)
  {
    UpdateTableFromUI("AddPatConfig");
    
    winAddPatConfig.close();
  }
  
  
  
  
}

synchronized public void HandleMouseEvents(PApplet appc, GWinData windata, MouseEvent event)
{
  if(event.getAction() == MouseEvent.CLICK)
  {
    
  //println("MouseEvent");
  UpdateBackground(appc);
  }
  
  
}

public void HandleTextfieldEvents(GTextField source, GEvent event)
{
  if(source ==  txbMaxX_PatternConfig && event == GEvent.ENTERED)
  {
    MaxXHandle = float(txbMaxX_PatternConfig.getText());
    sliMul_PatternConfig.setLimitsX(0.0, MaxXHandle);
  }
  if(source ==  txbMaxY_PatternConfig && event == GEvent.ENTERED)
  {
    MaxYHandle = float(txbMaxY_PatternConfig.getText());
    sliMul_PatternConfig.setLimitsY(MaxYHandle,0.0);
  }
  
  
  
  
}


public void Handle2DSliderEvents(GSlider2D source, GEvent event)
{
  if(source == sliMul_PatternConfig && event == GEvent.VALUE_STEADY)
  {
    println("SliMul X:"+sliMul_PatternConfig.getValueXS()+" Y:"+sliMul_PatternConfig.getValueYS());
    
  }
  
  
}



public void HandleDroplistEvents(GDropList source, GEvent event)
{
  if(source == lstSelectLight_MainWindow && event == GEvent.SELECTED)
  {
    //lstPattern_PatternConfig.setItems(lstLoading, 0);
    PullCompatiblePatterns(Lights_Product_IDs.get(lstSelectLight_MainWindow.getSelectedIndex()));
    lstPattern_PatternConfig.setItems(SelectedCompatiblePatternNamesArray, 0);
    if(PatternProfileNamesArray.length==0)
    {
    lstPatternProfile_PatternConfig.setItems(lstLoading, 0);
    }
    else if(PatternProfileNamesArray.length>0)
    {
      lstPatternProfile_PatternConfig.setItems(PatternProfileNamesArray, 0);
    }
    
  }
  if(source == lstPatternProfile_PatternConfig && event == GEvent.SELECTED)
  {
    if(lstPatternProfile_PatternConfig.getSelectedText() != "loading...")
    {
      
    LoadProfileToTables("Pattern");
    UpdateUIFromTable("NewPatProfileSelected");
    }
 
  }
  
    
  //print("event");
  
  
}