package objet;

import java.sql.*;
import java.util.*;

import fonction.Fonction;
import objet.Look;

public class Formule {
    int idformule;
    Modele modele;
    Matiere matiere;
    double quantite;

    public int getidformule() {
        return idformule;
    }

    public void setidformule(int idformule) {
        this.idformule = idformule;
    }

    public Modele getmodele() {
        return modele;
    }

    public void setmodele(Modele modele) {
        this.modele = modele;
    }

    public Matiere getmatiere() {
        return matiere;
    }

    public void setmatiere(Matiere matiere) {
        this.matiere = matiere;
    }

    public double getquantite() {
        return quantite;
    }

    public void setquantite(double quantite) {
        this.quantite = quantite;
    }

    public void insert_formule(Modele modele1, Matiere matiere1, Double quantite1)throws Exception{
        this.setmodele(modele1);
        this.setmatiere(matiere1);
        this.setquantite(quantite1);
        String sql = "";
        sql = "insert into formule (idModele,idMatiere,quantite) values ("+this.getmodele().getidmodele()+","+this.getmatiere().getid_matiere()+","+this.getquantite()+")";
        Fonction func = new Fonction();
        try{
            Connection connexion = func.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public Vector[] get_all_formule(String Table) throws Exception{
        int count = 0;
        int taille = 0;
        Vector[] ligne = new Vector[0];
        Vector desc = new Vector();
        String sql = "select * from v_formule";
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
