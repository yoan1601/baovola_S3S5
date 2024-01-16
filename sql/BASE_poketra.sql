CREATE SEQUENCE formule_idformule_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE look_idlook_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE lookmatiere_idlookmatiere_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_idmatiere_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_prix_idmatiere_prix_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE modele_idmodele_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE mouvement_stock_idmouvement_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_idtaille_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE type_idtype_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE unite_idunite_seq START WITH 1 INCREMENT BY 1;

CREATE  TABLE look ( 
	idlook               serial NOT NULL  ,
	nomlook              varchar(50)    ,
	CONSTRAINT pk_look PRIMARY KEY ( idlook )
 );

CREATE  TABLE matiere ( 
	idmatiere            serial NOT NULL  ,
	nommatiere           varchar(50)    ,
	idunite              integer DEFAULT 1   ,
	prix                 numeric(10,2) DEFAULT 0 NOT NULL  ,
	CONSTRAINT pk_matiere PRIMARY KEY ( idmatiere )
 );

CREATE  TABLE matiere_prix ( 
	idmatiere_prix       serial NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	prix_actuelle        numeric(10,2) DEFAULT 0 NOT NULL  ,
	dateheureprix        timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	CONSTRAINT pk_matiere_prix PRIMARY KEY ( idmatiere_prix )
 );

CREATE  TABLE mouvement_stock ( 
	idmouvement          serial NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	qteentree            numeric(10,2) DEFAULT 0 NOT NULL  ,
	qtesortie            numeric(10,2) DEFAULT 0 NOT NULL  ,
	dateheuremouvement   timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	prixunitaire         numeric(10,2) DEFAULT 0 NOT NULL  ,
	CONSTRAINT pk_mouvement_stock PRIMARY KEY ( idmouvement )
 );

CREATE  TABLE taille ( 
	idtaille             serial NOT NULL  ,
	nomtaille            varchar(50)  NOT NULL  ,
	CONSTRAINT pk_taille PRIMARY KEY ( idtaille )
 );

CREATE  TABLE "type" ( 
	idtype               serial NOT NULL  ,
	nomtype              varchar(50)  NOT NULL  ,
	CONSTRAINT pk_tbl PRIMARY KEY ( idtype )
 );

CREATE  TABLE unite ( 
	idunite              serial NOT NULL  ,
	nomunite             varchar(10)  NOT NULL  ,
	CONSTRAINT pk_unite PRIMARY KEY ( idunite )
 );

CREATE  TABLE lookmatiere ( 
	idlookmatiere        serial NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	CONSTRAINT pk_lookmatiere PRIMARY KEY ( idlookmatiere )
 );

CREATE  TABLE modele ( 
	idmodele             serial NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idtaille             integer  NOT NULL  ,
	idtype               integer  NOT NULL  ,
	CONSTRAINT pk_modele PRIMARY KEY ( idmodele )
 );

CREATE  TABLE formule ( 
	idformule            serial NOT NULL  ,
	idmodele             integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	quantite             integer  NOT NULL  ,
	CONSTRAINT pk_formule PRIMARY KEY ( idformule )
 );

ALTER TABLE formule ADD CONSTRAINT fk_formule_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere );

ALTER TABLE formule ADD CONSTRAINT fk_formule_modele FOREIGN KEY ( idmodele ) REFERENCES modele( idmodele );

ALTER TABLE lookmatiere ADD CONSTRAINT fk_lookmatiere_look FOREIGN KEY ( idlook ) REFERENCES look( idlook );

ALTER TABLE lookmatiere ADD CONSTRAINT fk_lookmatiere_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere );

ALTER TABLE matiere_prix ADD CONSTRAINT fk_matiere_prix_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere );

ALTER TABLE modele ADD CONSTRAINT fk_modele_look FOREIGN KEY ( idlook ) REFERENCES look( idlook );

ALTER TABLE modele ADD CONSTRAINT fk_modele_taille FOREIGN KEY ( idtaille ) REFERENCES taille( idtaille );

ALTER TABLE modele ADD CONSTRAINT fk_modele_type FOREIGN KEY ( idtype ) REFERENCES "type"( idtype );

ALTER TABLE mouvement_stock ADD CONSTRAINT fk_mouvement_stock_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere );

CREATE VIEW v_lookmatiere AS SELECT look.idlook,
    look.nomlook,
    matiere.idmatiere,
    matiere.nommatiere
   FROM ((lookmatiere
     JOIN look ON ((lookmatiere.idlook = look.idlook)))
     JOIN matiere ON ((matiere.idmatiere = lookmatiere.idmatiere)));

CREATE VIEW v_modele AS SELECT modele.idmodele,
    modele.idlook,
    look.nomlook,
    modele.idtaille,
    taille.nomtaille,
    modele.idtype,
    type.nomtype
   FROM (((modele
     JOIN look ON ((look.idlook = modele.idlook)))
     JOIN taille ON ((taille.idtaille = modele.idtaille)))
     JOIN type ON ((type.idtype = modele.idtype)));

