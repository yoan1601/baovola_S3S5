CREATE SCHEMA IF NOT EXISTS "public";

create database poketra;
\c poketra

CREATE SEQUENCE look_idlook_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE lookmatiere_idlookmatiere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE matiere_idmatiere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE look ( 
	idlook               serial DEFAULT nextval('look_idlook_seq'::regclass) NOT NULL  ,
	nomlook              varchar(50)  NOT NULL  ,
	CONSTRAINT pk_look PRIMARY KEY ( idlook )
 );

CREATE  TABLE unite ( 
	idunite              serial  NOT NULL  ,
	nomunite             varchar(10)  NOT NULL  ,
	CONSTRAINT pk_unite PRIMARY KEY ( idunite )
);

CREATE  TABLE matiere ( 
	idmatiere            serial DEFAULT nextval('matiere_idmatiere_seq'::regclass) NOT NULL  ,
	nommatiere           varchar(50)  NOT NULL  ,
	idunite              integer DEFAULT 1 NOT NULL  ,
	CONSTRAINT pk_matiere PRIMARY KEY ( idmatiere ),
	CONSTRAINT fk_matiere_unite FOREIGN KEY ( idunite ) REFERENCES unite( idunite )   
 );

CREATE  TABLE taille ( 
	idtaille             serial  NOT NULL  ,
	nomtaille            varchar(50)  NOT NULL  ,
	CONSTRAINT pk_taille PRIMARY KEY ( idtaille )
 );

CREATE  TABLE "type" ( 
	idtype               serial  NOT NULL  ,
	nomtype              varchar(50)  NOT NULL  ,
	CONSTRAINT pk_tbl PRIMARY KEY ( idtype )
 );


CREATE  TABLE lookmatiere ( 
	idlookmatiere        serial DEFAULT nextval('lookmatiere_idlookmatiere_seq'::regclass) NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	CONSTRAINT pk_lookmatiere PRIMARY KEY ( idlookmatiere ),
	CONSTRAINT fk_lookmatiere_look FOREIGN KEY ( idlook ) REFERENCES look( idlook )   ,
	CONSTRAINT fk_lookmatiere_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   
 );

CREATE  TABLE modele ( 
	idmodele             serial  NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idtaille             integer  NOT NULL  ,
	idtype               integer  NOT NULL  ,
	CONSTRAINT pk_modele PRIMARY KEY ( idmodele ),
	CONSTRAINT fk_modele_look FOREIGN KEY ( idlook ) REFERENCES look( idlook )   ,
	CONSTRAINT fk_modele_taille FOREIGN KEY ( idtaille ) REFERENCES taille( idtaille )   ,
	CONSTRAINT fk_modele_type FOREIGN KEY ( idtype ) REFERENCES "type"( idtype )   
 );

CREATE  TABLE formule ( 
	idformule            serial  NOT NULL  ,
	idmodele             integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	quantite             integer  NOT NULL  ,
	CONSTRAINT pk_formule PRIMARY KEY ( idformule ),
	CONSTRAINT fk_formule_modele FOREIGN KEY ( idmodele ) REFERENCES modele( idmodele )   ,
	CONSTRAINT fk_formule_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   
 );

--vue 

CREATE OR REPLACE VIEW v_lookmatiere AS SELECT look.idlook, look.nomlook, matiere.idmatiere, matiere.nommatiere FROM ((lookmatiere JOIN look ON ((lookmatiere.idlook = look.idlook))) JOIN matiere ON ((matiere.idmatiere = lookmatiere.idmatiere)))
 SELECT look.idlook,
    look.nomlook,
    matiere.idmatiere,
    matiere.nommatiere
   FROM ((lookmatiere
     JOIN look ON ((lookmatiere.idlook = look.idlook)))
     JOIN matiere ON ((matiere.idmatiere = lookmatiere.idmatiere)));


create or replace view v_modele as (
select modele.idmodele as idmodele, modele.idlook as idlook,look.nomlook as nomlook,modele.idtaille as idtaille, taille.nomtaille as nomtaille, modele.idtype as idtype, type.nomtype as nomtype  from modele 
join look on look.idlook=modele.idlook
join taille on taille.idtaille=modele.idtaille
join type on type.idtype=modele.idtype);


create or replace view v_formule as (
select v_modele.idmodele, v_modele.idlook,v_modele.nomlook,v_modele.idtaille,v_modele.nomtaille,v_modele.idtype,v_modele.nomtype,formule.idmatiere as idmatiere,matiere.nommatiere as nommatiere from v_modele
join formule on v_modele.idmodele=formule.idmodele
join matiere on formule.idmatiere=matiere.idmatiere
);


---data
insert into look (nomlook) VALUES ('luxe');
insert into look (nomlook) VALUES ('normal');
insert into look (nomlook) VALUES ('debraille');

insert into unite(nomunite) VALUES ('m');

insert into matiere (nommatiere,idunite) VALUES ('cuire',1);
insert into matiere (nommatiere,idunite) VALUES ('soga',1);
insert into matiere (nommatiere,idunite) VALUES ('raphia',1);


insert into taille (nomtaille) VALUES ('PM');
insert into taille (nomtaille) VALUES ('Moyen');

insert into type (nomtype) VALUES ('sac a dos');

insert into modele (idlook,idtaille,idtype) VALUES (1,1,1);
insert into modele (idlook,idtaille,idtype) VALUES (1,2,1);

insert into formule(idmodele,idmatiere,quantite) VALUES(1,1,1);
insert into formule(idmodele,idmatiere,quantite) VALUES(2,1,2);



