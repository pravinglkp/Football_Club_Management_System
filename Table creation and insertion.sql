--REVIEW 2-DBMS -SQL


-- CREATING TABLE


create table users(
	user_id			varchar(5)		constraint usr_pk primary key,
	password		varchar(16)	constraint usr_nn not null,
	name 			char(20) constraint usr_nn2 not null,
	dob				date,
	status			char(10),
	nationality		char(20)
);

insert into users values('U#23','password1','Joe Gomez',TO_DATE('23/05/1997', 'DD/MM/YYYY'),'Active','England');
insert into users values('U#07','password2','Mohamed Salah',TO_DATE('15/06/1992', 'DD/MM/YYYY'),'Active','Egypt');
insert into users values('U#99','password3','David Silva',TO_DATE('08/01/1986', 'DD/MM/YYYY'),'Active','Spain');
insert into users values('U#34','password4','Sergio Aguero',TO_DATE('02/06/1988', 'DD/MM/YYYY'),'Active','Argentina');
insert into users values('U#86','password5','Toni Kroos',TO_DATE('04/01/1990', 'DD/MM/YYYY'),'Active','German');
insert into users values('U#49','password6','Raphhael Varane',TO_DATE('25/04/1993', 'DD/MM/YYYY'),'Active','French');
insert into users values('U#27','password7','Ivo Grbic',TO_DATE('18/01/1996', 'DD/MM/YYYY'),'Active','Croatian');
insert into users values('U#64','password8','Jose Grimenez',TO_DATE('20/01/1995', 'DD/MM/YYYY'),'Active','Uruguayan');
insert into users values('U#14','password9','Diego Godin',TO_DATE('16/02/1986', 'DD/MM/YYYY'),'Active','Uruguayan');
insert into users values('U#04','password10','Alexis Sanchez',TO_DATE('19/12/1988', 'DD/MM/YYYY'),'Active','Chilean');
insert into users values('U#38','password11','Antonio Conte',TO_DATE('31/07/1969', 'DD/MM/YYYY'),'Active','Italian');
insert into users values('U#91','password12','Diego Simeone',TO_DATE('28/04/1970', 'DD/MM/YYYY'),'Active','Argentine');
insert into users values('U#11','password13','Zinedine Zidane',TO_DATE('23/06/1972', 'DD/MM/YYYY'),'Active','Algerian');
insert into users values('U#41','password14','Pep Guardiola',TO_DATE('18/01/1971', 'DD/MM/YYYY'),'Active','Spanish');
insert into users values('U#77','password15','Jurgen Klopp',TO_DATE('16/06/1967', 'DD/MM/YYYY'),'Active','German');

select * from users;


create table managers(
	mgr_id				varchar(5) constraint mgr_pk primary key,
	experience      		number(2),
	no_of_matches_managed	number(4),
    user_id  constraint mgr_fk references users	
);

insert into managers values ('JK11M',11,186,'U#77');
insert into managers values ('AC23M',5,76,'U#38');
insert into managers values ('DS56M',13,213,'U#91');
insert into managers values ('ZZ01M',2,66,'U#11');
insert into managers values ('PG15M',4,155,'U#41');	

select * from managers;


create table clubs(
	club_id				varchar(5) constraint clb_pk	primary key,
	club_name			char(20) constraint clb_nn not null,
	goals				number(4),
	trophies			number(3),
	mgr_id				constraint clb_fk references managers
);	

insert into clubs values ('IM#24','Inter Milan',284,30,'AC23M');
insert into clubs values ('AM#07','Atletico Madrid',320,24,'DS56M');
insert into clubs values ('RM#46','Real Madrid',368,46,'ZZ01M');
insert into clubs values ('MC#13','Man City',232,28,'PG15M');
insert into clubs values ('LV#72','Liverpool',297,29,'JK11M');


select * from clubs;

create table points_table(
	club_id		constraint pot_tab_fk references clubs,
	total_matches_played	number(4),
	win						number(4),
	lose					number(4),
	draw					number(4),
	points					number(4),
	primary key(club_id)
);

insert into points_table values ('IM#24',1289,648,418,223,2167);
insert into points_table values ('LV#72',1081,564,251,266,1958);
insert into points_table values ('AM#07',547,296,135,116,1004);
insert into points_table values ('RM#46',596,362,120,114,1200);
insert into points_table values ('MC#13',620,312,180,128,1988);

