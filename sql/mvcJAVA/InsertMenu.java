package mvc;
import java.io.*;
import java.util.UUID;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.nio.*;
import java.util.List;
import java.sql.*;

public class InsertMenu extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        try{
            Menu menu= new Menu(req.getParameter("libelle"),Double.parseDouble(req.getParameter("prix")),Double.parseDouble(req.getParameter("prixRevient")),Integer.parseInt(req.getParameter("IdCat")));
            boolean mety=menu.insertMenu();
            if(mety){
                out.println("insertion NETY");
            }else{
                out.println("insertion TSY NETY");
            }
        }
        catch(Exception e){
            e.printStackTrace();
            out.println(e.getMessage());
        }
        out.close();
        // res.sendRedirect("./insertMenu");
    }
 
}