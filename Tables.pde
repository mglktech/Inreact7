Table Products;
Table Compatible;
Table Patterns;
Table Lights;
Table LightProfiles;
Table InstanceLightData;



String[] LightProfiles_ColumnNames = {"Light_Profile_ID","Light_ID","Pattern_Profile_ID","Colour_Profile_ID","ProfileName"};
int[]    LightProfiles_ColumnFormat = {Table.INT,Table.INT,Table.INT,Table.INT,Table.STRING}; // Backend for Active Profiles
                              
String[] Lights_ColumnNames = {"LightID","ProductID","ProductName"}; // Table of connected lights with relevant details for dropboxes
int[] Lights_ColumnFormat = {Table.INT,Table.INT,Table.STRING};


String[] InstanceLightData_ColumnNames = {"LightID","Product_ID","ProfileName","lstSelectLight_Index","lstPattern_Index","Pattern_ID","lstPatternProfile_Index","ColourProfileName","lstColourProfile_Index","Colour_ID","lstColour_Index","Bands_Min","Bands_Amount","MulBright","MulColour","LowPass","GammaVal","MaxXVal","MaxYVal","DecayValA","DecayValB","DecayValSplit","Colour_DataA","Colour_DataB","Colour_DataC","Colour_DataD"};
int[]    InstanceLightData_ColumnFormat = {Table.INT,Table.INT,Table.STRING,Table.INT,Table.INT,Table.INT,Table.INT,Table.STRING,Table.INT,Table.INT,Table.INT,Table.INT,Table.INT,Table.FLOAT,Table.FLOAT,Table.INT,Table.FLOAT,Table.FLOAT,Table.FLOAT,Table.INT,Table.INT,Table.INT,Table.FLOAT,Table.FLOAT,Table.FLOAT,Table.FLOAT};

//String[] InstanceDroplistData_ColumnNames = {"LightID","lstSelectProfile_Index","lstPattern_Index","lstPatternProfile_Index","lstColourProfile_Index","lstColour_Index"};
//int[] InstanceDroplistData_ColumnFormat = {Table.INT,Table.INT,Table.INT,Table.INT,Table.INT,Table.INT};

/*public void AddBoolsRowData()
{
  for(int i=0;i<Bools_RowData_Name.length;i++)
  {
    String[] ConstructData = {Bools_RowData_Name[i],Bools_RowData_Values[i]};
    AddTableRow(Bools,Bools_ColumnFormat,Bools_ColumnNames,ConstructData);
    
  }
  
  
  
}
*/
public void ConstructTables()
{
  LightProfiles = new Table();
  Lights = new Table();
  InstanceLightData = new Table();
  
  CreateTable(Lights,Lights_ColumnNames,Lights_ColumnFormat);
  println("Table Lights Created!");
  CreateTable(LightProfiles,LightProfiles_ColumnNames,LightProfiles_ColumnFormat);
  println("Table LightProfiles Created!");
  CreateTable(InstanceLightData,InstanceLightData_ColumnNames,InstanceLightData_ColumnFormat);
  println("Table InstanceLightData Created!");
  
  
  
  
  
}


public void CreateTable(Table table, String[] ColumnNames, int[] ColumnFormat)
{
  // Table must be initialized BEFORE running this setup.
 
  if(ColumnNames.length!=ColumnFormat.length)
  {
    println("ERROR: ColumnNames and ColumnFormat are different sizes!!! ColumnNames = "+ColumnNames.length+" & ColumnFormat = "+ColumnFormat.length);
    
  }
  else
  {
  for(int i=0;i<ColumnNames.length;i++)
  {
    table.addColumn(ColumnNames[i],ColumnFormat[i]);
    println("Adding column "+ColumnNames[i]+".");
  }
  }
  
}

public void AddTableRow(Table table, int[] format, String[] ColumnNames, String[] data)
{
  TableRow row = table.addRow();
  for(int i=0;i<data.length;i++)
  {
    if(format[i] == Table.INT)
    {
      row.setInt(ColumnNames[i],int(data[i]));
    }
    if(format[i] == Table.FLOAT)
    {
      row.setFloat(ColumnNames[i],float(data[i]));
    }
    if(format[i] == Table.STRING)
    {
      row.setString(ColumnNames[i],data[i]);
    }
    print(ColumnNames[i]+" : "+data[i]+" : ");
  }
  println("Finished adding row");
  
}

  
synchronized public int GetTableInt(Table table,int tableRow, String[] data)
{
  TableRow row;
  int result = -1;
  // data example: GetTableInt(Bools,-1,{"winPatternConfig_Loaded","Name","bool"});
  // data example: GetTableInt(LightData,0,{"Product_ID"});
  // data example: GetTableInt(LightData,0,{"LedsAmount"});
  
  if(tableRow == -1)
  {
    
    row = table.findRow(data[0],data[1]);
    result = row.getInt(data[2]);
  }
  else
  {
    row = table.getRow(tableRow); 
      result = row.getInt(data[0]); 
  }
  
  return result;
}
// above looks to be a very good way of not needing repeated code!!!
synchronized public String GetTableStr(Table table, int tableRow, String[] data)
{
  // data example: GetTableStr({"LightData","0","LightName"});
  TableRow row;
  String result = "";
  if(tableRow == -1)
  {
    
    row = table.findRow(data[0],data[1]);
    result = row.getString(data[2]);
  }
  else
  {
    row = table.getRow(tableRow); 
    result = row.getString(data[0]); 
  }
    
  return result;
}

synchronized public float GetTableFloat(Table table, int tableRow, String[] data)
{
  TableRow row;
  float result = -1;
  if(tableRow == -1)
  {
    
    row = table.findRow(data[0],data[1]);
    result = row.getFloat(data[2]);
  }
  else
  {
    row = table.getRow(tableRow); 
      result = row.getFloat(data[0]); 
  }
  return result;
}

synchronized public void SetTableVal(Table table, int tableRow, int format, String[] data)
{
  // data example: SetTableVal(Bools,-1,Table.INT,{"winPatternConfig","Name","bool","0"});
  // data example: SetTableVal(LightData,0,Table.INT,{"LedsAmount","176"});
  TableRow row;
  String columnName;
  String exData;
  if(tableRow == -1)
  {
    row = table.findRow(data[0],data[1]);
    columnName = data[2];
    exData = data[3];
  }
  else
  {
    row = table.getRow(tableRow);
    columnName = data[0];
    exData = data[1];
  }
  if(format == Table.INT)
  {
    row.setInt(columnName,int(exData));
  }
  if(format == Table.STRING)
  {
    row.setString(columnName,exData);
  }
  if(format == Table.FLOAT)
  {
    row.setFloat(columnName,float(exData));
  }
  println("Updated value in column "+columnName+" to "+exData+", table row "+tableRow+".");
  
}

// Currently not being used as SQLite is being used to push and pull kept data.
// Table functions will be used for active light profiles, as memory location lookups will be faster.