select * from points_table;

create table players(
	player_id		varchar(5) constraint plar_pk primary key,
	sale			varchar(8) constraint plar_nn not null,
	bid_amount		varchar(8),
	position		varchar(10),
    user_id                 constraint plar_fk references users,
	club_id                 constraint plar_fk2 references clubs
);


insert into players values ('P#23','€105 M','€125 M','FC','U#23','LV#72');
insert into players values ('P#04','€245 M','€260 M','RW','U#07','LV#72');
insert into players values ('P#97','€130 M','€145 M','AM','U#99','MC#13');
insert into players values ('P#56','€110 M','€130 M','S','U#34','MC#13');
insert into players values ('P#73','€220 M','€235 M','CM','U#86','RM#46');
insert into players values ('P#24','€167 M','€180 M','CB','U#49','RM#46');
insert into players values ('P#15','€160 M','€175 M','GK','U#27','AM#07');
insert into players values ('P#09','€133 M','€140 M','DF','U#64','AM#07');
insert into players values ('P#70','€205 M','€210 M','CB','U#14','IM#24');
insert into players values ('P#32','€170 M','€195 M','ST','U#04','IM#24');

select * from players;

create table skills(
	player_id	   constraint skills_fk references players,
	rating         number(5),
	skill_star	   char(20),
	weak_foot	   char(20)
);


insert into skills values ('P#23',8,'Cruyff Turn','Left');
insert into skills values ('P#04',9,'Gaucho Snake','Right');
insert into skills values ('P#97',7,'Puskas Pullback','Right');
insert into skills values ('P#56',8,'Shotpower','Left');
insert into skills values ('P#73',9,'Boxtobox','Left');
insert into skills values ('P#24',8,'Scissor Kick','Left');
insert into skills values ('P#15',7,'Jumping Reach','Left');
insert into skills values ('P#09',7,'Step-over','Right');
insert into skills values ('P#70',8,'Seal Dribble','Right');
insert into skills values ('P#32',9,'Jay-Jay Okocha','Right');

select * from skills;

create table bid(
	player_id		constraint bid_pkfk references players,
	amount			varchar(8),
    primary key(player_id)
);



insert into bid values('P#23','€135 M');
insert into bid values('P#56','€145 M');
insert into bid values('P#24','€190 M');
insert into bid values('P#09','€155 M');
insert into bid values('P#32','€200 M');


select * from bid;

create table bid_by(
	player_id			constraint bid_by_fk references players unique,
	mgr_id			constraint bid_by_fk2 references managers
);

insert into bid_by values ('P#24','JK11M');
insert into bid_by values ('P#23','PG15M');
insert into bid_by values ('P#32','DS56M');
insert into bid_by values ('P#56','AC23M');
insert into bid_by values ('P#09','JK11M');


select * from bid_id;

alter session set nls_timestamp_format='HH12:Mi AM';
create table trainings(
	training_id		varchar(5)     constraint trng_pk primary key,
	tdate			date,
	ttime			timestamp(0),
	mgr_id			constraint trng_fk references managers not null
);

insert into trainings values ('T#03',TO_DATE('20/01/2020', 'DD/MM/YYYY'),to_timestamp('06:30 PM'),'AC23M');
insert into trainings values ('T#11',TO_DATE('03/02/2020', 'DD/MM/YYYY'),to_timestamp('05:00 AM'),'DS56M');
insert into trainings values ('T#35',TO_DATE('31/01/2020', 'DD/MM/YYYY'),to_timestamp('07:30 AM'),'ZZ01M');
insert into trainings values ('T#57',TO_DATE('17/03/2020', 'DD/MM/YYYY'),to_timestamp('07:00 PM'),'PG15M');

select * from trainings;

create table training_for(
	training_id		constraint trng_for_fk references trainings unique,
	player_id		constraint trng_for_fk2 references players,
	primary key(training_id,player_id)
);

insert into training_for values ('T#03','P#70');
insert into training_for values ('T#11','P#09');
insert into training_for values ('T#35','P#24');
insert into training_for values ('T#57','P#97');

select * from training_for;
