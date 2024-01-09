CREATE SCHEMA IF NOT EXISTS "public";
create database poketra;
\c poketra 

CREATE  TABLE look ( 
	idlook               serial  NOT NULL  ,
	nomlook              varchar(50)  NOT NULL  ,
	CONSTRAINT pk_look PRIMARY KEY ( idlook )
 );

CREATE  TABLE matiere ( 
	idmatiere            serial  NOT NULL  ,
	nommatiere           varchar(50)  NOT NULL  ,
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

insert into lookmatiere (idlook, idmatiere) VALUES (1, 1);
insert into lookmatiere (idlook, idmatiere) VALUES (1, 3);
insert into lookmatiere (idlook, idmatiere) VALUES (2, 1);
insert into lookmatiere (idlook, idmatiere) VALUES (3, 1);
insert into lookmatiere (idlook, idmatiere) VALUES (3, 2);

create or replace view v_lookmatiere as(
select look.idlook,look.nomlook,matiere.idmatiere,matiere.nommatiere from lookmatiere 
join look on lookmatiere.idlook=look.idlook 
join matiere on matiere.idmatiere=lookmatiere.idmatiere);



save formule confection 
sacados de luxe = cuirre , tissu broder ,accesiore de deco,
	taille =  1  2	3	
	medium =  2  3	4
question ??
	listeo sac rehefa misafidy matiere za 
		sacados luxe (anakifiry) 3






