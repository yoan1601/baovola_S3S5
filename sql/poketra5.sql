CREATE SCHEMA IF NOT EXISTS "public";

CREATE SEQUENCE formule_idformule_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE formule_idformule_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE look_idlook_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE look_idlook_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE lookmatiere_idlookmatiere_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE lookmatiere_idlookmatiere_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_idmatiere_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_idmatiere_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_prix_idmatiere_prix_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_prix_idmatiere_prix_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE modele_idmodele_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE modele_idmodele_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE mouvement_stock_idmouvement_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE mouvement_stock_idmouvement_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_idtaille_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_idtaille_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE type_idtype_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE type_idtype_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE unite_idunite_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE unite_idunite_seq1 AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE look ( 
	idlook               serial DEFAULT nextval('look_idlook_seq1'::regclass) NOT NULL  ,
	nomlook              varchar(50)    ,
	CONSTRAINT pk_look PRIMARY KEY ( idlook )
 );

CREATE  TABLE matiere ( 
	idmatiere            serial DEFAULT nextval('matiere_idmatiere_seq1'::regclass) NOT NULL  ,
	nommatiere           varchar(50)    ,
	idunite              integer DEFAULT 1   ,
	prix                 numeric(10,2) DEFAULT 0 NOT NULL  ,
	CONSTRAINT pk_matiere PRIMARY KEY ( idmatiere )
 );

CREATE  TABLE matiere_prix ( 
	idmatiere_prix       serial DEFAULT nextval('matiere_prix_idmatiere_prix_seq1'::regclass) NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	prix_actuelle        numeric(10,2) DEFAULT 0 NOT NULL  ,
	dateheureprix        timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	CONSTRAINT pk_matiere_prix PRIMARY KEY ( idmatiere_prix ),
	CONSTRAINT fk_matiere_prix_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   
 );

CREATE  TABLE mouvement_stock ( 
	idmouvement          serial DEFAULT nextval('mouvement_stock_idmouvement_seq1'::regclass) NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	qteentree            numeric(10,2) DEFAULT 0 NOT NULL  ,
	qtesortie            numeric(10,2) DEFAULT 0 NOT NULL  ,
	dateheuremouvement   timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	prixunitaire         numeric(10,2) DEFAULT 0 NOT NULL  ,
	CONSTRAINT pk_mouvement_stock PRIMARY KEY ( idmouvement ),
	CONSTRAINT fk_mouvement_stock_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   
 );

CREATE  TABLE taille ( 
	idtaille             serial DEFAULT nextval('taille_idtaille_seq1'::regclass) NOT NULL  ,
	nomtaille            varchar(50)  NOT NULL  ,
	CONSTRAINT pk_taille PRIMARY KEY ( idtaille )
 );

CREATE  TABLE "type" ( 
	idtype               serial DEFAULT nextval('type_idtype_seq1'::regclass) NOT NULL  ,
	nomtype              varchar(50)  NOT NULL  ,
	CONSTRAINT pk_tbl PRIMARY KEY ( idtype )
 );

CREATE  TABLE typeemploye ( 
	idtypeemploye        serial  NOT NULL  ,
	nomtypeemploye       varchar(255)  NOT NULL  ,
	tauxhoraire          numeric(10,2)  NOT NULL  ,
	CONSTRAINT pk_typeemploye PRIMARY KEY ( idtypeemploye )
 );

CREATE  TABLE unite ( 
	idunite              serial DEFAULT nextval('unite_idunite_seq1'::regclass) NOT NULL  ,
	nomunite             varchar(10)  NOT NULL  ,
	CONSTRAINT pk_unite PRIMARY KEY ( idunite )
 );

CREATE  TABLE dureetype ( 
	iddureetype          serial  NOT NULL  ,
	idtype               integer  NOT NULL  ,
	duree                numeric(10,2)  NOT NULL  ,
	dateheureduree       timestamp DEFAULT CURRENT_DATE NOT NULL  ,
	CONSTRAINT pk_dureetype PRIMARY KEY ( iddureetype ),
	CONSTRAINT fk_dureetype_type FOREIGN KEY ( idtype ) REFERENCES "type"( idtype )   
 );

CREATE  TABLE lookmatiere ( 
	idlookmatiere        serial DEFAULT nextval('lookmatiere_idlookmatiere_seq1'::regclass) NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	CONSTRAINT pk_lookmatiere PRIMARY KEY ( idlookmatiere ),
	CONSTRAINT fk_lookmatiere_look FOREIGN KEY ( idlook ) REFERENCES look( idlook )   ,
	CONSTRAINT fk_lookmatiere_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   
 );

