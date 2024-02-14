package mvc;
import jakarta.servlet.*;
import java.io.*;
import jakarta.servlet.http.*;
import java.io.IOException;
//miasa
// javac -d \..\..\..\..\..\..\Server\Tomcat\webapps\MVC\WEB-INF\classes *.java
public class Form extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try{
            Category[] tabCat=Fonction.getAllCat();
            request.setAttribute("category", tabCat);
            RequestDispatcher dispat = request.getRequestDispatcher("web/page/form.jsp");
            dispat.forward(request,response);
        }
        catch(Exception e){
            e.printStackTrace();
            out.println(e.getMessage());
            out.println("tsy nety Category");
        }
        out.close();
        
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
        PrintWriter out = res.getWriter();//update
        try{
            Menu menu=Fonction.getMenuById(Integer.parseInt(req.getParameter("id")));
            //  updateMenu(String libelle1,double prix1,double prixRevient1,int idCat1)
            boolean mety=menu.updateMenu(req.getParameter("libelle"),Double.parseDouble(req.getParameter("prix")),Double.parseDouble(req.getParameter("prixRevient")),Integer.parseInt(req.getParameter("idCat")));
            if(mety){
                out.println("update NETY");
                res.sendRedirect("./1");
            }else{
                out.println("update TSY NETY");
            }
        }
        catch(Exception e){
            e.printStackTrace();
            out.println(e.getMessage());
        }
        out.close();
        
    }
    

}