CREATE VIEW v_stock AS SELECT m.idmatiere,
    m.nommatiere,
    (sum(mvmt.qteentree) - sum(mvmt.qtesortie)) AS qterestante
   FROM (matiere m
     JOIN mouvement_stock mvmt ON ((mvmt.idmatiere = m.idmatiere)))
  GROUP BY m.idmatiere, m.nommatiere;

CREATE VIEW v_formule AS SELECT v_modele.idmodele,
    v_modele.idlook,
    v_modele.nomlook,
    v_modele.idtaille,
    v_modele.nomtaille,
    v_modele.idtype,
    v_modele.nomtype,
    formule.idmatiere,
    formule.quantite,
    matiere.nommatiere
   FROM ((v_modele
     JOIN formule ON ((v_modele.idmodele = formule.idmodele)))
     JOIN matiere ON ((formule.idmatiere = matiere.idmatiere)));

CREATE VIEW v_listeproduit AS SELECT v_formule.idmodele,
    v_formule.idlook,
    v_formule.nomlook,
    v_formule.idtaille,
    v_formule.nomtaille,
    v_formule.idtype,
    v_formule.nomtype,
    v_formule.idmatiere,
    v_formule.quantite,
    v_formule.nommatiere,
    m.prix,
    (m.prix * (v_formule.quantite)::numeric) AS prixtotal
   FROM (v_formule
     JOIN matiere m ON ((m.idmatiere = v_formule.idmatiere)));

CREATE VIEW v_prix AS SELECT v_listeproduit.nomlook,
    v_listeproduit.nomtaille,
    v_listeproduit.nomtype,
    sum(v_listeproduit.prixtotal) AS prixtotal
   FROM v_listeproduit
  GROUP BY v_listeproduit.nomlook, v_listeproduit.nomtaille, v_listeproduit.nomtype;

INSERT INTO look( idlook, nomlook ) VALUES ( DEFAULT, 'luxe');
INSERT INTO look( idlook, nomlook ) VALUES ( DEFAULT, 'normal');
INSERT INTO look( idlook, nomlook ) VALUES ( DEFAULT, 'debraille');
INSERT INTO look( idlook, nomlook ) VALUES ( DEFAULT, 'Sweet');
INSERT INTO look( idlook, nomlook ) VALUES ( DEFAULT, 'high');
INSERT INTO look( idlook, nomlook ) VALUES ( DEFAULT, 'dimbaka');
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'cuire', 1, 8000);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'raphia', 1, 1500);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'lamba landy', 1, 50000);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'lamba mena', 1, 4200);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'soga', 1, 5000);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'gony', 2, 3500);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( DEFAULT, 'hazo', 2, 1000);
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 1, 8000, '2024-01-11 09:36:45 AM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 3, 1500, '2024-01-11 02:42:04 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 4, 50000, '2024-01-11 02:42:12 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 5, 4200, '2024-01-11 02:42:21 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 2, 5000, '2024-01-11 02:42:31 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 6, 3500, '2024-01-11 02:42:39 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( DEFAULT, 7, 1000, '2024-01-11 02:42:48 PM');
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( DEFAULT, 1, 10, 0, '2024-01-11 03:43:04 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( DEFAULT, 1, 0, 4, '2024-01-11 04:03:23 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( DEFAULT, 1, 0, 2, '2024-01-11 04:04:09 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( DEFAULT, 2, 11, 0, '2024-01-11 04:07:06 PM', 5000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( DEFAULT, 1, 0, 3, '2024-01-11 04:14:42 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( DEFAULT, 2, 0, 6, '2024-01-11 04:14:42 PM', 5000);
INSERT INTO taille( idtaille, nomtaille ) VALUES ( DEFAULT, 'PM');
INSERT INTO taille( idtaille, nomtaille ) VALUES ( DEFAULT, 'Moyen');
INSERT INTO taille( idtaille, nomtaille ) VALUES ( DEFAULT, 'GM');
INSERT INTO "type"( idtype, nomtype ) VALUES ( DEFAULT, 'sac a dos');
INSERT INTO "type"( idtype, nomtype ) VALUES ( DEFAULT, 'sac a main');
INSERT INTO unite( idunite, nomunite ) VALUES ( DEFAULT, 'm');
INSERT INTO unite( idunite, nomunite ) VALUES ( DEFAULT, 'pieces');
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 1, 1);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 1, 3);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 2, 1);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 3, 1);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 3, 2);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 2, 3);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 4, 4);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 5, 5);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( DEFAULT, 6, 6);
INSERT INTO modele( idmodele, idlook, idtaille, idtype ) VALUES ( DEFAULT, 1, 1, 1);
INSERT INTO modele( idmodele, idlook, idtaille, idtype ) VALUES ( DEFAULT, 1, 2, 1);
INSERT INTO modele( idmodele, idlook, idtaille, idtype ) VALUES ( DEFAULT, 4, 2, 1);
INSERT INTO modele( idmodele, idlook, idtaille, idtype ) VALUES ( DEFAULT, 3, 3, 2);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( DEFAULT, 1, 1, 1);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( DEFAULT, 2, 1, 2);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( DEFAULT, 3, 3, 4);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( DEFAULT, 1, 2, 2);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( DEFAULT, 4, 4, 5);