CREATE  TABLE modele ( 
	idmodele             serial DEFAULT nextval('modele_idmodele_seq1'::regclass) NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idtaille             integer  NOT NULL  ,
	idtype               integer  NOT NULL  ,
	prixvente            numeric(10,2) DEFAULT 0   ,
	CONSTRAINT pk_modele PRIMARY KEY ( idmodele ),
	CONSTRAINT fk_modele_look FOREIGN KEY ( idlook ) REFERENCES look( idlook )   ,
	CONSTRAINT fk_modele_taille FOREIGN KEY ( idtaille ) REFERENCES taille( idtaille )   ,
	CONSTRAINT fk_modele_type FOREIGN KEY ( idtype ) REFERENCES "type"( idtype )   
 );

CREATE  TABLE nbemptaille ( 
	idnbemptaille        serial  NOT NULL  ,
	idtaille             integer  NOT NULL  ,
	nbemp                numeric(10,2)  NOT NULL  ,
	dateheurenb          timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	CONSTRAINT pk_nbemptable PRIMARY KEY ( idnbemptaille ),
	CONSTRAINT fk_nbemptaille_taille FOREIGN KEY ( idtaille ) REFERENCES taille( idtaille )   
 );

CREATE  TABLE ressource_humaine ( 
	idrh                 serial  NOT NULL  ,
	idmodele             integer  NOT NULL  ,
	idtypeemploye        integer  NOT NULL  ,
	nombre               numeric(10,2)  NOT NULL  ,
	CONSTRAINT pk_ressource_humaine PRIMARY KEY ( idrh ),
	CONSTRAINT fk_ressource_humaine_modele FOREIGN KEY ( idmodele ) REFERENCES modele( idmodele )   ,
	CONSTRAINT fk_ressource_humaine_typeemploye FOREIGN KEY ( idtypeemploye ) REFERENCES typeemploye( idtypeemploye )   
 );

CREATE  TABLE formule ( 
	idformule            serial DEFAULT nextval('formule_idformule_seq1'::regclass) NOT NULL  ,
	idmodele             integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	quantite             integer  NOT NULL  ,
	CONSTRAINT pk_formule PRIMARY KEY ( idformule ),
	CONSTRAINT fk_formule_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   ,
	CONSTRAINT fk_formule_modele FOREIGN KEY ( idmodele ) REFERENCES modele( idmodele )   
 );

CREATE OR REPLACE VIEW v_formule AS SELECT v_modele.idmodele, v_modele.idlook, v_modele.nomlook, v_modele.idtaille, v_modele.nomtaille, v_modele.idtype, v_modele.nomtype, formule.idmatiere, formule.quantite, matiere.nommatiere FROM ((v_modele JOIN formule ON ((v_modele.idmodele = formule.idmodele))) JOIN matiere ON ((formule.idmatiere = matiere.idmatiere)))
 SELECT v_modele.idmodele,
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

CREATE OR REPLACE VIEW v_listeproduit AS SELECT v_formule.idmodele, v_formule.idlook, v_formule.nomlook, v_formule.idtaille, v_formule.nomtaille, v_formule.idtype, v_formule.nomtype, v_formule.idmatiere, v_formule.quantite, v_formule.nommatiere, m.prix, (m.prix * (v_formule.quantite)::numeric) AS prixtotal FROM (v_formule JOIN matiere m ON ((m.idmatiere = v_formule.idmatiere)))
 SELECT v_formule.idmodele,
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

CREATE OR REPLACE VIEW v_lookmatiere AS SELECT look.idlook, look.nomlook, matiere.idmatiere, matiere.nommatiere FROM ((lookmatiere JOIN look ON ((lookmatiere.idlook = look.idlook))) JOIN matiere ON ((matiere.idmatiere = lookmatiere.idmatiere)))
 SELECT look.idlook,
    look.nomlook,
    matiere.idmatiere,
    matiere.nommatiere
   FROM ((lookmatiere
     JOIN look ON ((lookmatiere.idlook = look.idlook)))
     JOIN matiere ON ((matiere.idmatiere = lookmatiere.idmatiere)));

CREATE OR REPLACE VIEW v_modele AS SELECT modele.idmodele, modele.idlook, look.nomlook, modele.idtaille, taille.nomtaille, modele.idtype, type.nomtype FROM (((modele JOIN look ON ((look.idlook = modele.idlook))) JOIN taille ON ((taille.idtaille = modele.idtaille))) JOIN type ON ((type.idtype = modele.idtype)))
 SELECT modele.idmodele,
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

drop view v_prix; 

CREATE OR REPLACE VIEW v_prix AS
SELECT
    v_listeproduit.nomlook,
    v_listeproduit.nomtaille,
    v_listeproduit.nomtype,
    v_listeproduit.idmodele,
    sum(v_listeproduit.prixtotal) AS prixtotal
