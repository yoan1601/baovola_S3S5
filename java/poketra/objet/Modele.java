package objet;

import java.sql.*;
import java.util.*;

import fonction.Fonction;
import objet.Look;

public class Modele {
    int idmodele;
    Look look;
    Taille taille;
    Type type;

    public int getidmodele() {
        return idmodele;
    }

    public void setidmodele(int idmodele) {
        this.idmodele = idmodele;
    }

    public Look getlook() {
        return look;
    }

    public void setlook(Look look) {
        this.look = look;
    }

    public Taille gettaille() {
        return taille;
    }

    public void settaille(Taille taille) {
        this.taille = taille;
    }

    public Type gettype() {
        return type;
    }

    public void settype(Type type) {
        this.type = type;
    }

    public void insert_modele(Look look1, Taille taille1, Type type1)throws Exception{
        this.setlook(look1);
        this.settaille(taille1);
        this.settype(type1);
        String sql = "";
        sql = "insert into modele (idLook,idTaille,idType) values ("+this.getlook().getid_look()+","+this.gettaille().getidtaille()+","+this.gettype().getidtype()+")";
        Fonction func = new Fonction();
        try{
            Connection connexion = func.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }
    public Vector[] get_all_modele(String Table) throws Exception{
        int count = 0;
        int taille = 0;
        Vector[] ligne = new Vector[0];
        Vector desc = new Vector();
        String sql = "select * from modele";
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
    public void majPrixVente(int idModele,double prixVente)throws Exception{
        Fonction fonction = new Fonction();
        try{
            fonction.updatesql("update modele set prixVente="+prixVente+" where idModele="+idModele);
            fonction.updatesql("insert into prixVenteModele values (Default,"+idModele+",'"+prixVente+"',Default)");
        }catch(SQLException e){e.printStackTrace();}
    }
}
