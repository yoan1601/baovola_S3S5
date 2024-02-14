<%@page import="mvc.*" %>
<% Category [] cat=(Category[])request.getAttribute("category");
Menu menu=(Menu)request.getAttribute("menu");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/styles.css">

    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <script src="../assets/js/jquery.min.js"> </script>
    <script src="../assets/js/bootstrap.min.js"> </script>

    <title>Update Menu</title>
</head>
<body>
    <h2>Update Menu</h2>
    <form class="form-horizontal" action='./formMenu' method="POST">
    <label for="libelle">Libelle:</label>
    <input type="hidden" name="id" id="id" value="<%= menu.getId() %>">
    <input type="text" name="libelle" id="libelle" value="<%= menu.getLibelle() %>" required>
    <br>
    <label for="prix">Prix:</label>
    <input type="number" step="0.01" name="prix" id="prix" value="<%= menu.getPrix() %>" required>
    <br>
    <label for="prixRevient">Prix Revient:</label>
    <input type="number" step="0.01" name="prixRevient" id="prixRevient"  value="<%= menu.getPrixRevient() %>"required>
    <br>
    <label for="idCat">Categorie:</label>
    <select name="idCat" id="idCat">
    <% for(int c=0;c<cat.length;c++ ) 
    { 
        if(cat[c].getIdCat()!=menu.getIdCat()) { %>
        <option value="<%=cat[c].getIdCat() %>"><%=cat[c].getNomCat() %></option>
        <% } else{ %>
        <option value="<%=cat[c].getIdCat() %>" selected><%=cat[c].getNomCat() %></option>
        <% } %>
    <% } %>
    </select>
    <br>
    <input type="submit" value="Enter">
</form>

</body>
</html>
