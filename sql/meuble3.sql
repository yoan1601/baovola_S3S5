create database meuble
\c meuble

CREATE SEQUENCE categorie_id_categorie_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE duree_fabrication_id_duree_fabrication_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE histo_matiere_id_histo_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matieres_id_matieres_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matieres_meuble_id_matieres_meuble_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE meuble_id_meuble_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE qte_used_matiere_id_qte_used_matiere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE style_id_style_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE style_matiere_id_style_matiere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_id_taille_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_meuble_id_taille_meuble_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE categorie ( 
	id_categorie         serial  ,
	nom_categorie        varchar(50)  NOT NULL  ,
	CONSTRAINT pk_categorie PRIMARY KEY ( id_categorie )
 );

CREATE  TABLE matieres ( 
	id_matieres          serial   ,
	nom_matiere          varchar(50)  NOT NULL  ,
	unite                varchar(15)  NOT NULL  ,
	CONSTRAINT pk_matiere PRIMARY KEY ( id_matieres )
 );

CREATE  TABLE "style" ( 
	id_style             serial   ,
	nom_style            varchar(50)  NOT NULL  ,
	description          varchar(150)    ,
	CONSTRAINT pk_tbl PRIMARY KEY ( id_style )
 );

CREATE  TABLE style_matiere ( 
	id_style_matiere     serial  ,
	id_style             integer  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_style_matiere PRIMARY KEY ( id_style_matiere ),
	CONSTRAINT fk_style_matiere_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   ,
	CONSTRAINT fk_style_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE taille ( 
	id_taille            serial  ,
	nom_taille           varchar(20)  NOT NULL  ,
	CONSTRAINT pk_taille PRIMARY KEY ( id_taille )
 );

CREATE  TABLE type_main_oeuvre ( 
	id_type_main_oeuvre  serial    ,
	nom_poste            varchar(200)  NOT NULL  ,
	CONSTRAINT pk_type_main_oeuvre PRIMARY KEY ( id_type_main_oeuvre )
 );

CREATE  TABLE duree_fabrication ( 
	id_duree_fabrication serial   ,
	id_taille            integer  NOT NULL  ,
	id_categorie         integer  NOT NULL  ,
	id_style             integer  NOT NULL  ,
	valeur_duree         numeric(10,2)  NOT NULL  ,
	CONSTRAINT pk_duree_fabrication PRIMARY KEY ( id_duree_fabrication ),
	CONSTRAINT fk_duree_fabrication_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   ,
	CONSTRAINT fk_duree_fabrication_categorie FOREIGN KEY ( id_categorie ) REFERENCES categorie( id_categorie )   ,
	CONSTRAINT fk_duree_fabrication_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   
 );

CREATE  TABLE employe ( 
	id_employe           serial  ,
	nom                  varchar(50)  NOT NULL  ,
	date_naissance       date  NOT NULL  ,
	genre                integer  NOT NULL  ,
	salaire              double precision  NOT NULL  ,
	frequence_salaire    integer  NOT NULL  ,
	id_type_main_oeuvre  integer  NOT NULL  ,
	CONSTRAINT pk_employe PRIMARY KEY ( id_employe ),
	CONSTRAINT fk_employe_type_main_oeuvre FOREIGN KEY ( id_type_main_oeuvre ) REFERENCES type_main_oeuvre( id_type_main_oeuvre )   
 );

CREATE  TABLE fabrication ( 
	id_fabrication       serial  ,
	id_taille            integer  NOT NULL  ,
	valeur_duree         double precision  NOT NULL  ,
	nb_main_oeuvre       integer  NOT NULL  ,
	CONSTRAINT pk_fabrication PRIMARY KEY ( id_fabrication ),
	CONSTRAINT fk_fabrication_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   
 );

CREATE  TABLE histo_matiere ( 
	id_histo             serial  ,
	id_matieres          integer  NOT NULL  ,
	prix_unitaire        numeric(10,2)  NOT NULL  ,
	quantite             integer  NOT NULL  ,
	date_entree          date  NOT NULL  ,
	unite                varchar(15)  NOT NULL  ,
	CONSTRAINT pk_histo_matiere PRIMARY KEY ( id_histo ),
	CONSTRAINT fk_histo_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE meuble ( 
	id_meuble            serial  ,
	nom_meuble           varchar(50)  NOT NULL  ,
	id_categorie         integer  NOT NULL  ,
	id_style             integer  NOT NULL  ,
	date_creation        date  NOT NULL  ,
	description          varchar(150)  NOT NULL  ,
	CONSTRAINT pk_meuble PRIMARY KEY ( id_meuble ),
	CONSTRAINT fk_meuble_categorie FOREIGN KEY ( id_categorie ) REFERENCES categorie( id_categorie )   ,
	CONSTRAINT fk_meuble_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   
 );

CREATE  TABLE qte_used_matiere ( 
	id_qte_used_matiere  serial   ,
	id_taille            integer  NOT NULL  ,
	id_categorie         integer  NOT NULL  ,
	id_style             integer  NOT NULL  ,
	valeur_qte           numeric(10,2)  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_qte_used_matiere PRIMARY KEY ( id_qte_used_matiere ),
	CONSTRAINT fk_qte_used_matiere_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   ,
	CONSTRAINT fk_qte_used_matiere_categorie FOREIGN KEY ( id_categorie ) REFERENCES categorie( id_categorie )   ,
	CONSTRAINT fk_qte_used_matiere_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   ,
	CONSTRAINT fk_qte_used_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE regle_nbemploye_taille ( 
	id_regle_nbemploye_taille serial   ,
	id_taille            integer  NOT NULL  ,
	nb_croissant         double precision  NOT NULL  ,
	nb_decroissant       double precision  NOT NULL  ,
	CONSTRAINT pk_regle_nbemploye_taille PRIMARY KEY ( id_regle_nbemploye_taille ),
	CONSTRAINT fk_regle_nbemploye_taille_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   
 );

CREATE  TABLE taille_meuble ( 
	id_taille_meuble     serial   ,
	id_taille            integer  NOT NULL  ,
	prix                 numeric(10,2)  NOT NULL  ,
	id_meuble            integer  NOT NULL  ,
	CONSTRAINT pk_taille_meuble PRIMARY KEY ( id_taille_meuble ),
	CONSTRAINT fk_taille_meuble_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   ,
	CONSTRAINT fk_taille_meuble_meuble FOREIGN KEY ( id_meuble ) REFERENCES meuble( id_meuble )   
 );

CREATE  TABLE employe_fabrication ( 
	id_employe_fabrication serial    ,
	id_fabrication       integer  NOT NULL  ,
	id_employe           integer  NOT NULL  ,
	duree                double precision  NOT NULL  ,
	CONSTRAINT pk_employe_fabrication PRIMARY KEY ( id_employe_fabrication ),
	CONSTRAINT fk_employe_fabrication_fabrication FOREIGN KEY ( id_fabrication ) REFERENCES fabrication( id_fabrication )   ,
	CONSTRAINT fk_employe_fabrication_employe FOREIGN KEY ( id_employe ) REFERENCES employe( id_employe )   
 );

CREATE  TABLE matieres_meuble ( 
	id_matieres_meuble   serial   ,
	id_meuble            integer  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_matieres_meuble PRIMARY KEY ( id_matieres_meuble ),
	CONSTRAINT fk_matieres_meuble_meuble FOREIGN KEY ( id_meuble ) REFERENCES meuble( id_meuble )   ,
	CONSTRAINT fk_matieres_meuble_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE OR REPLACE VIEW v_ AS SELECT meu.id_meuble, meu.nom_meuble, meu.id_categorie, meu.id_style, meu.date_creation, cat.nom_categorie, v_mm.id_matieres, v_mm.nom_matiere, v_mm.unite AS unite_matiere, v_sm.nom_style, v_tm.id_taille, v_tm.nom_taille FROM ((((meuble meu JOIN categorie cat ON ((meu.id_categorie = cat.id_categorie))) JOIN v_matieres_meuble v_mm ON ((meu.id_meuble = v_mm.id_meuble))) JOIN v_style_matiere v_sm ON ((v_mm.id_matieres = v_sm.id_matieres))) JOIN v_taille_meuble v_tm ON ((meu.id_meuble = v_tm.id_meuble)))
 SELECT meu.id_meuble,
    meu.nom_meuble,
    meu.id_categorie,
    meu.id_style,
    meu.date_creation,
    cat.nom_categorie,
    v_mm.id_matieres,
    v_mm.nom_matiere,
    v_mm.unite AS unite_matiere,
    v_sm.nom_style,
    v_tm.id_taille,
    v_tm.nom_taille
   FROM ((((meuble meu
     JOIN categorie cat ON ((meu.id_categorie = cat.id_categorie)))
     JOIN v_matieres_meuble v_mm ON ((meu.id_meuble = v_mm.id_meuble)))
     JOIN v_style_matiere v_sm ON ((v_mm.id_matieres = v_sm.id_matieres)))
     JOIN v_taille_meuble v_tm ON ((meu.id_meuble = v_tm.id_meuble)));

CREATE OR REPLACE VIEW v_matieres_meuble AS SELECT me.id_meuble, me.nom_meuble, me.id_categorie, me.id_style, me.date_creation, ma.id_matieres, ma.nom_matiere, ma.unite, mm.id_matieres_meuble FROM ((meuble me JOIN matieres_meuble mm ON ((me.id_meuble = mm.id_meuble))) JOIN matieres ma ON ((ma.id_matieres = mm.id_matieres)))
 SELECT me.id_meuble,
    me.nom_meuble,
    me.id_categorie,
    me.id_style,
    me.date_creation,
    ma.id_matieres,
    ma.nom_matiere,
    ma.unite,
    mm.id_matieres_meuble
   FROM ((meuble me
     JOIN matieres_meuble mm ON ((me.id_meuble = mm.id_meuble)))
     JOIN matieres ma ON ((ma.id_matieres = mm.id_matieres)));

CREATE OR REPLACE VIEW v_meuble_entre_prix AS SELECT v_mp.id_meuble, v_mp.nom_meuble, sum(hm.prix_unitaire) AS montant FROM (v_meuble_prix v_mp JOIN histo_matiere hm ON ((v_mp.id_matieres = hm.id_matieres))) GROUP BY v_mp.id_meuble, v_mp.nom_meuble
 SELECT v_mp.id_meuble,
    v_mp.nom_meuble,
    sum(hm.prix_unitaire) AS montant
   FROM (v_meuble_prix v_mp
     JOIN histo_matiere hm ON ((v_mp.id_matieres = hm.id_matieres)))
  GROUP BY v_mp.id_meuble, v_mp.nom_meuble;

CREATE OR REPLACE VIEW v_meuble_prix AS SELECT vmm.id_meuble, vmm.nom_meuble, vmm.id_categorie, vmm.id_style, vmm.date_creation, vmm.id_matieres, vmm.nom_matiere, vmm.unite, vmm.id_matieres_meuble FROM (v_matieres_meuble vmm JOIN histo_matiere hm ON ((vmm.id_matieres = hm.id_matieres)))
 SELECT vmm.id_meuble,
    vmm.nom_meuble,
    vmm.id_categorie,
    vmm.id_style,
    vmm.date_creation,
    vmm.id_matieres,
    vmm.nom_matiere,
    vmm.unite,
    vmm.id_matieres_meuble
   FROM (v_matieres_meuble vmm
     JOIN histo_matiere hm ON ((vmm.id_matieres = hm.id_matieres)));

CREATE OR REPLACE VIEW v_style_matiere AS SELECT s_m.id_style, m.id_matieres, s.nom_style, s.description, m.nom_matiere FROM ((style s JOIN style_matiere s_m ON ((s.id_style = s_m.id_style))) JOIN matieres m ON ((m.id_matieres = s_m.id_matieres)))
 SELECT s_m.id_style,
    m.id_matieres,
    s.nom_style,
    s.description,
    m.nom_matiere
   FROM ((style s
     JOIN style_matiere s_m ON ((s.id_style = s_m.id_style)))
     JOIN matieres m ON ((m.id_matieres = s_m.id_matieres)));

CREATE OR REPLACE VIEW v_taille_meuble AS SELECT m.id_meuble, m.nom_meuble, m.id_categorie, m.id_style, m.date_creation, t.id_taille, t.nom_taille, tm.id_taille_meuble, tm.prix FROM ((meuble m JOIN taille_meuble tm ON ((m.id_meuble = tm.id_taille))) JOIN taille t ON ((t.id_taille = tm.id_taille)))
 SELECT m.id_meuble,
    m.nom_meuble,
    m.id_categorie,
    m.id_style,
    m.date_creation,
    t.id_taille,
    t.nom_taille,
    tm.id_taille_meuble,
    tm.prix
   FROM ((meuble m
     JOIN taille_meuble tm ON ((m.id_meuble = tm.id_taille)))
     JOIN taille t ON ((t.id_taille = tm.id_taille)));

INSERT INTO matieres( id_matieres, nom_matiere, unite ) VALUES ( 1, 'laine', 'cm');
INSERT INTO matieres( id_matieres, nom_matiere, unite ) VALUES ( 2, 'bois', 'metre');
INSERT INTO matieres( id_matieres, nom_matiere, unite ) VALUES ( 3, 'cuire', 'metre');
INSERT INTO "style"( id_style, nom_style, description ) VALUES ( 1, 'standard', null);
INSERT INTO "style"( id_style, nom_style, description ) VALUES ( 2, 'royale', null);
INSERT INTO "style"( id_style, nom_style, description ) VALUES ( 3, 'basique', null);
INSERT INTO style_matiere( id_style_matiere, id_style, id_matieres ) VALUES ( 1, 1, 1);
INSERT INTO style_matiere( id_style_matiere, id_style, id_matieres ) VALUES ( 3, 3, 2);
INSERT INTO style_matiere( id_style_matiere, id_style, id_matieres ) VALUES ( 4, 2, 3);
