package objet;
// import java.sql.Statement;
import java.sql.*;
import java.util.*;
import fonction.*;

public class Type {
    int idtype;
    String nom_type;

    public int getidtype(){
        return this.idtype;
    }
    public String getnom_type(){
        return this.nom_type;
    }

    public void setidtype(int x){
        this.idtype = x;
    }
    public void setnom_type(String x){
        this.nom_type = x;
    }

    public void insert_type(String nom_type2)throws Exception{
        this.setnom_type(nom_type2);
        String sql = "";
        sql = "insert into type (nom_type) values ('"+this.getnom_type()+"')";
        Fonction func = new Fonction();
        try{
            Connection connexion = func.getconnexion();
            Statement statement = connexion.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}
    }

    public Vector[] get_all_type(Connection connexion,String Table,String sql) throws Exception{
        int count = 0;
        int taille = 0;
        Vector[] ligne = new Vector[0];
        Vector desc = new Vector();
        // String sql = "select * from type";
        // Fonction func = new Fonction();
        try{
            // Connection connexion = func.getconnexion();
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
            resultSet0.close();
            resultSet1.close();
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
