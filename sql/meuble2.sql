CREATE SCHEMA IF NOT EXISTS "public";

CREATE SEQUENCE categorie_id_categorie_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE duree_fabrication_id_duree_fabrication_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE histo_matiere_id_histo_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matieres_id_matieres_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE meuble_id_meuble_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE style_id_style_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE style_matiere_id_style_matiere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_id_taille_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE taille_meuble_id_taille_meuble_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE categorie ( 
	id_categorie         serial DEFAULT nextval('categorie_id_categorie_seq'::regclass) NOT NULL  ,
	nom_categorie        varchar(50)  NOT NULL  ,
	CONSTRAINT pk_categorie PRIMARY KEY ( id_categorie )
 );

CREATE  TABLE matieres ( 
	id_matieres          serial DEFAULT nextval('matieres_id_matieres_seq'::regclass) NOT NULL  ,
	nom_matiere          varchar(50)  NOT NULL  ,
	unite                varchar(15)  NOT NULL  ,
	CONSTRAINT pk_matiere PRIMARY KEY ( id_matieres )
 );

CREATE  TABLE "style" ( 
	id_style             serial DEFAULT nextval('style_id_style_seq'::regclass) NOT NULL  ,
	nom_style            varchar(50)  NOT NULL  ,
	description          varchar(150)    ,
	CONSTRAINT pk_tbl PRIMARY KEY ( id_style )
 );

