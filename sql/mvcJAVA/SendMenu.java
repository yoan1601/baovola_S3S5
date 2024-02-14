package mvc;
import java.io.*;
import java.util.UUID;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SendMenu extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
        try{
            String [][] Listemenu=Fonction.getAllMenu();
            req.setAttribute("liste", Listemenu);
            RequestDispatcher dispat = req.getRequestDispatcher("web/page/index.jsp");
            dispat.forward(req,res);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}