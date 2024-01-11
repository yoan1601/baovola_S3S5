package aff;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Vector;

import objet.*;
public class Aff {
    public static void main(String[] args){
        try{
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String user = "postgres";
            String mdp = "itu16";
            Connection connexion = DriverManager.getConnection(url,user,mdp);
            Type xx = new Type();
            Vector[] test = xx.gettable(connexion,"kindy","select * from kindy");
            for(int i=0; i<test.length; i++){
                for(int j=0; j<test[i].size();j++){
                    System.out.println("test["+i+"]["+j+"] = "+(String)test[i].get(j));
                }
            }
        }catch(Exception e){e.printStackTrace();}
    }
}