FROM v_listeproduit
GROUP BY 
    v_listeproduit.nomlook,
    v_listeproduit.nomtaille,
    v_listeproduit.nomtype,
    v_listeproduit.idmodele;

	
CREATE OR REPLACE VIEW v_stock AS SELECT m.idmatiere, m.nommatiere, (sum(mvmt.qteentree) - sum(mvmt.qtesortie)) AS qterestante FROM (matiere m JOIN mouvement_stock mvmt ON ((mvmt.idmatiere = m.idmatiere))) GROUP BY m.idmatiere, m.nommatiere
 SELECT m.idmatiere,
    m.nommatiere,
    (sum(mvmt.qteentree) - sum(mvmt.qtesortie)) AS qterestante
   FROM (matiere m
     JOIN mouvement_stock mvmt ON ((mvmt.idmatiere = m.idmatiere)))
  GROUP BY m.idmatiere, m.nommatiere;

INSERT INTO look( idlook, nomlook ) VALUES ( 1, 'luxe');
INSERT INTO look( idlook, nomlook ) VALUES ( 2, 'normal');
INSERT INTO look( idlook, nomlook ) VALUES ( 3, 'debraille');
INSERT INTO look( idlook, nomlook ) VALUES ( 4, 'Sweet');
INSERT INTO look( idlook, nomlook ) VALUES ( 5, 'high');
INSERT INTO look( idlook, nomlook ) VALUES ( 6, 'dimbaka');
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 1, 'cuire', 1, 8000);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 2, 'raphia', 1, 1500);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 3, 'lamba landy', 1, 50000);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 4, 'lamba mena', 1, 4200);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 5, 'soga', 1, 5000);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 6, 'gony', 2, 3500);
INSERT INTO matiere( idmatiere, nommatiere, idunite, prix ) VALUES ( 7, 'hazo', 2, 1000);
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 1, 1, 8000, '2024-01-11 09:36:45 AM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 2, 3, 1500, '2024-01-11 02:42:04 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 3, 4, 50000, '2024-01-11 02:42:12 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 4, 5, 4200, '2024-01-11 02:42:21 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 5, 2, 5000, '2024-01-11 02:42:31 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 6, 6, 3500, '2024-01-11 02:42:39 PM');
INSERT INTO matiere_prix( idmatiere_prix, idmatiere, prix_actuelle, dateheureprix ) VALUES ( 7, 7, 1000, '2024-01-11 02:42:48 PM');
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( 1, 1, 10, 0, '2024-01-11 03:43:04 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( 2, 1, 0, 4, '2024-01-11 04:03:23 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( 3, 1, 0, 2, '2024-01-11 04:04:09 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( 4, 2, 11, 0, '2024-01-11 04:07:06 PM', 5000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( 5, 1, 0, 3, '2024-01-11 04:14:42 PM', 8000);
INSERT INTO mouvement_stock( idmouvement, idmatiere, qteentree, qtesortie, dateheuremouvement, prixunitaire ) VALUES ( 6, 2, 0, 6, '2024-01-11 04:14:42 PM', 5000);
INSERT INTO taille( idtaille, nomtaille ) VALUES ( 1, 'PM');
INSERT INTO taille( idtaille, nomtaille ) VALUES ( 2, 'Moyen');
INSERT INTO taille( idtaille, nomtaille ) VALUES ( 3, 'GM');
INSERT INTO "type"( idtype, nomtype ) VALUES ( 1, 'sac a dos');
INSERT INTO "type"( idtype, nomtype ) VALUES ( 2, 'sac a main');
INSERT INTO unite( idunite, nomunite ) VALUES ( 1, 'm');
INSERT INTO unite( idunite, nomunite ) VALUES ( 2, 'pieces');
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 1, 1, 1);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 2, 1, 3);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 3, 2, 1);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 4, 3, 1);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 5, 3, 2);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 6, 2, 3);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 7, 4, 4);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 8, 5, 5);
INSERT INTO lookmatiere( idlookmatiere, idlook, idmatiere ) VALUES ( 9, 6, 6);
INSERT INTO modele( idmodele, idlook, idtaille, idtype, prixvente ) VALUES ( 1, 1, 1, 1, 0);
INSERT INTO modele( idmodele, idlook, idtaille, idtype, prixvente ) VALUES ( 2, 1, 2, 1, 0);
INSERT INTO modele( idmodele, idlook, idtaille, idtype, prixvente ) VALUES ( 3, 4, 2, 1, 0);
INSERT INTO modele( idmodele, idlook, idtaille, idtype, prixvente ) VALUES ( 4, 3, 3, 2, 0);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( 1, 1, 1, 1);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( 2, 2, 1, 2);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( 3, 3, 3, 4);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( 4, 1, 2, 2);
INSERT INTO formule( idformule, idmodele, idmatiere, quantite ) VALUES ( 5, 4, 4, 5);
