package bouquet;
import java.sql.Connection;
import java.sql.SQLException;

public class Bouquet {
    int id;
    String designation;

    public int getid()
    {return this.id;}
    public String getdesignation()
    {return this.designation;}

    public void setid(int x)
    {this.id = x;}
    public void setdesignation(String x)
    {this.designation = x;}

    public void insertbouquet(Connection con, String designation){
        String sql = "insert into bouquet (designation) values ('"+designation+"')";
        try{
            Statement statement = con.createStatement();
            statement.executeUpdate(sql);
            statement.close();
            connexion.close();
        }catch(SQLException e){e.printStackTrace();}

    }
}
