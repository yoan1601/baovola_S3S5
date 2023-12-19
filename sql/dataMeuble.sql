insert into matieres (nom_matiere,unite)values('laine','cm');
insert into matieres (nom_matiere,unite)values('bois','metre');
insert into matieres (nom_matiere,unite)values('cuire','metre');


insert into style (nom_style)values('standard');
insert into style (nom_style)values('royale');
insert into style (nom_style)values('basique');

insert into style_matiere (id_style,id_matieres) values (1,1);
insert into style_matiere (id_style,id_matieres) values (2,3);
insert into style_matiere (id_style,id_matieres) values (3,2);