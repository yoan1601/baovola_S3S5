package objet;
import java.text.Normalizer.Form;
import java.util.Vector;

import fonction.Fonction;


public class Matiere {
    int id_matiere;
    String nom_matiere;
    Unite unite;
    Vector<Formule> listeformule;

    public int getid_matiere()
    {return this.id_matiere;}
    public String getnom_matiere()
    {return this.nom_matiere;}

    public void setid_matiere(int x)
    {this.id_matiere = x;}
    public void setnom_matiere(String x)
    {this.nom_matiere = x;}

    public Unite getunite() {
        return unite;
    }

    public void setunite(Unite unite) {
        this.unite = unite;
    }

    public Vector<Formule> getlisteformule() {
        return listeformule;
    }

    public void setlisteformule(Vector<Formule> listeformule) {
        this.listeformule = listeformule;
    }

    public Double getLastPrix(int idMatiere){
        Fonction func = new Fonction();
        Vector[] allprice = func.gettable("matiere_prix", "select * prix_actuelle from matiere_prix where idMatiere="+idMatiere+" and dateHeurePrix=(select * MAX(dateHeurePrix) from matiere_prix where idMatiere="+idMatiere+")");
        Double valiny = Double.parseDouble((String)allprice[0].get(0));
        return valiny;
    }

    public void acheter(int idMatiere,double quantite)throws Exception{
        try{
            Fonction Func = new Fonction();
            Func.updatesql("insert into mouvement_stock values(DEFAULT,"+idMatiere+",'"+quantite+"',0,DEFAULT,'"+this.getLastPrix(idMatiere)+"')");
        }catch(Exception e){e.printStackTrace();}
    }
}
