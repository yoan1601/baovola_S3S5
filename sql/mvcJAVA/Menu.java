package mvc;
import java.nio.*;
import java.util.List;
import java.sql.*;
public class Menu {
    private int id;
    private String libelle;
    private double prix;
    private double prixRevient;
    private int idCat;

    // Constructor with setters
    public Menu(String libelle, double prix, double prixRevient, int cat)throws Exception {
        setId(Fonction.getIdMenu(libelle, prix, prixRevient,cat));
        setLibelle(libelle);
        setPrix(prix);
        setPrixRevient(prixRevient);
        setIdCat(cat);
    }
    public Menu(){}
    
    public Menu(int id,String libelle, double prix, double prixRevient, int cat)throws Exception {
        setId(id);
        setLibelle(libelle);
        setPrix(prix);
        setPrixRevient(prixRevient);
        setIdCat(cat);
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public double getPrixRevient() {
        return prixRevient;
    }

    public void setPrixRevient(double prixRevient) {
        this.prixRevient = prixRevient;
    }

    public int getIdCat() {
        return idCat;
    }

    public void setIdCat(int IdCat) {
        this.idCat = IdCat;
    }

    public boolean insertMenu()throws Exception{ 
        Connection ctM=Connexion.connecteMysql();
        String sql = "INSERT INTO Menu (libelle, prix, prixRevient, IdCat) VALUES ('"+getLibelle()+"', "+getPrix()+", "+getPrixRevient()+","+getIdCat()+")";
        PreparedStatement resultat1 = ctM.prepareStatement(sql); // execute query
        int val= resultat1.executeUpdate();
        resultat1.close();
        ctM.close();
        if(val==0){return false;}
        return true;
    }

    public  boolean deleteMenu()throws Exception{
        Connection ctM=Connexion.connecteMysql();
        String sql = "delete from Menu where id="+getId() ;
        PreparedStatement resultat1 = ctM.prepareStatement(sql); // execute query
        int val= resultat1.executeUpdate();
        resultat1.close();
        ctM.close();
        if(val==0){return false;}
        return true;
    }

    public boolean updateMenu(String libelle1,double prix1,double prixRevient1,int idCat1)throws Exception{
        Connection ctM=Connexion.connecteMysql();
        String sql = "update Menu set libelle='"+libelle1+"' , prix="+prix1+", prixRevient="+prixRevient1+" , idCat="+idCat1+" where id="+this.getId();
        PreparedStatement resultat1 = ctM.prepareStatement(sql); // execute query
        int val= resultat1.executeUpdate();
        resultat1.close();
        ctM.close();
        if(val==0){return false;}
        return true;
    }

    // Menu m =new Menu();
    // m.setPrix(); ---

    
    // Menu m=Fonction.GetMenuById(1); 


    




}
