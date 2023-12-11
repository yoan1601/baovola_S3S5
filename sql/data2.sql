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