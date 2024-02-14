package mvc;
import java.io.*;
import java.util.UUID;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.nio.*;
import java.util.List;
import java.sql.*;
//miasa
public class PlatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        try{
            Menu menu= new Menu(req.getParameter("libelle"),Double.parseDouble(req.getParameter("prix")),Double.parseDouble(req.getParameter("prixRevient")),Integer.parseInt(req.getParameter("idCat")));
            boolean mety=menu.insertMenu();
            if(mety){
                out.println("insertion NETY");
                res.sendRedirect("./1");
            }else{
                out.println("insertion TSY NETY");
            }
        }
        catch(Exception e){
            e.printStackTrace();
            out.println(e.getMessage());
        }
        out.close();
        
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        try{
            if(req.getParameter("action")!=null && !req.getParameter("action").isEmpty() && req.getParameter("id")!=null && !req.getParameter("id").isEmpty()){
                if(req.getParameter("action").equalsIgnoreCase("delete")){
                    Menu menu=Fonction.getMenuById(Integer.parseInt(req.getParameter("id")));
                    boolean nety=menu.deleteMenu();
                     if(nety){
                        res.sendRedirect("./1");
                    }else{
                        out.println("delete unsuccesful");
                    }
                }else if(req.getParameter("action").equalsIgnoreCase("update")){
                    Menu menu=Fonction.getMenuById(Integer.parseInt(req.getParameter("id")));
                    req.setAttribute("menu", menu);
                    Category[] tabCat=Fonction.getAllCat();
                    req.setAttribute("category", tabCat);
                    RequestDispatcher dispat = req.getRequestDispatcher("web/page/updateMenu.jsp");
                    dispat.forward(req,res);
                    
                }
            }
        }catch(Exception e){
            out.println(e.getMessage());
            e.printStackTrace();
        }
        

        try{
            String [][] Listemenu=Fonction.getAllMenu();
            req.setAttribute("liste", Listemenu);
            RequestDispatcher dispat = req.getRequestDispatcher("web/page/index.jsp");
            dispat.forward(req,res);
        }catch(Exception e){
            e.printStackTrace();
            out.println(e.getMessage());
        }
        out.close();
    }
 
}