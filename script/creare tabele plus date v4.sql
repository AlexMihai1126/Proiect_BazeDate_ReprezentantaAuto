--stergere tabele daca au fost create inainte de rulare

drop TABLE asoc_dotari_masina cascade constraints ;
drop TABLE contract cascade constraints ;
drop table masina cascade constraints; 
drop table tip_contract cascade constraints; 
drop table motorizare cascade constraints ;
drop table dotare cascade constraints ;
drop table angajat cascade constraints ;
drop table culoare cascade constraints;
drop table departament cascade constraints;
drop table adresa cascade constraints;
drop table client cascade constraints;

--creare tabele plus check-uri

create table client(
   id_client number(4) primary key,
   nume varchar2(25) not null,
   prenume varchar2(25) not null,
   telefon number(10) not null unique,
   email varchar2(32) not null unique,
   cnp number(13) not null unique,
   adresa number(6) not null,
   constraint ckeck_cnp_client check (cnp>0),
   constraint ckeck_tel_client check (telefon>0)
);

create table angajat(
   id_angajat number(4) primary key,
   nume varchar2(25) not null,
   prenume varchar2(25) not null,
   telefon number(10) not null unique,
   email varchar2(32) not null unique,
   cnp number(13) not null unique,
   departament number(4),
   constraint ckeck_cnp_ang check (cnp>0),
   constraint ckeck_tel_ang check (telefon>0)
);

create table departament(
   id_departament number(4) primary key,
   nume varchar2(25) not null,
   id_manager number(4),
   adresa number(6) not null
);

create table adresa(
   id_adresa number(6) primary key,
   strada varchar2(255) not null,
   numar number(4) not null,
   oras varchar2(32) not null,
   judet varchar2(32) not null,
   constraint ckeck_nr_adr check (numar>0)
);

create table contract(
   id_contract number(8) primary key,
   tip number(2) not null,
   data_semnarii date not null,
   id_client number(4) not null,
   eta date,
   expira_la date
);

create table tip_contract(
   id_tip_contract number(2) primary key,
   nume varchar2(32) not null
);

create table masina(
   id_masina number(8) primary key,
   culoare number(3) not null,
   motorizare number(2) not null,
   vin varchar2(17) not null,
   data_productiei date not null,
   pret_brut number(8,2) not null,
   id_contract number(8),
   stoc varchar2(2) not null,
   constraint ckeck_pret check (pret_brut>0)
);

create table culoare(
   id_culoare number(3) primary key,
   nume varchar2(64) not null,
   pret number(4)
);

create table dotare(
   id_dotare number(3) primary key,
   nume varchar2(128) not null,
   pret number(5)
);

create table motorizare(
   id_motorizare number(2) primary key,
   nume varchar2(32) not null,
   combustibil varchar2(32) not null,
   cc number(4),
   hibrid varchar2(2),
   constraint ckeck_cc check (cc>850)
);

create table asoc_dotari_masina(
   id_masina number(8),
   id_dotare number(3)
);

--creare cheie primara compusa tabel asociativ
alter table asoc_dotari_masina add primary key (id_masina,id_dotare);

--creare chei straine

alter table client add foreign key (adresa) references adresa (id_adresa) on delete cascade;

alter table angajat add foreign key (departament) references departament (id_departament) on delete set null;

alter table departament add foreign key (id_manager) references angajat (id_angajat) on delete set null;

alter table departament add foreign key (adresa) references adresa (id_adresa) on delete cascade;

alter table contract add foreign key (tip) references tip_contract (id_tip_contract) on delete cascade;

alter table contract add foreign key (id_client) references client (id_client) on delete cascade;

alter table masina add foreign key (id_contract) references contract (id_contract) on delete set null;

alter table masina add foreign key (motorizare) references motorizare (id_motorizare) on delete cascade;

alter table masina add foreign key (culoare) references culoare (id_culoare) on delete cascade;

alter table asoc_dotari_masina add foreign key (id_dotare) references dotare (id_dotare) on delete cascade;

alter table asoc_dotari_masina add foreign key (id_masina) references masina (id_masina) on delete cascade;

--introducere date
--adrese
insert into adresa values (1,'Splaiul Unirii',311,'Bucuresti','Bucuresti');

insert into adresa values (2,'Strada Broscari',122,'Balotesti','Ilfov');

insert into adresa values (3,'Strada Pacii',7,'Brasov','Brasov');

insert into adresa values (4,'Strada Aviator Traian Vasile',72,'Bucuresti','Bucuresti');

insert into adresa values (5,'Strada Virgil Plesoianu',23,'Bucuresti','Bucuresti');

commit;
--departamente
insert into departament values(1,'Vanzari',null,1);

insert into departament values(2,'Comenzi',null,1);

insert into departament values(3,'Management inventar',null,5);

insert into departament values(4,'Consultatii leasing',null,5);

insert into departament values(5,'Management flote auto',null,5);

insert into departament values(6,'Intretinere',null,1);

insert into departament values(7,'Contabilitate',null,1);

insert into departament values(8,'IT',null,1);

commit;
--angajati
insert into angajat values(1,'Popescu','Liviu',0736212445,'lpopescu@gmail.com',1628928982912,8);

insert into angajat values(2,'Sandu','Andreea',0751265442,'andreea_s@renault.ro',2528728982719,1);

insert into angajat values(3,'Mihai','Florin',0721243215,'florin.m@outlook.com',5725618876514,2);

insert into angajat values(4,'Ion','Alexandru',0743789525,'ion_alex@hotmail.com',1735618846524,1);

insert into angajat values(5,'Antonescu','Daniel-Andrei',0721765521,'aa_daniel@renault.com',1787432146587,null);

commit;

--adaugare manager la departamente
update departament set id_manager = '5' where id_departament=1;

