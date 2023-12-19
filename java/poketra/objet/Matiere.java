package objet;

import java.text.Normalizer.Form;
import java.util.Vector;

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

}
