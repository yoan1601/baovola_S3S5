<%@ include file = "header.jsp" %>
<%@page import="java.util.Vector" %>

<%
    Vector [] listeModeles = (Vector []) request.getAttribute("listeModeles");
    Vector [] listeMatieres = (Vector []) request.getAttribute("listeMatieres");
%>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Projet poketra</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/css/Fixed-navbar-starting-with-transparency-styles.css">
    <link rel="stylesheet" href="assets/css/Fixed-navbar-starting-with-transparency-colors.css">
    <link rel="stylesheet" href="assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="assets/css/Ludens---TomSelect-Form.css">
    <link rel="stylesheet" href="assets/css/Pretty-Footer-.css">
</head>

<body>
    <form style="max-width: 700px;margin: 70px;margin-left: 112px;" role="form" action="UpdatePrixMatiere" method="post">
        <div class="form-group mb-3" style="font-size: 36px;text-align: center;color: rgb(177,28,19);"><label class="form-label" style="font-family: 'Abril Fatface', serif;font-weight: bold;text-decoration:  underline;"><span style="color: rgb(48, 47, 47);">Ajouter une intervalle de prix</span></label></div>
        <div class="form-group mb-3"><label class="form-label">Valeur minimum:</label><input class="form-control" type="number" id="tomSelect3" required="" name="prixMin" style="background: rgb(106,103,103);" placeholder="Veuiller inserer un nombre"></div>
        <hr style="margin-top: 30px;margin-bottom: 10px;">
        <div class="form-group mb-3"><label class="form-label">Valeur maximum:</label><input class="form-control" type="number" id="tomSelect3" required="" name="prixMax" style="background: rgb(106,103,103);" placeholder="Veuiller inserer un nombre"></div>
        <hr style="margin-top: 30px;margin-bottom: 10px;">
        <div class="form-group mb-3"><button class="btn btn-primary d-block w-100" id="submitButton" type="submit"><i class="fas fa-save"></i>&nbsp;OK</button></div>
    </form>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/Fixed-navbar-starting-with-transparency-script.js"></script>
    <script src="assets/js/Ludens---TomSelect-Form-main.js"></script>
</body>

</html>