update departament set id_manager = '5' where id_departament=2;

update departament set id_manager = '5' where id_departament=8;

commit;

--dotari
insert into dotare values(1,'Aer conditionat manual',0);

insert into dotare values(2,'Navigatie premium cu touchscreen',1200);

insert into dotare values(3,'Bord digital',425);

insert into dotare values(4,'Clima automata pe 2 zone',750);

insert into dotare values(5,'Cutie automata 7 rapoarte',2200);

insert into dotare values(6,'Cutie automata 8 rapoarte',3500);

insert into dotare values(7,'Cutie manuala 5 trepte',0);

insert into dotare values(8,'Cutie manuala 6 trepte',350);

insert into dotare values(9,'Iluminare ambientala',250);

insert into dotare values(10,'Radio AM/FM cu bluetooth',0);

insert into dotare values(11,'Sistem audio Bose',950);

insert into dotare values(12,'Carlig tractare',650);

insert into dotare values(13,'Faruri halogen basic',150);

insert into dotare values(14,'Faruri LED basic',500);

insert into dotare values(15,'Faruri LED adaptive',1000);

insert into dotare values(16,'Scaune piele',1250);

insert into dotare values(17,'Bancheta spate rabatabila',350);

insert into dotare values(18,'Port incarcare USB-C fata',50);

insert into dotare values(19,'Porturi USB spate',100);

insert into dotare values(20,'Sistem tractiune integrala TORSEN',4500);

insert into dotare values(21,'Sistem tractiune integrala HALDEX',2500);

insert into dotare values(22,'Roti directtoare spate 4Control',5250);

insert into dotare values(23,'Tapiterie stofa',0);

insert into dotare values(24,'Interior piele Nappa',7500);

commit;
--culori
insert into culoare values(1,'Alb',0);

insert into culoare values(2,'Negru',0);

insert into culoare values(3,'Rosu metalizat',250);

insert into culoare values(4,'Alb perlat',350);

insert into culoare values(5,'Albastru metalizat',225);

insert into culoare values(6,'Negru metalizat',500);

insert into culoare values(7,'Verde metalizat',725);

insert into culoare values(8,'Negru mat',1250);

commit;
--clienti
insert into client values(1,'Mihai','Alexandru',0732967271,'amihai1@gmail.com',5011205420187,2);

insert into client values(2,'Andrei','Elena',0732967272,'elena_andrei@yahoo.com',2034205121187,2);

commit;

--tipuri contracte
insert into tip_contract values(1,'Vanzare-cumparare');

insert into tip_contract values(2,'Leasing');

insert into tip_contract values(3,'Testdrive');

commit;

--motorizari

insert into motorizare values(1,'1.5 Blue dCI 115','Motorina',1497,null);

insert into motorizare values(2,'1.3 TCe MHEV 160','Benzina',1332,'Da');

insert into motorizare values(3,'1.3 TCe 140','Benzina',1332,null);

insert into motorizare values(4,'E-Tech EV40 178','Electric',null,null);

insert into motorizare values(5,'E-Tech EV60 218','Electric',null,null);

commit;

--masini
insert into masina values(1,2,2,'VF1ABCDEFG',to_date('17-12-2022','DD-MM-YYYY'),17500,null,'Da');

insert into masina values(2,7,1,'VF1GHIJKLM',to_date('03-01-2023','DD-MM-YYYY'),14400,null,'Nu');

insert into masina values(3,4,4,'VF1GHIJKLM',to_date('08-01-2023','DD-MM-YYYY'),39750,null,'Nu');

insert into masina values(4,2,3,'VF1UBAMKLM',to_date('23-10-2022','DD-MM-YYYY'),12540,null,'Da');

commit;
--contracte
insert into contract values(1,1,to_date('05-01-2023','DD-MM-YYYY'),1,to_date('16-03-2023','DD-MM-YYYY'),null);

insert into contract values(2,1,to_date('07-01-2023','DD-MM-YYYY'),1,to_date('18-06-2024','DD-MM-YYYY'),null);

insert into contract values(3,2,to_date('05-01-2023','DD-MM-YYYY'),2,to_date('17-01-2023','DD-MM-YYYY'),to_date('17-03-2027','DD-MM-YYYY'));

commit;

--asociere dotari cu masinile

insert into asoc_dotari_masina values(1,1);
insert into asoc_dotari_masina values(1,4);
insert into asoc_dotari_masina values(1,12);
insert into asoc_dotari_masina values(1,16);
insert into asoc_dotari_masina values(1,2);
insert into asoc_dotari_masina values(1,19);
insert into asoc_dotari_masina values(1,3);
insert into asoc_dotari_masina values(2,7);
insert into asoc_dotari_masina values(2,1);
insert into asoc_dotari_masina values(2,10);
insert into asoc_dotari_masina values(2,19);
insert into asoc_dotari_masina values(2,23);
insert into asoc_dotari_masina values(2,18);
insert into asoc_dotari_masina values(3,2);
insert into asoc_dotari_masina values(3,6);
insert into asoc_dotari_masina values(3,20);
insert into asoc_dotari_masina values(3,17);
insert into asoc_dotari_masina values(3,24);
insert into asoc_dotari_masina values(3,15);
insert into asoc_dotari_masina values(3,11);
insert into asoc_dotari_masina values(3,22);
insert into asoc_dotari_masina values(4,1);
insert into asoc_dotari_masina values(4,7);
insert into asoc_dotari_masina values(4,10);
insert into asoc_dotari_masina values(4,23);
commit;

--asociere masini la contracte
update masina set id_contract = '1' where id_masina=1;

update masina set id_contract = '1' where id_masina=2;

update masina set id_contract = '2' where id_masina=3;

update masina set id_contract = '3' where id_masina=4;

commit;