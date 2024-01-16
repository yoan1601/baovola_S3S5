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
        for(int i=0; i<desc.size(); i++){
            nom[i] = (String)desc.get(i);
            System.out.println("nom["+i+"] = "+nom[i]);
        }
        
        try{
        Connection connexion = this.getconnexion();
        Statement statement = connexion.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while(resultSet.next()){
            ligne[count] = new Vector();
            for(int u=0; u<desc.size(); u++){
                ligne[count].add(resultSet.getString(nom[u]));
            }
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

    public void updatesql(String sql)throws Exception{
        try{
            Connection connexion = this.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public Object table_to_class(String sql){
        Object valiny = new Object();
    }
}
