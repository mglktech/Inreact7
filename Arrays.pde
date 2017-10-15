IntList Lights_Product_IDs;
StringList Lights_Names;
String[] Lights_NamesArray;

IntList PatternProfileIDs;
StringList PatternProfileNames;
String[] PatternProfileNamesArray;

IntList SelectedCompatiblePatternIDs;
StringList SelectedCompatiblePatternNames;
String[] SelectedCompatiblePatternNamesArray;



//String[] SPPD; // Selected PatternProfile Details
String[] SCPD; // Selected Colour Profile Details
String[] SPD; // Selected Profile Details

public void PullCompatiblePatterns(int SelectedProduct)
{
  println("Pulling compatible patterns for product: "+SelectedProduct);
  SelectedCompatiblePatternIDs = new IntList();
  SelectedCompatiblePatternNames = new StringList();
  PatternProfileIDs = new IntList();
  PatternProfileNames = new StringList();
  db.query("SELECT * FROM PatternType JOIN PatternCompatible on PatternCompatible.Pattern_ID = PatternType.ID WHERE PatternCompatible.Product_ID ="+SelectedProduct);
  while(db.next())
  {
    SelectedCompatiblePatternIDs.append(db.getInt("Pattern_ID"));
    SelectedCompatiblePatternNames.append(db.getString("Name"));
    
    
  }
  for(int i=0;i<SelectedCompatiblePatternIDs.size();i++)
  {
    db.query("SELECT * FROM PatternProfiles WHERE Pattern_ID = "+SelectedCompatiblePatternIDs.get(i));
    while(db.next())
    {
      PatternProfileIDs.append(db.getInt("ID"));
      PatternProfileNames.append(db.getString("Name"));
      print("Found PatProfile: "+db.getString("Name"));
    }
    
  }
  SelectedCompatiblePatternNamesArray = CreateStringArrayFromList(SelectedCompatiblePatternNames);
  PatternProfileNamesArray = CreateStringArrayFromList(PatternProfileNames);
  
  
  
  
}

public void PullCompatibleColourTypes(int SelectedPattern)
{
  
  
}

public void PullLightDataFromSQL()
{
  Lights_Product_IDs = new IntList();
  Lights_Names = new StringList();
  String[] StrictColumns = {"LightID","Product_ID"};
  int[] StrictColumnFormat = {Table.INT,Table.INT};
  int cnt = 0;
  db.query("SELECT * FROM Product JOIN Lights on Lights.Product_ID = Product.ID");
  while(db.next())
  {
    Lights_Product_IDs.append(db.getInt("Product_ID"));
    Lights_Names.append(db.getString("Name"));
    
    String[] d = {str(cnt),str(db.getInt("Product_ID"))};
    AddTableRow(InstanceLightData,StrictColumnFormat,StrictColumns,d);
    cnt++;
  }
  Lights_NamesArray = CreateStringArrayFromList(Lights_Names);
  if(Lights_Names.size()>0)
  {
    
    lstSelectLight_MainWindow.setItems(Lights_NamesArray, 0);
    
    
  }
  if(Lights_Names.size()<=0)
  {
    Lights_NamesArray[0] = "Ready";
    lstSelectLight_MainWindow.setItems(Lights_NamesArray, 0);
  }
  
  
}



public String[] CreateStringArrayFromList(StringList list)
{
  int size = list.size();
  String[] rtn = new String[size];
  
  for(int i=0;i<size;i++)
  {
    rtn[i] = list.get(i);
  }
  
  
  
  return rtn;
  
}