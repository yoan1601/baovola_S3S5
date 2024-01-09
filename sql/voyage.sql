CREATE SCHEMA IF NOT EXISTS "public";
create database voyage;
\c voyage 

CREATE  TABLE activite ( 
	id                   serial  NOT NULL  ,
	designation          varchar(50)  NOT NULL  ,
	CONSTRAINT pk_activite PRIMARY KEY ( id )
 );

CREATE  TABLE bouquet ( 
	id                   serial  NOT NULL  ,
	designation          varchar(50)  NOT NULL  ,
	CONSTRAINT pk_bouquet PRIMARY KEY ( id )
 );

CREATE  TABLE bouquet_activites ( 
	id                   serial  NOT NULL  ,
	bouquet              integer  NOT NULL  ,
	activite             integer  NOT NULL  ,
	CONSTRAINT pk_bouquet_activite PRIMARY KEY ( id ),
	CONSTRAINT fk_bouquet_activite_bouquet FOREIGN KEY ( bouquet ) REFERENCES bouquet( id )   ,
	CONSTRAINT fk_bouquet_activite_activite FOREIGN KEY ( activite ) REFERENCES activite( id )   
 );

CREATE  TABLE voyage ( 
	id                   serial  NOT NULL  ,
	debut                date  NOT NULL  ,
	fin                  date  NOT NULL  ,
	bouquet              integer  NOT NULL  ,
	localisation         varchar(50)  NOT NULL  ,
	"type"               varchar(50)  NOT NULL  ,
	CONSTRAINT pk_voyage PRIMARY KEY ( id ),
	CONSTRAINT fk_voyage_bouquet FOREIGN KEY ( bouquet ) REFERENCES bouquet( id )   
 );

create or replace view vue_bouquet_activites as(
select bouquet.id,activite.id,bouquet_activites.bouquet as designation_bouquet, bouquet_activites.activite as designation_activite from bouquet_activites 
left join bouquet on bouquet_activites.bouquet=bouquet.id 
left join activite on bouquet_activites.activite=activite.id ;
);


duree => chiffre
cours /moyen  /long [intervalle]
formule de composition de voyage 
	premium local = picnic , visite musee , quad
	court -- 2 picnic   2	1
	moyen -- 4 picnic	3	2
question???
	misafidy activite=> liste ny voyage manana anio quand io + quantite 
