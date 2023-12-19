package objet;
import java.util.Vector;
public class Look {
    int id_look;
    String nom_look;
    Vector liste_matiere;

    public int getid_look()
    {return this.id_look;}
    public String getnom_look()
    {return this.nom_look;}
    public Vector getliste_matiere()
    {return this.liste_matiere;}

    public void setid_look(int x)
    {this.id_look = x;}
    public void setnom_look(String x)
    {this.nom_look = x;}
    public void setliste_matiere(Vector x)
    {this.liste_matiere = x;}
}
