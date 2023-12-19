<%@ include file = "header.jsp" %>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Projet poketra</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abril+Fatface&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Cookie&amp;display=swap">
    <link rel="stylesheet" href="assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/css/Fixed-navbar-starting-with-transparency-styles.css">
    <link rel="stylesheet" href="assets/css/Fixed-navbar-starting-with-transparency-colors.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tom-select@2.0.1/dist/css/tom-select.css">
    <link rel="stylesheet" href="assets/css/Login-Form-Basic-icons.css">
    <link rel="stylesheet" href="assets/css/Ludens---TomSelect-Form.css">
    <link rel="stylesheet" href="assets/css/Pretty-Footer-.css">
</head>

<body>
    <form style="max-width: 700px;margin: 70px;margin-left: 112px;" role="form" action="indexTeachers.html" method="post" enctype="multipart/form-data">
        <div class="form-group mb-3" style="font-size: 36px;text-align: center;color: rgb(177,28,19);"><label class="form-label" style="font-family: 'Abril Fatface', serif;font-weight: bold;text-decoration:  underline;"><span style="color: rgb(48, 47, 47);">Ajout formule pour un modele</span></label></div>
        <div class="form-group mb-3"><label class="form-label" style="border-color: rgb(242,7,7);">Modele:&nbsp;</label><select class="form-select" id="tomSelect2" required="" name="Type" style="background: rgb(108,108,108);">
                <option value="1">sac a dos </option>
                <option value="2">sac a main</option>
            </select></div>
        <div class="form-group mb-3"><label class="form-label">Matiere:&nbsp;</label><select class="form-select" id="tomSelect-1" required="" name="look" style="background: rgb(116,116,116);">
                <option value="1">cuire</option>
                <option value="2">raphia</option>
            </select></div>
        <div class="form-group mb-3"><label class="form-label">Quantite:</label><input class="form-control" type="number" id="tomSelect3" required="" name="quantite" style="background: rgb(106,103,103);" placeholder="Veuiller inserer un nombre"></div>
        <hr style="margin-top: 30px;margin-bottom: 10px;">
        <div class="form-group mb-3"><button class="btn btn-primary d-block w-100" id="submitButton" type="submit"><i class="fas fa-save"></i>&nbsp;Ajouter</button></div>
    </form>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/Fixed-navbar-starting-with-transparency-script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/tom-select@2.0.1/dist/js/tom-select.complete.min.js"></script>
    <script src="assets/js/Ludens---TomSelect-Form-main.js"></script>
</body>

</html>