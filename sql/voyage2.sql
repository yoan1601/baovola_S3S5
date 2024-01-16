CREATE SCHEMA IF NOT EXISTS "public";

CREATE SEQUENCE activite_id_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE bouquet_activites_id_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE bouquet_id_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE voyage_id_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE activite ( 
	id                   serial DEFAULT nextval('activite_id_seq'::regclass) NOT NULL  ,
	designation          varchar(50)  NOT NULL  ,
	CONSTRAINT pk_activite PRIMARY KEY ( id )
 );

CREATE  TABLE bouquet ( 
	id                   serial DEFAULT nextval('bouquet_id_seq'::regclass) NOT NULL  ,
	designation          varchar(50)  NOT NULL  ,
	CONSTRAINT pk_bouquet PRIMARY KEY ( id )
 );

CREATE  TABLE bouquet_activites ( 
	id                   serial DEFAULT nextval('bouquet_activites_id_seq'::regclass) NOT NULL  ,
	bouquet              integer  NOT NULL  ,
	activite             integer  NOT NULL  ,
	CONSTRAINT pk_bouquet_activite PRIMARY KEY ( id ),
	CONSTRAINT fk_bouquet_activite_bouquet FOREIGN KEY ( bouquet ) REFERENCES bouquet( id )   ,
	CONSTRAINT fk_bouquet_activite_activite FOREIGN KEY ( activite ) REFERENCES activite( id )   
 );

CREATE  TABLE duree ( 
	id                   serial  NOT NULL  ,
	duree                integer  NOT NULL  ,
	designation          varchar(50)  NOT NULL  ,
	CONSTRAINT pk_duree PRIMARY KEY ( id )
 );

CREATE  TABLE "type" ( 
	id                   serial  NOT NULL  ,
	"type"               varchar(50)  NOT NULL  ,
	CONSTRAINT pk_tbl PRIMARY KEY ( id )
 );

CREATE  TABLE voyage ( 
	id                   serial DEFAULT nextval('voyage_id_seq'::regclass) NOT NULL  ,
	debut                date  NOT NULL  ,
	fin                  date  NOT NULL  ,
	bouquet              integer  NOT NULL  ,
	localisation         varchar(50)  NOT NULL  ,
	"type"               varchar(50)  NOT NULL  ,
	CONSTRAINT pk_voyage PRIMARY KEY ( id ),
	CONSTRAINT fk_voyage_bouquet FOREIGN KEY ( bouquet ) REFERENCES bouquet( id )   
 );

CREATE  TABLE detailsvoyage ( 
	id                   serial  NOT NULL  ,
	bouquet              integer  NOT NULL  ,
	"type"               integer  NOT NULL  ,
	activite             integer  NOT NULL  ,
	duree                integer  NOT NULL  ,
	nombre               integer  NOT NULL  ,
	CONSTRAINT pk_detailsvoyage PRIMARY KEY ( id ),
	CONSTRAINT fk_detailsvoyage_bouquet FOREIGN KEY ( bouquet ) REFERENCES bouquet( id )   ,
	CONSTRAINT fk_detailsvoyage_type FOREIGN KEY ( "type" ) REFERENCES "type"( id )   ,
	CONSTRAINT fk_detailsvoyage_activite FOREIGN KEY ( activite ) REFERENCES activite( id )   ,
	CONSTRAINT fk_detailsvoyage_duree FOREIGN KEY ( duree ) REFERENCES duree( id )   
 );


--last time
create or replace view vue_bouquet_activites as(
select bouquet.id as idBouquet,activite.id as idActivite,bouquet_activites.bouquet as designation_bouquet, bouquet_activites.activite as designation_activite from bouquet_activites 
left join bouquet on bouquet_activites.bouquet=bouquet.id 
left join activite on bouquet_activites.activite=activite.id 
);

--vaovao
create or replace view v_detailsvoyage as(
select bouquet.id as idBouquet,bouquet.designation as bouquet,activite.id as idActivite,activite.designation as activite, 
type.id as idType, type.type as type, duree.id as idDuree, duree.duree as duree, detailsvoyage.nombre as nombre from bouquet
left join detailsvoyage on  bouquet.id=detailsvoyage.bouquet
left join type on  type.id=detailsvoyage.type
left join activite on activite.id=detailsvoyage.activite
left join duree on duree.id=detailsvoyage.duree
);


--efa ao 
insert into bouquet(designation) VALUES ('firstClass');
insert into bouquet(designation) VALUES ('premium');
insert into bouquet(designation) VALUES ('basic');

INSERT INTO activite(designation ) VALUES ('picnic');
INSERT INTO activite(designation ) VALUES ('visite musee');
INSERT INTO activite(designation ) VALUES ('quad');

insert into bouquet_activites(bouquet,activite) VALUES (1,1);
insert into bouquet_activites(bouquet,activite) VALUES (2,1);
insert into bouquet_activites(bouquet,activite) VALUES (3,2);


INSERT INTO type(type ) VALUES ('national');
INSERT INTO type(type ) VALUES ('international');
INSERT INTO type(type ) VALUES ('local');

INSERT INTO duree(duree,designation ) VALUES (4,'court');
INSERT INTO duree(duree,designation ) VALUES (8,'moyen');
INSERT INTO duree(duree,designation ) VALUES (12,'long');

INSERT INTO detailsvoyage(bouquet,type,activite,duree,nombre ) VALUES (1,3,1,1,3);
INSERT INTO detailsvoyage(bouquet,type,activite,duree,nombre ) VALUES (1,3,2,1,3);
INSERT INTO detailsvoyage(bouquet,type,activite,duree,nombre ) VALUES (1,3,3,1,3);





