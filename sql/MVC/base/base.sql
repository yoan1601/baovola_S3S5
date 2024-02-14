create database mvc;
use mvc;


CREATE TABLE Category (
    idCat INT AUTO_INCREMENT PRIMARY KEY,
    nomCat VARCHAR(50)
);

CREATE TABLE Menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50),
    prix DECIMAL(12,3),
    prixRevient DECIMAL(12,3),
    idCat int 
);

ALTER TABLE Menu
ADD CONSTRAINT fk_idCatMenu
FOREIGN KEY (idCat)
REFERENCES Category(idCat);


