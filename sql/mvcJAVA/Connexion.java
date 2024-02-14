package mvc;
import java.sql.*;
public class Connexion
{
    // javac -d  \..\..\..\..\..\..\Server\Tomcat\webapps\MVC\WEB-INF\classes *.java  
    // C:\Users\itu\Documents\reseau\webDynamique\mvc
    //   C:\Server\Tomcat\webapps\MVC\WEB-INF\classes
            String driver ;
            String url;
            String user ;
            String password ;

            String getDriver()
            {
                return this.driver;
            }
            String getUrl()
            {
                return this.url;
            }
            String getUser()
            {
                return this.user;
            }
            String getPassword()
            {
                return this.password;
            }
            void setDriver(String d)
            {
                this.driver=d;
            }
            void setUrl(String d)
            {
                this.url=d;
            }
            void setUser(String d)
            {
                this.user=d;
            }
            void setPassword(String d)
            {
                this.password=d;
            }
            public Connexion(String d,String u,String us,String pass)  {
                setDriver(d);
                setUrl(u);
                setUser(us);
                setPassword(pass);
            }

            public Connection connectt() throws Exception
            {
                //mamaetraka ilay driver
                Class.forName(this.getDriver());
                //connecting
                Connection con=DriverManager.getConnection(this.getUrl(),this.getUser(),this.getPassword());
                return con;
            }
            
        public static Connection connecteMysql () throws Exception{ //connexion à MySql
            String driver = "com.mysql.cj.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/mvc";
            String user = "root";
            String password = "";
            Connexion mysql = new Connexion(driver,url,user,password);
            return mysql.connectt();
        }

            
}
