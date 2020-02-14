import java.io.File;  // Import the File class
import java.io.FileWriter; 
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files

public class easy { 
  public static void main(String[] args) { 
    try {
      File myObj = new File("input");
      Scanner myReader = new Scanner(myObj);
      FileWriter myWriter = new FileWriter("output");
       
      while (myReader.hasNextLine()) {
        String data = myReader.nextLine();
        String[] arr = data.split("\\s+");
        myWriter.write("\nfunction topPlayersBy"+arr[0]+"(req,res){\n    var query = \" SELECT player_name, AVG("+arr[0]+") AS "+arr[0]+"_avg\\\nFROM Player, Player_Attributes\\\nWHERE Player.player_api_id = Player_Attributes.player_api_id AND "+arr[0]+" > 0\\\nGROUP BY 1\\\nORDER BY 2 DESC\\\nLIMIT 10\\\n; \"\n       connection.query(query,(err,result)=>{\n        res.json(result.rows);        \n    }) \n}\n\n");
        // if(!arr[1].equals("TEXT"))
        // myWriter.write("--update class on updating "+arr[0]+"\n\nCREATE OR REPLACE FUNCTION upd_"+arr[0]+"Class()\nRETURNS trigger AS\n$$\nBEGIN\nIF NEW."+arr[0]+" >=67 THEN\nNEW."+arr[0]+"Class = 'Lots';\nELSEIF NEW."+arr[0]+">=34 THEN\nNEW."+arr[0]+"Class = 'Little';\nELSEIF NEW."+arr[0]+">=0 THEN\nNEW."+arr[0]+"Class = 'Normal';\nELSE\nNEW."+arr[0]+" = OLD."+arr[0]+";\nEND IF;\nRETURN NEW;\nEND;\n$$\nLANGUAGE 'plpgsql';\nCREATE TRIGGER upd_"+arr[0]+" \nAFTER UPDATE OF "+arr[0]+" \nON Team_Attributes\nFOR EACH ROW\nEXECUTE PROCEDURE upd_"+arr[0]+"Class();\n\n");
        //myWriter.write("--update overall ratings on updating "+arr[0]+"\nCREATE OR REPLACE FUNCTION upd_overallRatings_"+arr[0]+"()\nRETURNS trigger AS\n$$\nBEGIN\nNEW.overall_rating = (((NEW."+arr[0]+" - OLD."+arr[0]+")+100)/100)*OLD.overall_rating; \nRETURN NEW;\nEND;\n$$\nLANGUAGE 'plpgsql';\nCREATE TRIGGER upd_player_"+arr[0]+" \nAFTER UPDATE OF "+arr[0]+"\nON Player_Attributes\nFOR EACH ROW\nEXECUTE PROCEDURE upd_overallRatings_"+arr[0]+"();\n\n");
        // else
        // myWriter.write("ADD CHECK "+arr[0]+" >=0 AND "+arr[0]+" <=100,\n");

      }
      myReader.close();
      myWriter.close();
    } catch (Exception e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    } 
  } 
}
