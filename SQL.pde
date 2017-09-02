import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;

SQLite db;
TableRow row;
boolean db_connected;
boolean SQL_State_Locked;
public void SQL_Load()
{
  db = new SQLite(this,"data/db.db");
  db.connect();
  if(db.connect())
  {
    db_connected = true;
    println("Database Connected.");
    db.execute("DELETE FROM Lights");
    println("Lights table cleared");
  }
  
}

public void SQL_Add_Light(int ProductID)
{
  if(!db_connected)
  {
    println("SQL_Add_Light failed. Database not connected!");
  }
  else
  {
      
      db.query("INSERT INTO Lights ('Product_ID') VALUES("+ProductID+")");
      println("Added "+ProductID+" into database.");
    
    
      
      
    
  }
  
  
}


public void SQL_Get_Light_Details(int LightID)
{
  int ProductID;
  int[] PatternIDs = {0};
  String[] PatternNames = {""};
  int cnt = 0;
  println("Light Details:");
  db.query("SELECT * FROM Product JOIN Lights on Lights.Product_ID = Product.ID WHERE Lights.Light_ID = "+LightID);
  ProductID = db.getInt("Product_ID");
  println("Product Name: "+db.getString("Name")+" : Product ID: "+ProductID);
  //delay(500);
  println("Works with:");
  db.query("SELECT * FROM PatternType JOIN PatternCompatible on PatternCompatible.Pattern_ID = PatternType.ID WHERE PatternCompatible.Product_ID = "+ProductID);
  while(db.next())
  {
    println(db.getInt("ID")+": "+db.getString("Name"));
  }
  
}





/*
public void SQL_Add_Light(int ProductID)
{
  if(!db_connected)
  {
    println("SQL_Add_Light failed. Database not connected!");
  }
  else
  {
    db.query("SELECT * FROM Lights");
    boolean exists = false;
    println("Reading Database...");
    while(db.next())
    {
      if(db.getInt("Product_ID") == ProductID)
      {
        println("ProductID already exists in database. No need to add!");
        exists = true;
      }
    }
    if(!exists)
    {
      db.query("INSERT INTO Lights ('Product_ID') VALUES("+ProductID+")");
      println("Added "+ProductID+" into database.");
    }
    
      
      
    
  }
  
  
}
*/