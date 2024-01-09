CREATE SCHEMA IF NOT EXISTS "public";
create database meuble;
\c meuble 

CREATE  TABLE matieres ( 
	id_matieres          serial  NOT NULL  ,
	nom_matiere          varchar(50)  NOT NULL  ,
	unite                varchar(15)  NOT NULL  ,
	CONSTRAINT pk_matiere PRIMARY KEY ( id_matieres )
 );

CREATE  TABLE "style" ( 
	id_style             serial  NOT NULL  ,
	nom_style            varchar(50)  NOT NULL  ,
	description          varchar(150)    ,
	CONSTRAINT pk_tbl PRIMARY KEY ( id_style )
 );

CREATE  TABLE style_matiere ( 
	id_style_matiere     serial  NOT NULL  ,
	id_style             integer  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	CONSTRAINT pk_style_matiere PRIMARY KEY ( id_style_matiere ),
	CONSTRAINT fk_style_matiere_style FOREIGN KEY ( id_style ) REFERENCES "style"( id_style )   ,
	CONSTRAINT fk_style_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

CREATE  TABLE histo_matiere ( 
	id_histo             serial  NOT NULL  ,
	id_matieres          integer  NOT NULL  ,
	prix_unitaire        numeric(10,2)  NOT NULL  ,
	quantite             integer  NOT NULL  ,
	date_entree          date  NOT NULL  ,
	unite                varchar(15)  NOT NULL  ,
	CONSTRAINT pk_histo_matiere PRIMARY KEY ( id_histo ),
	CONSTRAINT fk_histo_matiere_matieres FOREIGN KEY ( id_matieres ) REFERENCES matieres( id_matieres )   
 );

create or replace view v_style_matiere as
(select s_m.id_style,m.id_matieres,s.nom_style,s.description,m.nom_matiere
from style as s 
join style_matiere as s_m
on s.id_style=s_m.id_style
join matieres as m on m.id_matieres=s_m.id_matieres);

formule fabrication meuble 
	canape b.= tissu,perle,chaine
	petit 2 10 3
	lehibe 	4 20 5
question??
	misafidy tissu(liste)==> canape b. 4

