<%@page import="mvc.*" %>
<%
String [][] menu=(String[][])request.getAttribute("liste");
int lastIndice=0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style/styles.css">

    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <script src="../assets/js/jquery.min.js"> </script>
    <script src="../assets/js/bootstrap.min.js"> </script>

    <title>Menu</title>
</head>
<body>

    <div class="container">
        <h1>Menu</h1>
        <table class="table table-hover">
            <% for(int i=0; i< menu.length; i++) {  %>
            <tr>
                <% for(int o=0; o <menu[i].length; o++) {  %>
                    <% if(o!=4){ %>
                        <th><%= menu[i][o] %>
                        <% lastIndice=o; %>
                        </th>
                    <% }else{ %>
                        <th><%= Fonction.getNomCat(Integer.parseInt(menu[i][o])) %>
                        <% lastIndice=o; %>
                        </th>
                    <% } %>
                <% } %>

                <% if(i!=0){ %> 
                <th><a href="./1?action=delete&id=<%= menu[i][0] %>">delete</a></th>
                <% } else{ %> <th>supprimer</th> <% } %>

                <% if(i!=0){ %> 
                <th><a href="./1?action=update&id=<%= menu[i][0] %>">update</a></th>
                <% } else{ %> <th>modifier</th> <% } %>
                
            </tr>
            <% } %>
        </table>
    </div>
    <a href="./formMenu">insert new Menu</a>
</body>
</html>
