package mvc;

public class Category {
    private int idCat;
    private String nomCat;

    // Constructor
    public Category(int idCat, String nomCat) {
        this.idCat = idCat;
        this.nomCat = nomCat;
    }

    // Getter and Setter for idCat
    public int getIdCat() {
        return idCat;
    }

    public void setIdCat(int idCat) {
        this.idCat = idCat;
    }

    // Getter and Setter for nomCat
    public String getNomCat() {
        return nomCat;
    }

    public void setNomCat(String nomCat) {
        this.nomCat = nomCat;
    }

    // toString method (optional but useful for debugging)
    @Override
    public String toString() {
        return "Category{" +
                "idCat=" + idCat +
                ", nomCat='" + nomCat + '\'' +
                '}';
    }
}
