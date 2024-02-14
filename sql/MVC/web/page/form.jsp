<%@page import="mvc.*" %>
<% Category [] cat=(Category[])request.getAttribute("category");
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

    <title>Insertion</title>
</head>
<body>
    <h2>Insert New</h2>
    <form class="form-horizontal" action='./1' method="POST">
    <label for="libelle">Libelle:</label>
    <input type="text" name="libelle" id="libelle" required>
    <br>
    <label for="prix">Prix:</label>
    <input type="number" step="0.01" name="prix" id="prix" required>
    <br>
    <label for="prixRevient">Prix Revient:</label>
    <input type="number" step="0.01" name="prixRevient" id="prixRevient" required>
    <br>
    <label for="idCat">Categorie:</label>
    <select name="idCat" id="idCat">
    <% for(int c=0;c<cat.length;c++ ) {%>
    <option value="<%=cat[c].getIdCat() %>"><%=cat[c].getNomCat() %></option>
    <% } %>
    </select>
    <br>
    <input type="submit" value="Enter">
</form>

</body>
</html>
