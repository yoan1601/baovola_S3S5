package objet;

import java.sql.*;
import java.util.Vector;

import fonction.Fonction;

public class Taille {
    int idtaille;
    String nom_taille;

    public int getidtaille(){
        return this.idtaille;
    }
    public String getnom_taille(){
        return this.nom_taille;
    }

    public void setidtaille(int x){
        this.idtaille = x;
    }
    public void setnom_taille(String x){
        this.nom_taille = x;
    }

    public void insert_type(String nom_taille2){
        this.setnom_taille(nom_taille2);
        String sql = "";
        sql = "insert into taille (nom_taille) values ('"+this.getnom_taille()+"')";
        Fonction func = new Fonction();
        try{
            Connection connexion = func.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public Vector[] get_all_taille(Connection connexion,String Table) throws Exception{
        int count = 0;
        int taille = 0;
        Vector[] ligne = new Vector[0];
        Vector desc = new Vector();
        String sql = "select * from taille";
        try{
            Statement statement = connexion.createStatement();
            DatabaseMetaData metaData = connexion.getMetaData();
            ResultSet resultSet0;
            resultSet0 = metaData.getColumns(null,null,Table,null);
            while(resultSet0.next()){
                desc.add(resultSet0.getString("COLUMN_NAME"));
            }
            ResultSet resultSet1 = statement.executeQuery(sql);
            while(resultSet1.next()){
                taille++;
            }
            ligne = new Vector[taille];
            String[] nom = new String[desc.size()];
            for(int i=0; i<desc.size(); i++)
            {nom[i] = (String)desc.get(i);}
            ResultSet resultSet = statement.executeQuery(sql);
            while(resultSet.next()){
                ligne[count] = new Vector();
                for(int u=0; u<desc.size(); u++)
                {ligne[count].add(resultSet.getString(nom[u]));}
                count++;
            }
            resultSet.close();
            statement.close();
            connexion.close();
        }catch(SQLException e){
            e.printStackTrace();
            throw e;
        }
        return ligne;
    }
}
