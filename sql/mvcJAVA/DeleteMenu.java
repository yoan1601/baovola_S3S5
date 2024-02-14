// package mvc;
// import java.io.*;
// import java.util.UUID;
// import jakarta.servlet.*;
// import jakarta.servlet.http.*;
// import java.nio.*;
// import java.util.List;
// import java.sql.*;

// public class DeleteMenu extends HttpServlet {
//     protected void doPost(HttpServletRequest req, HttpServletResponse res)
//     throws ServletException, IOException {
//         PrintWriter out = res.getWriter();
//         try{
//             int id=Integer.parseInt(req.getParameter("id"));
//             //fonction delete
//             boolean mety=Fonction.deletePlat(id);
//             if(mety){
//                 out.println("suppression NETY");
//             }else{
//                 out.println("suppression TSY NETY");
//             }
//         }
//         catch(Exception e){
//             e.printStackTrace();
//             out.println(e.getMessage());
//         }
//         out.close();
//         // res.sendRedirect("./1");//plat Servlet
//     }
 
// }