CREATE  TABLE style_matiere ( 
	id_style_matiere     serial DEFAULT nextval('style_matiere_id_style_matiere_seq'::regclass) NOT NULL  ,
	id_style             integer  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_style_matiere PRIMARY KEY ( id_style_matiere ),
	CONSTRAINT fk_style_matiere_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   ,
	CONSTRAINT fk_style_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE taille ( 
	id_taille            serial DEFAULT nextval('taille_id_taille_seq'::regclass) NOT NULL  ,
	nom_taille           varchar(20)  NOT NULL  ,
	CONSTRAINT pk_taille PRIMARY KEY ( id_taille )
 );

CREATE  TABLE duree_fabrication ( 
	id_duree_fabrication serial DEFAULT nextval('duree_fabrication_id_duree_fabrication_seq'::regclass) NOT NULL  ,
	id_taille            integer  NOT NULL  ,
	id_categorie         integer  NOT NULL  ,
	id_style             integer  NOT NULL  ,
	valeur_duree         numeric(10,2)  NOT NULL  ,
	CONSTRAINT pk_duree_fabrication PRIMARY KEY ( id_duree_fabrication ),
	CONSTRAINT fk_duree_fabrication_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   ,
	CONSTRAINT fk_duree_fabrication_categorie FOREIGN KEY ( id_categorie ) REFERENCES categorie( id_categorie )   ,
	CONSTRAINT fk_duree_fabrication_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   
 );

CREATE  TABLE histo_matiere ( 
	id_histo             serial DEFAULT nextval('histo_matiere_id_histo_seq'::regclass) NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	prix_unitaire        numeric(10,2)  NOT NULL  ,
	quantite             integer  NOT NULL  ,
	date_entree          date  NOT NULL  ,
	unite                varchar(15)  NOT NULL  ,
	CONSTRAINT pk_histo_matiere PRIMARY KEY ( id_histo ),
	CONSTRAINT fk_histo_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE meuble ( 
	id_meuble            serial DEFAULT nextval('meuble_id_meuble_seq'::regclass) NOT NULL  ,
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
	id_qte_used_matiere  serial  NOT NULL  ,
	id_taille            integer  NOT NULL  ,
	id_categorie         integer  NOT NULL  ,
	id_style             integer  NOT NULL  ,
	valeur_qte           decimal(10,2)  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_qte_used_matiere PRIMARY KEY ( id_qte_used_matiere ),
	CONSTRAINT fk_qte_used_matiere_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   ,
	CONSTRAINT fk_qte_used_matiere_categorie FOREIGN KEY ( id_categorie ) REFERENCES categorie( id_categorie )   ,
	CONSTRAINT fk_qte_used_matiere_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   ,
	CONSTRAINT fk_qte_used_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE taille_meuble ( 
	id_taille_meuble     serial DEFAULT nextval('taille_meuble_id_taille_meuble_seq'::regclass) NOT NULL  ,
	id_taille            integer  NOT NULL  ,
	prix                 numeric(10,2)  NOT NULL  ,
	id_meuble            integer  NOT NULL  ,
	CONSTRAINT pk_taille_meuble PRIMARY KEY ( id_taille_meuble ),
	CONSTRAINT fk_taille_meuble_taille FOREIGN KEY ( id_taille ) REFERENCES taille( id_taille )   ,
	CONSTRAINT fk_taille_meuble_meuble FOREIGN KEY ( id_meuble ) REFERENCES meuble( id_meuble )   
 );

CREATE  TABLE matieres_meuble ( 
	id_matieres_meuble   serial  NOT NULL  ,
	id_meuble            integer  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_matieres_meuble PRIMARY KEY ( id_matieres_meuble ),
	CONSTRAINT fk_matieres_meuble_meuble FOREIGN KEY ( id_meuble ) REFERENCES meuble( id_meuble )   ,
	CONSTRAINT fk_matieres_meuble_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

--vues
CREATE OR REPLACE VIEW v_style_matiere AS SELECT s_m.id_style, m.id_matieres, s.nom_style, s.description, m.nom_matiere FROM ((style s JOIN style_matiere s_m ON ((s.id_style = s_m.id_style))) JOIN matieres m ON ((m.id_matieres = s_m.id_matieres)))
 SELECT s_m.id_style,
    m.id_matieres,
    s.nom_style,
    s.description,z
    m.nom_matiere
   FROM ((style s
     JOIN style_matiere s_m ON ((s.id_style = s_m.id_style)))
     JOIN matieres m ON ((m.id_matieres = s_m.id_matieres)));

create or replace view v_taille_meuble as(
select m.id_meuble as id_meuble,m.nom_meuble as nom_meuble,m.id_categorie as id_categorie,m.id_style as id_style,m.date_creation as date_creation,
t.id_taille as id_taille,t.nom_taille as nom_taille,
tm.id_taille_meuble as id_taille_meuble,tm.prix as prix
from meuble as m
join taille_meuble as tm on m.id_meuble=tm.id_taille
join taille as t on t.id_taille=tm.id_taille
);

create or replace view v_matieres_meuble as(
select me.id_meuble as id_meuble,me.nom_meuble as nom_meuble,me.id_categorie as id_categorie,me.id_style as id_style,me.date_creation as date_creation,
ma.id_matieres as id_matieres, ma.nom_matiere as nom_matiere, ma.unite as unite,
mm.id_matieres_meuble as id_matieres_meuble
from meuble as me
join matieres_meuble as mm on me.id_meuble=mm.id_meuble
join matieres as ma on ma.id_matieres=mm.id_matieres
);

create or replace view v_ as(
select meu.id_meuble as id_meuble,meu.nom_meuble as nom_meuble,meu.id_categorie as id_categorie,meu.id_style as id_style,meu.date_creation as date_creation,
cat.nom_categorie as nom_categorie,
v_mm.id_matieres as id_matieres,v_mm.nom_matiere as nom_matiere,v_mm.unite as unite_matiere,
v_sm.nom_style as nom_style, v_tm.id_taille as id_taille,v_tm.nom_taille as nom_taille
from meuble as meu
join categorie as cat on meu.id_categorie=cat.id_categorie
join v_matieres_meuble as v_mm on meu.id_meuble=v_mm.id_meuble
join v_style_matiere as v_sm on v_mm.id_matieres=v_sm.id_matieres
join v_taille_meuble as v_tm on meu.id_meuble=v_tm.id_meuble
);

create or replace view v_meuble_prix as(
select id_meuble,nom_meuble,id_categorie,id_style,date_creation,vmm.id_matieres,vmm.nom_matiere,vmm.unite,id_matieres_meuble
from v_matieres_meuble as vmm 
join histo_matiere as hm on vmm.id_matieres=hm.id_matieres
);


CREATE OR REPLACE VIEW v_meuble_entre_prix AS(
SELECT v_mp.id_meuble, v_mp.nom_meuble, SUM(hm.prix_unitaire) AS montant
FROM v_meuble_prix AS v_mp
JOIN histo_matiere AS hm ON v_mp.id_matieres = hm.id_matieres
GROUP BY v_mp.id_meuble, v_mp.nom_meuble
);



