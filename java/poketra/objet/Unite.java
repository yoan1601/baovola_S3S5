package objet;

import java.sql.*;
import java.util.*;

import fonction.Fonction;

public class Unite {
    int idunite;
    String nom_unite;

    public int getidunite() {
        return idunite;
    }

    public void setidunite(int idunite) {
        this.idunite = idunite;
    }

    public String getnom_unite() {
        return nom_unite;
    }

    public void setnom_unite(String nom_unite) {
        this.nom_unite = nom_unite;
    }

    public void insert_unite(String x){
        this.setnom_unite(x);
        String sql = "";
        sql = "insert into unite (nom_unite) values ('"+this.getnom_unite()+"')";
        Fonction func = new Fonction();
        try{
            Connection connexion = func.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public Vector[] get_all_unite(String Table) throws Exception{
        int count = 0;
        int taille = 0;
        Vector[] ligne = new Vector[0];
        Vector desc = new Vector();
        String sql = "select * from unite";
        Fonction func = new Fonction();
        try{
            Connection connexion = func.getconnexion();
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
