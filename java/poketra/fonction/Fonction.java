package fonction;
import java.sql.*;
import java.util.*;
public class Fonction {
    public Connection getconnexion()throws Exception{
        // String url = "";
        // String mdp = "";
        // String user = "";
        String url = "jdbc:postgresql://localhost:5432/postgres";
        String user = "postgres";
        String mdp = "itu16";
        Connection connexion = DriverManager.getConnection(url,user,mdp);
        return connexion;
    }

    public Vector desc(String Table)throws Exception{
        Vector indesc = new Vector();
        try{
        Connection connexion = this.getconnexion();
        Statement statement = connexion.createStatement();
        ResultSet resultSet;
        DatabaseMetaData metaData = connexion.getMetaData();
        resultSet = metaData.getColumns(null,null,Table,null);
        while(resultSet.next()){
            indesc.add(resultSet.getString("COLUMN_NAME"));
        }
        resultSet.close();
        statement.close();
        connexion.close();
        }catch(SQLException e){e.printStackTrace();}
        return indesc;
    }

    public int countline(String sql)throws Exception{
        int compte = 0;
        try{
        Connection connexion = this.getconnexion();
        Statement statement = connexion.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while(resultSet.next()){
            compte++;
        }
        }catch(SQLException e){e.printStackTrace();}
        return compte;
    }

    public Vector[] gettable(String Table,String sql) throws Exception{
        int count = 0;
        int taille = this.countline(sql);
        Vector desc = this.desc(Table);
        Vector[] ligne = new Vector[taille];
        String[] nom = new String[desc.size()];
        for(int i=0; i<desc.size(); i++)
        {nom[i] = (String)desc.get(i);} 
        
        try{
        Connection connexion = this.getconnexion();
        Statement statement = connexion.createStatement();
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


    public void insertlook(Connection connexion, int idlook, String nomlook){
        String sql = "";
        sql = "insert into look (idlook,nomlook) values ("+idlook+",'"+nomlook+"')";
        try{
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public void insertmatiere(Connection connexion,int idmatiere, String nommatiere){
        String sql = "";
        sql = "insert into matiere (idmatiere,nommatiere) values ("+idmatiere+",'"+nommatiere+"')";
        try{
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public void insertmatiereinlook(Connection connexion, int idlook, int idmatiere){
        String sql = "";
        sql = "insert into lookmatiere (idmatiere,nommatiere) values ("+idlook+","+idmatiere+")";
        try{
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public void updatesql(String sql){
        try{
            Connection connexion = this.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public Vector[] getv_benefice()throws Exception{
        Vector[] vbenefice = new Vector[0];
        try{
            vbenefice = this.gettable("v_benefice","select * from v_benefice");
        }catch(Exception e){e.printStackTrace();}
        return vbenefice;
    }

    public void insertTypeEmplore(String nom,double tauxHoraire)throws Exception{
        try{
            this.updatesql("insert into typeEmploye values (Default,'"+nom+"','"+tauxHoraire+"')");
        }catch(Exception e){e.printStackTrace();}
    }

    public void newRAModele (int idModele, int idTypeEmp, double nombre)throws Exception{
        try{
            this.updatesql("insert into ressource_humaine values (Default,"+idModele+","+idTypeEmp+",'"+nombre+"')");
        }catch(Exception e){e.printStackTrace();}
    }

    public Vector[] getListeProduitBenefice(double prixMin, double prixMax)throws Exception{
        Vector[] vbenefice = new Vector[0];
        try{
            vbenefice = this.gettable("v_benefice","select * from v_benefice where benefice >= "+prixMin+" and benefice <="+prixMax);
        }catch(Exception e){e.printStackTrace();}
        return vbenefice;
    }
}
