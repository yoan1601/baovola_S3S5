CREATE SCHEMA IF NOT EXISTS "public";

CREATE SEQUENCE mpianatra_idmpianatra_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE olona_idolona_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE  TABLE historique ( 
	cin                  varchar(50)    ,
	datydebut            date    ,
	datyfin              date    ,
	raison               varchar(50)    ,
	lieu                 varchar(50)    
 );

CREATE  TABLE login ( 
	cin                  varchar(50)    ,
	mdp                  varchar(50)    ,
	roles                varchar(50)    
 );

CREATE  TABLE olona ( 
	idolona              serial DEFAULT nextval('olona_idolona_seq'::regclass) NOT NULL  ,
	anarana              varchar(50)  NOT NULL  ,
	vola                 numeric(10,2) DEFAULT 0   ,
	CONSTRAINT pk_olona PRIMARY KEY ( idolona )
 );

CREATE  TABLE omby ( 
	idomby               varchar(25)    ,
	cintompony           varchar(50)    ,
	couleur              varchar(50)    ,
	poid                 numeric(20,3)    ,
	statuss              varchar(25)    ,
	sary                 varchar(100)    
 );

CREATE  TABLE ombyhita ( 
	idomby               varchar(25)    ,
	cintompony           varchar(50)    ,
	datyh                date    
 );

CREATE  TABLE ombyvery ( 
	idomby               varchar(25)    ,
	cintompony           varchar(50)    ,
	datyv                date    
 );

CREATE  TABLE pathologie ( 
	cin                  varchar(50)    ,
	nompath              varchar(50)    
 );

CREATE  TABLE personne ( 
	nom                  varchar(50)    ,
	cin                  varchar(50)  NOT NULL  ,
	daten                date    ,
	sexe                 varchar(1)    ,
	addresse             varchar(20)    ,
	situation            varchar(10)    ,
	cinmaman             varchar(50)    ,
	cinpapa              varchar(50)    ,
	gs                   varchar(10)    ,
	isdonneur            varchar(3)    ,
	CONSTRAINT personne_pkey PRIMARY KEY ( cin )
 );

CREATE  TABLE test ( 
	id_test              integer    ,
	name                 varchar(10)    
 );

CREATE  TABLE varotraomby ( 
	idomby               varchar(25)    ,
	cintompony           varchar(50)    ,
	cinividy             varchar(50)    ,
	prix                 numeric(20,3)    ,
	daty                 date    
 );

CREATE  TABLE mpianatra ( 
	idmpianatra          serial DEFAULT nextval('mpianatra_idmpianatra_seq'::regclass) NOT NULL  ,
	age                  integer  NOT NULL  ,
	idolona              integer  NOT NULL  ,
	CONSTRAINT pk_mpianatra PRIMARY KEY ( idmpianatra )
 );

ALTER TABLE mpianatra ADD CONSTRAINT fk_mpianatra_olona FOREIGN KEY ( idolona ) REFERENCES olona( idolona );
