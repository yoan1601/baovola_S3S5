package mvc;
import java.io.*;
import java.util.ArrayList;
import java.nio.*;
import java.util.List;
import java.sql.*;
public class Fonction{

    public static String[][] getAllMenu()throws Exception{ 
        // String [][] errorTab= new String [1][5];
        // for(int i=0;i<5;i++){
        //     errorTab[0][i]="error";
        // }
        // try{
            Connection ctM=Connexion.connecteMysql();
            String sql="select * from Menu";
            int cout=0;

            PreparedStatement ps = ctM.prepareStatement(sql);
            ResultSet resultat = ps.executeQuery();
            while (resultat.next()) {
                cout++; //isa donne ligne
            }
            resultat.close();
            ps.close();

            int column=5; //for now 
            String [][] tab=new String[cout+1][column];
            tab[0][0]="id";
            tab[0][1]="libelle";
            tab[0][2]="prix";
            tab[0][3]="prixRevient";
            tab[0][4]="cat";

            PreparedStatement ps1 = ctM.prepareStatement(sql);
            ResultSet resultat1 = ps1.executeQuery();
            int indice=1;
            while (resultat1.next()) {
                tab[indice][0] = resultat1.getString("id");
                tab[indice][1] = resultat1.getString("libelle");
                tab[indice][2] = resultat1.getString("prix");
                tab[indice][3] = resultat1.getString("prixRevient");
                tab[indice][4] = resultat1.getString("IdCat");
                indice++;
            }
            resultat1.close();
            ps1.close();

        
            ctM.close();
            System.out.println("ato am try");
            return tab;
        // }
        // catch(Exception e){
        //     System.out.println("ato am catch");
        //     System.out.println(e.getMessage());
        //     e.printStackTrace();
        // }
        // return errorTab;
    }

    public static String makeTable(String [][] table){
        StringBuilder tableString = new StringBuilder();

        // Determine column widths
        int[] columnWidths = new int[table[0].length];
        for (int col = 0; col < table[0].length; col++) {
            for (String[] row : table) {
                columnWidths[col] = Math.max(columnWidths[col], row[col].length());
            }
        }

        // Append table header
        for (int col = 0; col < table[0].length; col++) {
            tableString.append(String.format("%-" + (columnWidths[col] + 2) + "s", table[0][col]));
        }
        tableString.append("\n");

        // Append separator
        for (int col = 0; col < table[0].length; col++) {
            for (int i = 0; i < columnWidths[col] + 2; i++) {
                tableString.append("-");
            }
        }
        tableString.append("\n");

        // Append table data
        for (int row = 1; row < table.length; row++) {
            for (int col = 0; col < table[row].length; col++) {
                tableString.append(String.format("%-" + (columnWidths[col] + 2) + "s", table[row][col]));
            }
            tableString.append("\n");
        }

        return tableString.toString();
    }

    public static boolean insertMenu(String libelle, double prix, double prixRevient,int cat)throws Exception{ 
        Connection ctM=Connexion.connecteMysql();
        String sql = "INSERT INTO Menu (libelle, prix, prixRevient, idCat) VALUES ('"+libelle+"', "+prix+", "+prixRevient+","+cat+")";
        PreparedStatement resultat1 = ctM.prepareStatement(sql); // execute query
        int val= resultat1.executeUpdate();
        resultat1.close();
        ctM.close();
        if(val==0){return false;}
        return true;
    }

    public static int getIdMenu(String libelle, double prix, double prixRevient,int cat)throws Exception{
        Connection ctM=Connexion.connecteMysql();
        String sql="select id from Menu where libelle='"+libelle+"' and prix="+prix+"  and prixRevient="+prixRevient+" and idCat="+cat;
        PreparedStatement ps1 = ctM.prepareStatement(sql);
        ResultSet resultat1 = ps1.executeQuery();
        int indice=0;
        while (resultat1.next()) {
            indice = Integer.parseInt(resultat1.getString("id"));
        }
        resultat1.close();
        ps1.close();
        ctM.close();
        return indice;
    }
    
    public static Category[] getAllCat()throws Exception{
        Connection ctM=Connexion.connecteMysql();
        ArrayList tab=new ArrayList();
        String sql="select * from Category";
        PreparedStatement ps1 = ctM.prepareStatement(sql);
        ResultSet resultat1 = ps1.executeQuery();
        int indice=1;
        while (resultat1.next()) {
            Category cat=new Category(Integer.parseInt(resultat1.getString("idCat")),resultat1.getString("nomCat"));
            tab.add(cat);
        }
        resultat1.close();
        ps1.close();
        ctM.close();
        Category[] catArray =(Category[]) tab.toArray(new Category[tab.size()]);
        return catArray;
    }

    public static Menu getMenuById(int id)throws Exception{ 
        Connection ctM=Connexion.connecteMysql();
        String sql="select * from Menu where id="+id;
        PreparedStatement ps1 = ctM.prepareStatement(sql);
        ResultSet resultat1 = ps1.executeQuery();
        int indice=1;
        Menu menu=new Menu();
        while (resultat1.next()) {
            menu.setId(id);
            menu.setLibelle(resultat1.getString("libelle"));
            menu.setPrix( Double.parseDouble(resultat1.getString("prix")));
            menu.setPrixRevient(Double.parseDouble(resultat1.getString("prixRevient")));
            menu.setIdCat(Integer.parseInt(resultat1.getString("idCat")));
        }
        resultat1.close();
        ps1.close();
        ctM.close();
        return menu;

        //void
        //Menu m=new Menu(); [main]
        //m.getMenuById(1); [main]
        //fonction this.setPrix(278);  this.setNom("hhuos");[fonction any am Menu]
        //return void; [fonction]

        //mampiasa PreparedStatement ??
        // "select * from Menu where id = ? " 
        //ps.pa---(1,5)




    }

    public static String getNomCat(int idCat)throws Exception{ //mety 
        Connection ctM=null;
        PreparedStatement ps1=null;
        ResultSet resultat1=null;
        String nom=null;
        try{
            ctM = Connexion.connecteMysql(); // commit
            String sql = "SELECT nomCat FROM  Category WHERE idCat = ?";
            ps1 = ctM.prepareStatement(sql);
            ps1.setInt(1, idCat); // Set the value for the parameter
            resultat1 = ps1.executeQuery();
            while (resultat1.next()) {
                nom = resultat1.getString("nomCat"); // Fix the column name to "nomCat"
            }
        }
        catch(Exception e){
            //if(ctM!=null){rollback} //rehefa tsy select
            throw e;
        }
        finally{
            resultat1.close();
            ps1.close();
            ctM.close();
        }
        return nom;
    }
}