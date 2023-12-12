CREATE SCHEMA IF NOT EXISTS "public";
create database poketra;

CREATE  TABLE look ( 
	idlook               serial  NOT NULL  ,
	nomlook              varchar(50)    ,
	CONSTRAINT pk_look PRIMARY KEY ( idlook )
 );

CREATE  TABLE matiere ( 
	idmatiere            serial  NOT NULL  ,
	nommatiere           varchar(50)    ,
	CONSTRAINT pk_matiere PRIMARY KEY ( idmatiere )
 );

CREATE  TABLE lookmatiere ( 
	idlookmatiere        serial  NOT NULL  ,
	idlook               integer  NOT NULL  ,
	idmatiere            integer  NOT NULL  ,
	CONSTRAINT pk_lookmatiere PRIMARY KEY ( idlookmatiere ),
	CONSTRAINT fk_lookmatiere_look FOREIGN KEY ( idlook ) REFERENCES look( idlook )   ,
	CONSTRAINT fk_lookmatiere_matiere FOREIGN KEY ( idmatiere ) REFERENCES matiere( idmatiere )   
 );


insert into look (nomlook) VALUES ('luxe');
insert into look (nomlook) VALUES ('normal');
insert into look (nomlook) VALUES ('debraille');

insert into matiere (nommatiere) VALUES ('cuire');
insert into matiere (nommatiere) VALUES ('soga');
insert into matiere (nommatiere) VALUES ('raphia');

create or replace view v_lookmatiere as(
select look.idlook,look.nomlook,matiere.idmatiere,matiere.nommatiere from lookmatiere 
join look on lookmatiere.idlook=look.idlook 
join matiere on matiere.idmatiere=lookmatiere.idmatiere);






