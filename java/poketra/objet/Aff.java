package aff;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Vector;

import fonction.Fonction;
import objet.*;
public class Aff {
    public static void main(String[] args){
        try{
            Matiere x = new Matiere();
            Double valiny = x.getLastPrix(2);
            System.out.println("valiny = "+valiny);
            
        }catch(Exception e){e.printStackTrace();}
    }
}
