-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                        (17/10/2022 16:17:13)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR1
--      Projet : 
--      Auteur : thevnin
--      Date de dernière modification : 17/10/2022 16:16:42
-- -----------------------------------------------------------------------------

DROP TABLE CATEGORIEART CASCADE CONSTRAINTS;

DROP TABLE CALANNEE CASCADE CONSTRAINTS;

DROP TABLE COMMANDE CASCADE CONSTRAINTS;

DROP TABLE DEPARTEMENT CASCADE CONSTRAINTS;

DROP TABLE VILLE CASCADE CONSTRAINTS;

DROP TABLE CLIENT CASCADE CONSTRAINTS;

DROP TABLE DEPOT CASCADE CONSTRAINTS;

DROP TABLE TRANSFERTDEPOT CASCADE CONSTRAINTS;

DROP TABLE ARTICLE CASCADE CONSTRAINTS;

DROP TABLE CALMOIS CASCADE CONSTRAINTS;

DROP TABLE STOCKERMOIS CASCADE CONSTRAINTS;

DROP TABLE TRANSFERER CASCADE CONSTRAINTS;

DROP TABLE VISITERWEB CASCADE CONSTRAINTS;

DROP TABLE HISTOPRIX CASCADE CONSTRAINTS;

DROP TABLE CONTENIR CASCADE CONSTRAINTS;

-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

-- CREATE DATABASE MLR1;
   -- n'existe pas dans oracle
-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIEART
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIEART
   (
    CODECAT VARCHAR2(12)  NOT NULL,
    CODECAT_ENGLOBE VARCHAR2(12)  NULL,
    NOMCAT VARCHAR2(30)  NULL
,   CONSTRAINT PK_CATEGORIEART PRIMARY KEY (CODECAT)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CATEGORIEART
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CATEGORIEART_CATEGORIEART
     ON CATEGORIEART (CODECAT_ENGLOBE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CALANNEE
-- -----------------------------------------------------------------------------

CREATE TABLE CALANNEE
   (
    CALANNEE NUMBER(4)  NOT NULL
,   CONSTRAINT PK_CALANNEE PRIMARY KEY (CALANNEE)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : COMMANDE
-- -----------------------------------------------------------------------------

CREATE TABLE COMMANDE
   (
    IDCOM NUMBER(4)  NOT NULL,
    CODEDEPOT VARCHAR2(12)  NULL,
    IDCLI NUMBER(4)  NOT NULL,
    DATECOM DATE  NULL,
    PRIXLIVRAISON NUMBER(6,2)  NULL,
    DATELIV DATE  NULL,
    COUTLIV NUMBER(6,2)  NULL
,   CONSTRAINT PK_COMMANDE PRIMARY KEY (IDCOM)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMMANDE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COMMANDE_DEPOT
     ON COMMANDE (CODEDEPOT ASC)
    ;

CREATE  INDEX I_FK_COMMANDE_CLIENT
     ON COMMANDE (IDCLI ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : DEPARTEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE DEPARTEMENT
   (
    CODEDEPT NUMBER(2)  NOT NULL,
    NOMDEPT VARCHAR2(32)  NULL
,   CONSTRAINT PK_DEPARTEMENT PRIMARY KEY (CODEDEPT)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : VILLE
-- -----------------------------------------------------------------------------

CREATE TABLE VILLE
   (
    CP NUMBER(6)  NOT NULL,
    CODEDEPT NUMBER(2)  NOT NULL,
    CODEDEPOT VARCHAR2(12)  NOT NULL,
    NOMVIL VARCHAR2(32)  NULL,
    NBHABITANTSVIL NUMBER(10)  NULL
,   CONSTRAINT PK_VILLE PRIMARY KEY (CP)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VILLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VILLE_DEPARTEMENT
     ON VILLE (CODEDEPT ASC)
    ;

CREATE  INDEX I_FK_VILLE_DEPOT
     ON VILLE (CODEDEPOT ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------

CREATE TABLE CLIENT
   (
    IDCLI NUMBER(4)  NOT NULL,
    CP NUMBER(6)  NOT NULL,
    NOMCLI VARCHAR2(32)  NULL,
    EMAILCLI VARCHAR2(128)  NULL,
    ADRESSECLI VARCHAR2(128)  NULL,
    PREMIUMCLI NUMBER(1)  NULL,
    TELCLI     VARCHAR2(14)
,   CONSTRAINT PK_CLIENT PRIMARY KEY (IDCLI)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CLIENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CLIENT_VILLE
     ON CLIENT (CP ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : DEPOT
-- -----------------------------------------------------------------------------

CREATE TABLE DEPOT
   (
    CODEDEPOT VARCHAR2(12)  NOT NULL,
    CP NUMBER(6)  NOT NULL,
    COUTVOLUMEDEP NUMBER(10,2)  NULL
,   CONSTRAINT PK_DEPOT PRIMARY KEY (CODEDEPOT)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE DEPOT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_DEPOT_VILLE
     ON DEPOT (CP ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : TRANSFERTDEPOT
-- -----------------------------------------------------------------------------

CREATE TABLE TRANSFERTDEPOT
   (
    IDTRANS NUMBER(4)  NOT NULL,
    CODEDEPOT VARCHAR2(12)  NOT NULL,
    CODEDEPOT_PARTIR VARCHAR2(12)  NOT NULL,
    DATETRANS DATE  NULL,
    COUTTRANS NUMBER(10,2)  NULL
,   CONSTRAINT PK_TRANSFERTDEPOT PRIMARY KEY (IDTRANS)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TRANSFERTDEPOT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TRANSFERTDEPOT_DEPOT
     ON TRANSFERTDEPOT (CODEDEPOT ASC)
    ;

CREATE  INDEX I_FK_TRANSFERTDEPOT_DEPOT1
     ON TRANSFERTDEPOT (CODEDEPOT_PARTIR ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : ARTICLE
-- -----------------------------------------------------------------------------

CREATE TABLE ARTICLE
   (
    REFART VARCHAR2(12)  NOT NULL,
    CODECAT VARCHAR2(12)  NOT NULL,
    LIBART VARCHAR2(45)  NULL,
    VOLUMEART NUMBER(6,2)  NULL,
    COUTAPPRO NUMBER(6,2)  NULL,
    DELAISAPPRO NUMBER  NULL
,   CONSTRAINT PK_ARTICLE PRIMARY KEY (REFART)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ARTICLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ARTICLE_CATEGORIEART
     ON ARTICLE (CODECAT ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CALMOIS
-- -----------------------------------------------------------------------------

CREATE TABLE CALMOIS
   (
    CALMOIS NUMBER(2)  NOT NULL,
    CALANNEE NUMBER(4)  NOT NULL
,   CONSTRAINT PK_CALMOIS PRIMARY KEY (CALMOIS, CALANNEE)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : STOCKERMOIS
-- -----------------------------------------------------------------------------

CREATE TABLE STOCKERMOIS
   (
    REFART VARCHAR2(12)  NOT NULL,
    CODEDEPOT VARCHAR2(12)  NOT NULL,
    CALMOIS NUMBER(2)  NOT NULL,
    CALANNEE NUMBER(4)  NOT NULL,
    QTETOTMOIS NUMBER(4)  NULL,
    QTECOMMOIS NUMBER(4)  NULL,
    QTEACT NUMBER(4)  NULL
,   CONSTRAINT PK_STOCKERMOIS PRIMARY KEY (REFART, CODEDEPOT, CALMOIS, CALANNEE)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE STOCKERMOIS
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_STOCKERMOIS_ARTICLE
     ON STOCKERMOIS (REFART ASC)
    ;

CREATE  INDEX I_FK_STOCKERMOIS_DEPOT
     ON STOCKERMOIS (CODEDEPOT ASC)
    ;

CREATE  INDEX I_FK_STOCKERMOIS_CALMOIS
     ON STOCKERMOIS (CALMOIS ASC, CALANNEE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : TRANSFERER
-- -----------------------------------------------------------------------------

CREATE TABLE TRANSFERER
   (
    REFART VARCHAR2(12)  NOT NULL,
    IDTRANS NUMBER(4)  NOT NULL,
    QTETTANS NUMBER(2)  NULL
,   CONSTRAINT PK_TRANSFERER PRIMARY KEY (REFART, IDTRANS)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TRANSFERER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TRANSFERER_ARTICLE
     ON TRANSFERER (REFART ASC)
    ;

CREATE  INDEX I_FK_TRANSFERER_TRANSFERTDEPOT
     ON TRANSFERER (IDTRANS ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : VISITERWEB
-- -----------------------------------------------------------------------------

CREATE TABLE VISITERWEB
   (
    REFART VARCHAR2(12)  NOT NULL,
    CALMOIS NUMBER(2)  NOT NULL,
    CALANNEE NUMBER(4)  NOT NULL,
    NBVISITES NUMBER(4)  NULL
,   CONSTRAINT PK_VISITERWEB PRIMARY KEY (REFART, CALMOIS, CALANNEE)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VISITERWEB
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VISITERWEB_ARTICLE
     ON VISITERWEB (REFART ASC)
    ;

CREATE  INDEX I_FK_VISITERWEB_CALMOIS
     ON VISITERWEB (CALMOIS ASC, CALANNEE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : HISTOPRIX
-- -----------------------------------------------------------------------------

CREATE TABLE HISTOPRIX
   (
    CALANNEE NUMBER(4)  NOT NULL,
    REFART VARCHAR2(12)  NOT NULL,
    PRIXVENTEART NUMBER(6,2)  NULL,
    PRIXACHATART NUMBER(6,2)  NULL
,   CONSTRAINT PK_HISTOPRIX PRIMARY KEY (CALANNEE, REFART)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE HISTOPRIX
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_HISTOPRIX_CALANNEE
     ON HISTOPRIX (CALANNEE ASC)
    ;

CREATE  INDEX I_FK_HISTOPRIX_ARTICLE
     ON HISTOPRIX (REFART ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CONTENIR
-- -----------------------------------------------------------------------------

CREATE TABLE CONTENIR
   (
    REFART VARCHAR2(12)  NOT NULL,
    IDCOM NUMBER(4)  NOT NULL,
    QTECOM NUMBER(2)  NULL,
    QTERETOUR NUMBER(2)  NULL
,   CONSTRAINT PK_CONTENIR PRIMARY KEY (REFART, IDCOM)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CONTENIR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CONTENIR_ARTICLE
     ON CONTENIR (REFART ASC)
    ;

CREATE  INDEX I_FK_CONTENIR_COMMANDE
     ON CONTENIR (IDCOM ASC)
    ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE CATEGORIEART ADD (
     CONSTRAINT FK_CATEGORIEART_CATEGORIEART
          FOREIGN KEY (CODECAT_ENGLOBE)
               REFERENCES CATEGORIEART (CODECAT))   ;

ALTER TABLE COMMANDE ADD (
     CONSTRAINT FK_COMMANDE_DEPOT
          FOREIGN KEY (CODEDEPOT)
               REFERENCES DEPOT (CODEDEPOT))   ;

ALTER TABLE COMMANDE ADD (
     CONSTRAINT FK_COMMANDE_CLIENT
          FOREIGN KEY (IDCLI)
               REFERENCES CLIENT (IDCLI))   ;

ALTER TABLE VILLE ADD (
     CONSTRAINT FK_VILLE_DEPARTEMENT
          FOREIGN KEY (CODEDEPT)
               REFERENCES DEPARTEMENT (CODEDEPT))   ;

ALTER TABLE VILLE ADD (
     CONSTRAINT FK_VILLE_DEPOT
          FOREIGN KEY (CODEDEPOT)
               REFERENCES DEPOT (CODEDEPOT))   ;

ALTER TABLE CLIENT ADD (
     CONSTRAINT FK_CLIENT_VILLE
          FOREIGN KEY (CP)
               REFERENCES VILLE (CP))   ;

ALTER TABLE DEPOT ADD (
     CONSTRAINT FK_DEPOT_VILLE
          FOREIGN KEY (CP)
               REFERENCES VILLE (CP))   ;

ALTER TABLE TRANSFERTDEPOT ADD (
     CONSTRAINT FK_TRANSFERTDEPOT_DEPOT
          FOREIGN KEY (CODEDEPOT)
               REFERENCES DEPOT (CODEDEPOT))   ;

ALTER TABLE TRANSFERTDEPOT ADD (
     CONSTRAINT FK_TRANSFERTDEPOT_DEPOT1
          FOREIGN KEY (CODEDEPOT_PARTIR)
               REFERENCES DEPOT (CODEDEPOT))   ;

ALTER TABLE ARTICLE ADD (
     CONSTRAINT FK_ARTICLE_CATEGORIEART
          FOREIGN KEY (CODECAT)
               REFERENCES CATEGORIEART (CODECAT))   ;

ALTER TABLE STOCKERMOIS ADD (
     CONSTRAINT FK_STOCKERMOIS_ARTICLE
          FOREIGN KEY (REFART)
               REFERENCES ARTICLE (REFART))   ;

ALTER TABLE STOCKERMOIS ADD (
     CONSTRAINT FK_STOCKERMOIS_DEPOT
          FOREIGN KEY (CODEDEPOT)
               REFERENCES DEPOT (CODEDEPOT))   ;

ALTER TABLE STOCKERMOIS ADD (
     CONSTRAINT FK_STOCKERMOIS_CALMOIS
          FOREIGN KEY (CALMOIS, CALANNEE)
               REFERENCES CALMOIS (CALMOIS, CALANNEE))   ;

ALTER TABLE TRANSFERER ADD (
     CONSTRAINT FK_TRANSFERER_ARTICLE
          FOREIGN KEY (REFART)
               REFERENCES ARTICLE (REFART))   ;

ALTER TABLE TRANSFERER ADD (
     CONSTRAINT FK_TRANSFERER_TRANSFERTDEPOT
          FOREIGN KEY (IDTRANS)
               REFERENCES TRANSFERTDEPOT (IDTRANS))   ;

ALTER TABLE VISITERWEB ADD (
     CONSTRAINT FK_VISITERWEB_ARTICLE
          FOREIGN KEY (REFART)
               REFERENCES ARTICLE (REFART))   ;

ALTER TABLE VISITERWEB ADD (
     CONSTRAINT FK_VISITERWEB_CALMOIS
          FOREIGN KEY (CALMOIS, CALANNEE)
               REFERENCES CALMOIS (CALMOIS, CALANNEE))   ;

ALTER TABLE HISTOPRIX ADD (
     CONSTRAINT FK_HISTOPRIX_CALANNEE
          FOREIGN KEY (CALANNEE)
               REFERENCES CALANNEE (CALANNEE))   ;

ALTER TABLE HISTOPRIX ADD (
     CONSTRAINT FK_HISTOPRIX_ARTICLE
          FOREIGN KEY (REFART)
               REFERENCES ARTICLE (REFART))   ;

ALTER TABLE CONTENIR ADD (
     CONSTRAINT FK_CONTENIR_ARTICLE
          FOREIGN KEY (REFART)
               REFERENCES ARTICLE (REFART))   ;

ALTER TABLE CONTENIR ADD (
     CONSTRAINT FK_CONTENIR_COMMANDE
          FOREIGN KEY (IDCOM)
               REFERENCES COMMANDE (IDCOM))   ;


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--                Remplissage des tables
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
REM INSERTING into CALANNEE
Insert into CALANNEE (CALANNEE) values (2020);
Insert into CALANNEE (CALANNEE) values (2021);
Insert into CALANNEE (CALANNEE) values (2022);


-- -----------------------------------------------------------------------------
REM INSERTING into CALMOIS
Insert into CALMOIS (CALMOIS,CALANNEE) values (1,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (1,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (1,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (2,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (2,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (2,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (3,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (3,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (3,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (4,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (4,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (4,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (5,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (5,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (5,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (6,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (6,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (6,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (7,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (7,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (7,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (8,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (8,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (8,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (9,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (9,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (9,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (10,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (10,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (10,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (11,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (11,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (11,2022);
Insert into CALMOIS (CALMOIS,CALANNEE) values (12,2020);
Insert into CALMOIS (CALMOIS,CALANNEE) values (12,2021);
Insert into CALMOIS (CALMOIS,CALANNEE) values (12,2022);

-- -----------------------------------------------------------------------------
REM INSERTING into CATEGORIEART
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('Me',null,'Mer');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('Mo',null,'Montagne');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('PetC',null,'Pêche et Chasse');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('App','PetC','Appats');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('MatP','PetC','Matériel de pêche');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('Ran','Mo','Randonée');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('SK','Mo','Ski');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('Su','Me','Surf');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('VME','Mo','Vêtement montagne été');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('VMH','Mo','Vêtement montagne hiver');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('VPC','PetC','Vêtement pêche et chasse');
Insert into CATEGORIEART (CODECAT,CODECAT_ENGLOBE,NOMCAT) values ('Ws','Me','Wetsuit');


-- -----------------------------------------------------------------------------
REM INSERTING into ARTICLE
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('AAA','Mo','andouillette',0.6,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('ail','Su','lot 3 ailerons',0.7,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('appC','App','cuillère',0.3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('appM','App','4 mouches',0.5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('appV','App','vairons 5/7cm',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('bc','Ran','10 barres céréales',0.3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('bo','VPC','bottes',2,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('bp','Ran','10 barres protéinées',0.3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('can','MatP','canne fibre',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('canE','MatP','canne Equipée',1.5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('ci','VPC','ciré',4,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('co3','Ws','combi intégrale 3,5mm',3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('co5','Ws','combi itégrale 5mm',3.5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('cp','VPC','chapeau de pêche',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('crb','VME','chaussures de randonnée basses',2,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('crm','VME','chaussures de randonnée montantes',3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('cse','VMH','chaussures de ski enfant',3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('csf','VMH','chaussures de ski femmes',6,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('csh','VMH','chaussures de ski homme',6,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('csr','VMH','chaussures de ski rando',6,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('ep','MatP','épuisette',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('gp','VPC','gilet de pêche',3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('hous6','Su','housse surf 6''',5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('hous7','Su','housse surf 7''',6,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('hous9','Su','housse surf 9''',7,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('le1','Su','leach court',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('le2','Su','leach long',1.2,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('ly','Ws','lycra',0.7,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('mf','Ws','maillot de bain femme',0.5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('mh','Ws','maillot de bain homme',0.5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('moul','MatP','moulinet',0.5,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('s1','Ran','sac 10l',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('s2','Ran','sac 15',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('sh','Ws','shorty',1,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('skg','SK','skis slalom géant',10,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('skr','SK','skis randonée',10,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('sks','SK','skis slalom spécial',10,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('su6','Su','surf 6''',50,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('su7','Su','surf 7''',70,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('su9','Su','longboard 9''',140,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('th','Ran','thermos 1l',1.2,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('vhm','VME','veste haute montagne',3,0,0);
Insert into ARTICLE (REFART,CODECAT,LIBART,VOLUMEART,COUTAPPRO,DELAISAPPRO) values ('vsm','VME','veste sans manche',1,0,0);



-- -----------------------------------------------------------------------------
REM INSERTING into DEPARTEMENT
Insert into DEPARTEMENT (CODEDEPT,NOMDEPT) values (31,'Haute-Garonne');
Insert into DEPARTEMENT (CODEDEPT,NOMDEPT) values (32,'Gers');
Insert into DEPARTEMENT (CODEDEPT,NOMDEPT) values (33,'Gironde');
Insert into DEPARTEMENT (CODEDEPT,NOMDEPT) values (34,'Hérault');
Insert into DEPARTEMENT (CODEDEPT,NOMDEPT) values (66,'Pyrénées-Orientales');


-- -----------------------------------------------------------------------------
alter table DEPOT disable constraint FK_DEPOT_VILLE;


REM INSERTING into DEPOT
Insert into DEPOT (CODEDEPOT,CP,COUTVOLUMEDEP) values ('dep31',31000,1);
Insert into DEPOT (CODEDEPOT,CP,COUTVOLUMEDEP) values ('dep32',32000,1.5);
Insert into DEPOT (CODEDEPOT,CP,COUTVOLUMEDEP) values ('dep33',33000,1.5);
Insert into DEPOT (CODEDEPOT,CP,COUTVOLUMEDEP) values ('dep34',34000,1);
Insert into DEPOT (CODEDEPOT,CP,COUTVOLUMEDEP) values ('dep66',66000,1);

-- -----------------------------------------------------------------------------
REM INSERTING into VILLE
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31000,31,'dep31','Toulouse',471941);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31130,31,'dep31','Balma',15807);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31170,31,'dep31','Tournefeuille',26477);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31270,31,'dep31','Cugnaux',17600);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31320,31,'dep31','Castanet-Tolosan',12833);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31520,31,'dep31','Ramonville-Saint-Agne',13829);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31600,31,'dep31','Muret',25264);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31700,31,'dep31','Blagnac',23759);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31770,31,'dep31','Colomiers',38801);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (31830,31,'dep31','Plaisance-du-Touch',17896);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32000,32,'dep32','Auch',21943);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32100,32,'dep32','Condom',6695);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32190,32,'dep32','Vic-Fezensac',3488);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32200,32,'dep32','Gimont',2973);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32300,32,'dep32','Mirande',3483);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32500,32,'dep32','Fleurance',6181);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32550,32,'dep32','Pavie',2468);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32600,32,'dep32','L''''Isle-Jourdain',8568);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32700,32,'dep32','Lectoure',3710);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (32800,32,'dep32','Eauze',3869);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33000,33,'dep33','Bordeaux',249712);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33130,33,'dep33','Bègles',27197);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33140,33,'dep33','Villenave-d''''Ornon',31620);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33160,33,'dep33','Saint-Médard-en-Jalles',30547);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33170,33,'dep33','Gradignan',25241);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33260,33,'dep33','La Teste-de-Buch',26110);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33400,33,'dep33','Talence',42171);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33500,33,'dep33','Libourne',24866);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33600,33,'dep33','Pessac',61332);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (33700,33,'dep33','Mérignac',70127);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34000,34,'dep34','Montpellier',277639);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34110,34,'dep34','Frontignan',22771);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34130,34,'dep34','Mauguio',17219);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34140,34,'dep34','Mèze',11537);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34170,34,'dep34','Castelnau-le-Lez',19504);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34200,34,'dep34','Sète',43620);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34300,34,'dep34','Agde',26946);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34400,34,'dep34','Lunel',25178);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34500,34,'dep34','Béziers',75999);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (34970,34,'dep34','Lattes',16298);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66000,66,'dep66','Perpignan',121934);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66140,66,'dep66','Canet-en-Roussillon',11965);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66200,66,'dep66','Elne',8659);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66240,66,'dep66','Saint-Estève',11698);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66250,66,'dep66','Saint-Laurent-de-la-Salanque',10301);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66320,66,'dep66','Pia',8741);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66330,66,'dep66','Cabestany',9790);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66600,66,'dep66','Rivesaltes',8678);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66700,66,'dep66','Argelès-sur-Mer',10383);
Insert into VILLE (CP,CODEDEPT,CODEDEPOT,NOMVIL,NBHABITANTSVIL) values (66750,66,'dep66','Saint-Cyprien',10412);


alter table DEPOT enable constraint FK_DEPOT_VILLE;



-- -----------------------------------------------------------------------------
REM INSERTING into HISTOPRIX
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'ail',26.18,18.18);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'appC',36.57,25.48);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'appM',48.49,34.07);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'appV',133.57,88.2);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'bc',26.44,18.62);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'bo',38.79,23.64);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'bp',28.35,21.07);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'can',21.05,14.21);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'canE',52.97,38.91);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'ci',86.33,58.79);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'co3',90.2,56.99);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'co5',160.01,108);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'cp',53.35,38.37);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'crb',145.4,100.45);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'crm',180.53,119.61);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'cse',67.89,42.25);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'csf',286.15,187.72);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'csh',287.12,188.7);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'csr',378.3,250.01);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'ep',50,35);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'gp',51.94,33.76);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'hous6',67.85,42.24);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'hous7',73.24,45.28);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'hous9',121.2,80.51);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'le1',19.4,13.23);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'le2',24.74,15.19);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'ly',29.05,19.48);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'mf',38.79,26.07);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'mh',17.94,12.05);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'moul',34.01,19.59);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'s1',87.29,57.39);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'s2',116.39,64.74);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'sh',58.19,39.19);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'skg',611.09,401.6);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'skr',688.8,431.69);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'sks',658.63,413.27);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'su6',499.5,304.29);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'su7',577.1,382.69);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'su9',672.16,416.99);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'th',33.9,21.12);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'vhm',202.73,136.51);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2020,'vsm',38.13,24.01);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'ail',26.99,18.55);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'appC',37.7,26);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'appM',49.99,34.97);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'appV',137.7,90);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'bc',27.26,19);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'bo',39.99,24.12);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'bp',29.23,21.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'can',21.7,14.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'canE',54.61,39.7);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'ci',89,59.99);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'co3',92.99,58.15);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'co5',164.96,110.2);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'cp',55,39.15);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'crb',149.9,102.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'crm',186.11,122.05);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'cse',69.99,43.11);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'csf',295,191.55);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'csh',296,192.55);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'csr',390,255.11);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'ep',null,null);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'gp',53.55,34.45);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'hous6',69.95,43.1);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'hous7',75.5,46.2);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'hous9',124.95,82.15);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'le1',20,13.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values ( 2021,'le2',25.5,15.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'ly',29.95,19.88);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'mf',39.99,26.6);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'mh',18.49,12.3);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'moul',35.06,19.99);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'s1',89.99,58.56);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'s2',119.99,66.06);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'sh',59.99,39.99);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'skg',629.99,409.8);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'skr',710.1,440.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'sks',679,421.7);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'su6',514.95,310.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'su7',594.95,390.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'su9',692.95,425.5);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'th',34.95,21.55);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'vhm',209,139.3);
Insert into HISTOPRIX (CALANNEE,REFART,PRIXVENTEART,PRIXACHATART) values (2021,'vsm',39.31,24.5);

-- -----------------------------------------------------------------------------
REM INSERTING into STOCKERMOIS
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ail','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ail','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('appC','dep31',1,2020,5,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('appC','dep31',2,2020,4,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('appM','dep31',1,2020,4,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('appM','dep31',2,2020,4,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('appV','dep31',1,2020,5,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('appV','dep31',2,2020,4,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('bc','dep31',1,2020,15,5,5);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('bc','dep31',2,2020,15,10,5);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('bo','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('bo','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('bp','dep31',1,2020,15,0,5);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('bp','dep31',2,2020,15,10,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('can','dep31',1,2020,3,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('can','dep31',2,2020,3,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('canE','dep31',1,2020,4,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('canE','dep31',2,2020,3,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ci','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ci','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('co3','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('co3','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('co5','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('co5','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('cp','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('cp','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('crb','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('crb','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('crm','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('crm','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('cse','dep31',1,2020,3,0,2);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('cse','dep31',2,2020,2,0,2);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('csf','dep31',1,2020,5,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('csf','dep31',2,2020,4,0,2);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('csh','dep31',1,2020,5,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('csh','dep31',2,2020,4,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('csr','dep31',1,2020,5,0,2);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('csr','dep31',2,2020,2,0,1);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ep','dep31',1,2020,6,0,5);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ep','dep31',2,2020,5,0,5);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('gp','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('gp','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('hous6','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('hous6','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('hous7','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('hous7','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('hous9','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('hous9','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('le1','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('le1','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('le2','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('le2','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ly','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('ly','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('mf','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('mf','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('mh','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('mh','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('moul','dep31',1,2020,7,0,6);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('moul','dep31',2,2020,6,0,6);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('s1','dep31',1,2020,10,0,1);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('s1','dep31',2,2020,11,10,8);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('s2','dep31',1,2020,5,0,2);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('s2','dep31',2,2020,2,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('sh','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('sh','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('skg','dep31',1,2020,5,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('skg','dep31',2,2020,3,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('skr','dep31',1,2020,5,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('skr','dep31',2,2020,3,0,2);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('sks','dep31',1,2020,5,0,4);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('sks','dep31',2,2020,4,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('su6','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('su6','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('su7','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('su7','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('su9','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('su9','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('th','dep31',1,2020,7,0,3);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('th','dep31',2,2020,3,0,1);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('vhm','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('vhm','dep31',2,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('vsm','dep31',1,2020,0,0,0);
Insert into STOCKERMOIS (REFART,CODEDEPOT,CALMOIS,CALANNEE,QTETOTMOIS,QTECOMMOIS,QTEACT) values ('vsm','dep31',2,2020,0,0,0);


-- -----------------------------------------------------------------------------
REM INSERTING into TRANSFERTDEPOT
Insert into TRANSFERTDEPOT (IDTRANS,CODEDEPOT,CODEDEPOT_PARTIR,DATETRANS,COUTTRANS) values (1,'dep32','dep31',to_timestamp('10/01/20','DD/MM/RR HH24:MI:SSXFF'),3);



-- -----------------------------------------------------------------------------
REM INSERTING into TRANSFERER
Insert into TRANSFERER (REFART,IDTRANS,QTETTANS) values ('moul',1,90);


-- -----------------------------------------------------------------------------
REM INSERTING into CLIENT
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (297,32100,'ADJOMAYI EP TOGOULIGA','ADJOMAYI EP TOGOULIGA','Rue de la découverte',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (298,32500,'TZVETKOVA','TZVETKOVA','Rue de la découverte BP 20 ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (299,31000,'AUBERT','AUBERT','10 place Alphonse Jourdain',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (300,34500,'DAUTREY','DAUTREY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (301,66000,'SALLIERES','SALLIERES',null,0,'6126xx666');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (302,31000,'GADIOT','GADIOT','1 Avenue André Marie Ampère bp 4215',0,'55927xx07');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (304,31770,'CHOUKROUN','CHOUKROUN',null,0,'68939xx53');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (305,34500,'JOHNSON','JOHNSON',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (306,31770,'COSTES-DRUILHE','COSTES-DRUILHE',null,0,'66352xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (307,66000,'BENHAYOUN','BENHAYOUN',null,0,'6112xx453');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (308,66000,'EDDIRY','EDDIRY',null,0,'5344xx106');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (309,31770,'BENEZECH','BENEZECH',null,0,'6678xx931');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (310,34000,'GARCIA','GARCIA',null,0,'05 62 11 xx 50');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (311,32000,'HANSER','HANSER','Avenue Raynal et Roquelaure - BP 76',0,'68692xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (312,32000,'RICHARD','RICHARD','Avenue Raynal et Roquelaure - BP 76',0,'56553xx80');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (313,66000,'TOURNIER','TOURNIER',null,0,'56142xx77');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (314,32800,'LI','LI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (315,31000,'LI','LI','216 route de saint simon',0,'61601xx82');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (316,34500,'ZHANG','ZHANG',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (317,33000,'MIOUX','MIOUX','95 Avenue Victor Hugo',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (318,31000,null,null,'25 chemin de pouvourville',0,'53450xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (319,66240,'LEVINA','LEVINA','PARC du MILLENAIRE    BAT C2',0,'01.41.22.xx.22');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (320,32000,'LI','LI',null,0,'05 34 50 xx 00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (321,34500,'AKPADJA-GBLOMATSI','AKPADJA-GBLOMATSI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (322,31000,'ZHANG','ZHANG','1 impasse Marcel Chalard Techno Parc Basso Cambo',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (323,34500,'ABADIE','ABADIE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (324,34500,'COUPIN','COUPIN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (325,31000,'PUSCO','PUSCO','17 Avenue Didier Daurat',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (326,34500,'RAIDO','RAIDO',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (327,34500,'NIEDBALA','NIEDBALA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (328,32600,'GRANDCLAUDE','GRANDCLAUDE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (329,32600,'LAPOUGE','LAPOUGE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (330,32600,'LEROUX','LEROUX',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (331,32600,'KONIAN','KONIAN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (332,32600,'WANG','WANG',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (333,32200,'RAVAT','RAVAT','ZI de la Herray',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (334,32800,'NASSARA','NASSARA','RUE DU PONT ST PIERRE',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (335,32600,'ABDELHANNANE','ABDELHANNANE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (336,32600,'HANSER','HANSER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (337,32600,'EL MERNISSI','EL MERNISSI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (338,32600,'PLANES','PLANES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (339,32600,'JERBI','JERBI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (340,32000,'KOUSSA','KOUSSA','Actiparc ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (341,32600,'MOURCELY','MOURCELY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (342,32600,'SARCELET','SARCELET',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (343,66140,'YEMMI','YEMMI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (344,66140,'PHAN','PHAN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (345,66140,'A-ESSAI','A-ESSAI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (346,66140,'A-ESSAI','A-ESSAI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (347,66140,'DETRUIT','DETRUIT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (348,66140,'BRETHOUS','BRETHOUS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (349,66140,'TAVERNIER','TAVERNIER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (350,66140,'YEMMI','YEMMI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (351,34000,'GRANDCLAUDE','GRANDCLAUDE',null,0,'09.79.99.xx.70');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (352,66140,'JERBI','JERBI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (353,66140,'LOUTFI','LOUTFI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (354,32550,'TCHEUTCHOUA','TCHEUTCHOUA','ZONE DE LA HERRAY',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (355,66140,'JOHNSON','JOHNSON',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (356,66140,'TZVETKOVA','TZVETKOVA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (357,66140,'FALLETTA','FALLETTA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (358,66140,'ADAM','ADAM',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (359,66140,'ARNALOT','ARNALOT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (360,66140,'FONTANINI','FONTANINI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (361,32000,'GRIFFEILLE','GRIFFEILLE','kjnkjln',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (362,34300,'EDOH','EDOH','qfvqv',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (363,31000,'DE VILLOUTREYS','DE VILLOUTREYS','1 Avenue André Marie Ampère',0,'05.62.47.xx.53');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (364,31000,'FARENC CAVAILLES','FARENC CAVAILLES','216, Route de Saint Simon',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (365,31000,'LAFOSSE','LAFOSSE','106 route du Chapitre',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (366,33260,'VERBIGUIE','VERBIGUIE','Passerelle SUD-1er étage""',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (368,66140,'COMBOURIEU','COMBOURIEU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (369,66140,'NLEMBA','NLEMBA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (370,33000,'BALLEREAU','BALLEREAU','5, Avenue Durand',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (371,66140,'NAKACHE','NAKACHE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (372,32000,'BOUCHEZ','BOUCHEZ','Bd de l''''Europe',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (373,31000,'MIREBEAU','MIREBEAU','216 route de saint simon',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (374,66140,'HANSER','HANSER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (375,32000,'ZHOU','ZHOU','Immeuble ""Buroparc 2"" - BP 87537',0,'6596xx612');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (376,32000,'TONDEUR','TONDEUR','Immeuble Stratege Rue Ampere',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (377,33000,'TONDEUR','TONDEUR','77 chemin des sept deniers',0,'05 62 12 xx 33');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (378,31000,'ZHANG','ZHANG','153, rue de Courcelles',0,'67283xx25');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (379,31000,'EL KHOURY','EL KHOURY','1 rond point Maurice Bellonte',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (380,33000,'EL KHOURY','EL KHOURY','7 rue Marcel Dassault - Z.A. La Mouline',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (381,32000,'MAHAMOUD','MAHAMOUD','Avenue de l''''Europe Regourd',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (382,32000,'SOLIYMANI','SOLIYMANI','Aeroport Toulouse-Blagnac',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (383,31270,'STEIN','STEIN','RUE JEAN BART QUATIER PLANTAUREL AGORA',0,'66077xx71');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (384,33000,'EL MERNISSI','EL MERNISSI','5, avenue Durand',0,'06 82 49 xx 32');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (385,31170,'TROILLARD','TROILLARD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (386,31170,'BASTIDE','BASTIDE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (387,33000,'PRONER','PRONER','75 voie du Toec',0,'06 81 33 xx 12');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (388,33000,'NIEDBALA','NIEDBALA','94/96 rue de Paris',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (389,33000,'AKA','AKA','75 Voie du Toec',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (390,31770,'BADIS','BADIS',null,0,'664xx7529');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (391,31170,'RESTOG','RESTOG',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (392,31170,'LOUTFI','LOUTFI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (393,32000,'AZZANE','AZZANE',null,0,'01 44 71 xx 68');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (394,66000,'TORRES','TORRES',null,0,'56247xx70');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (395,31170,'RAKOTOMAHEFA','RAKOTOMAHEFA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (396,31170,'LAGOUNE','LAGOUNE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (397,34000,'CAVAILLES','CAVAILLES',null,0,'05 62 11 xx 50');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (398,66000,'MONTLOUIS','MONTLOUIS',null,0,'53460xx30');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (399,66000,'ONIVOGUI','ONIVOGUI',null,0,'534603xx30');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (400,66000,'SOW','SOW',null,0,'62065xx96');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (401,66000,'LEROUX','LEROUX',null,0,'62181xx37');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (402,31170,'AMALRIC','AMALRIC',null,1,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (403,31170,'PAGES','PAGES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (404,31170,'VERGÉ','VERGÉ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (405,66000,'NASSARA','NASSARA',null,0,'61437xx96');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (406,31170,'LUPOT','LUPOT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (407,66000,'POPOVA','POPOVA',null,0,'561xx5429');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (408,66000,'ROSIER','ROSIER',null,0,'53430xx50');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (409,31170,'YU','YU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (410,31170,'FABER','FABER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (411,66000,'OUCHAOU','OUCHAOU',null,0,'61010xx39');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (412,31170,'EL KHALLOUKI','EL KHALLOUKI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (413,66000,'CAMARA','CAMARA',null,0,'55977xx50');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (414,31170,'FELICITE','FELICITE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (415,31170,'AZZANE','AZZANE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (416,66000,'THOONSEN','THOONSEN',null,0,'62481xx97');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (417,31170,'GARDAN','GARDAN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (418,31170,'BROUMI','BROUMI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (419,31170,'ROHBAN','ROHBAN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (420,33000,'ROHBAN','ROHBAN','75, Voie du Toec',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (421,31170,'LAPIERRE','LAPIERRE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (422,66000,'GARCIA','GARCIA',null,0,'62638xx64');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (423,31170,'SY','SY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (424,33600,'BERGES','BERGES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (425,33600,'GHELLER','GHELLER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (426,33600,'CABAL','CABAL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (427,33600,'DEPOORTER','DEPOORTER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (428,32000,'DA COSTA','DA COSTA','Avenue Antoine Becquerel""',0,'06 30 35 xx 33');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (429,34000,'MORISSET','MORISSET',null,0,'05 62 47 xx 99');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (430,34000,'CHAZELLE','CHAZELLE',null,0,'05.62.xx.70.70');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (431,33600,'CUCULIERE','CUCULIERE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (432,33000,'ZAOUI','ZAOUI','7 avenue Didier Daurat',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (433,66000,'KONIAN','KONIAN',null,0,'561xx8881');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (434,33600,'ADJOUALÉ','ADJOUALÉ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (435,33600,'LOUTFI','LOUTFI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (436,33600,'ARQUE','ARQUE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (437,33600,'MAHE-KOLBE','MAHE-KOLBE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (438,33600,'RICHARD','RICHARD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (439,33600,'JARDIN','JARDIN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (440,33600,'DETRUIT','DETRUIT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (441,33600,'ALBERT','ALBERT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (442,33600,'AGAD','AGAD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (443,33600,'LEVINA','LEVINA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (444,32000,'MEZUI-ONA','MEZUI-ONA','Immeuble Les Portes de Pessac',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (445,32700,'MEZUI-ONA','MEZUI-ONA','RUE JEAN BART QUATIER PLANTAUREL AGORA',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (446,31000,'ESTRADE','ESTRADE','271 avenue de Grande Bretagne  - BP3111',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (447,31000,'KABECHE','KABECHE','271 av de Grande Bretagne',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (448,33600,'OUEDRAOGO','OUEDRAOGO',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (449,33600,'LAPOUGE','LAPOUGE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (450,33600,'DE VILLOUTREYS','DE VILLOUTREYS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (451,32100,'SIGOGNE','SIGOGNE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (452,31000,'VAUCHEL','VAUCHEL','10, Place Alfonse Jourdain',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (453,32000,'MERY','MERY','Avenue Jean Baylet',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (454,32100,'LEPERLIER','LEPERLIER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (455,32100,'LAMARQUE','LAMARQUE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (456,31000,'TROILLARD','TROILLARD','1 Avenue André Marie Ampère ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (457,32190,'LUO','LUO','RUE LEON JOULIN',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (458,32100,'BOUTROS','BOUTROS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (459,32700,'CHOUHDI','CHOUHDI','sans',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (460,32100,'LENFANT','LENFANT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (461,32100,'MAUVAIS','MAUVAIS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (462,33000,'CABOT','CABOT','41 RUE SAINT AUGUSTIN',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (463,33000,'ABDELHANNANE','ABDELHANNANE','4bis rue de brindejonc des moulinais',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (464,32100,'THEVENIN','THEVENIN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (465,32100,'TORRES','TORRES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (466,31000,'TZVETKOVA','TZVETKOVA','1 rond point Maurice Bellonte',0,'6206xx544');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (467,33000,'BLANC','BLANC','9 rue Paulin Talabot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (468,33000,'WEN','WEN','9 rue Paulin Talabot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (469,33000,'EL KHALLOUKI','EL KHALLOUKI','9 rue Paulin Talabot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (470,33000,'LAPIERRE','LAPIERRE','9 rue Paulin Talabot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (471,32100,'FABER','FABER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (472,32100,'LUTIKU','LUTIKU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (473,66240,'OUCHAOU','OUCHAOU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (474,33000,'AGAD','AGAD','9 rue pages',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (475,66240,'MUGNIER','MUGNIER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (476,31000,'GHELLER','GHELLER','12 place Lafourcade',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (477,31000,'RÉTHORÉ','RÉTHORÉ','24 rue Théron de Montaugé',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (478,31770,'SOLIYMANI','SOLIYMANI',null,0,'6684xx040');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (479,66240,'CAMARA','CAMARA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (480,31000,'LAGOUNE','LAGOUNE','2 rue du Doyen Gabriel Marty',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (481,66000,'DO REGO','DO REGO',null,0,'6580xx376');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (482,32000,'FARENC','FARENC','Bd de l''''Europe BP40494',0,'5477xx771');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (483,66240,'COSTES','COSTES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (484,66240,'MENNAD','MENNAD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (485,33000,'CAVAILLES','CAVAILLES','83 BVD CARNOT',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (486,66240,'RAVAT','RAVAT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (487,34000,'EL BOUTAHIRI','EL BOUTAHIRI',null,0,'05.62.71.xx.84');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (488,32800,'KOUEMO NGOUABE','KOUEMO NGOUABE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (489,32800,'FELICITE','FELICITE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (490,66240,'ADEDJOUMA','ADEDJOUMA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (491,33000,'ZEKRYTY','ZEKRYTY','71 route de Lannemezan',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (492,66240,'SY','SY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (493,66240,'PERRON','PERRON',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (494,66240,'BLEYS','BLEYS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (495,66240,'GONARD LOPEZ','GONARD LOPEZ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (496,66000,'AZAROUAL','AZAROUAL',null,0,'62769xx49');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (497,31000,'BELAMINE','BELAMINE','135 RUE DE PERIOLE',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (498,32000,'BELOUAD','BELOUAD','Le Boston 9 rue Talabot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (499,33000,'RIVES','RIVES','7 Avenue Didier Daurat',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (500,66240,'MARTINEZ','MARTINEZ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (501,66240,'DUCHENNE','DUCHENNE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (502,66240,'MEZUI-ONA','MEZUI-ONA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (503,66240,'AMALRIC','AMALRIC',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (504,66240,'POPOVA','POPOVA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (505,66240,'LANDY','LANDY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (506,66240,'RAKOTOMAHEFA','RAKOTOMAHEFA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (507,66240,'FAIVRE','FAIVRE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (508,31770,'BERGES','BERGES',null,0,'6813xx312');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (509,66240,'FALIÈRE','FALIÈRE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (510,66240,'VALAT','VALAT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (511,66240,'LAMARQUE','LAMARQUE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (512,34170,'PICARD','PICARD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (513,34170,'SKAF','SKAF',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (514,34170,'BERLIOZ','BERLIOZ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (515,66000,'ALASSET','ALASSET',null,0,'5615xx421');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (516,34170,'ZHOU','ZHOU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (517,34170,'LAMARQUE','LAMARQUE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (518,34170,'PRATHOUMMACHITH','PRATHOUMMACHITH',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (519,34170,'COLOMBON','COLOMBON',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (520,66000,'RICQUEBOURG','RICQUEBOURG',null,0,'5346xx830');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (521,34000,'MIERSONNE','MIERSONNE',null,0,'06 72 90 xx 60');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (522,66000,'JULIEN','JULIEN',null,0,'53450xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (523,32800,'LE','LE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (524,34170,'LAGANE','LAGANE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (525,34170,'CHEN','CHEN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (526,34170,'KAYA','KAYA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (527,34170,'LEITAO MARQUES','LEITAO MARQUES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (528,34170,'FALLIERE','FALLIERE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (529,34170,'GUO','GUO',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (530,31600,'ROUVEL','ROUVEL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (531,31600,'ITANDA KOWET','ITANDA KOWET',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (532,31600,'MEYER','MEYER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (533,31770,'FAYAUD','FAYAUD',null,0,'65966xx30');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (534,31600,'CHUNG TAN','CHUNG TAN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (535,34200,'TOURNIER','TOURNIER','Prologue 1, la Pyrénéenne',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (536,31600,'PEREIRA','PEREIRA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (537,31600,'ESSAI','ESSAI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (538,32000,'REMY','REMY',null,0,'05 34 50 xx 00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (539,31600,'BARENDES','BARENDES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (540,31700,'CARRER','CARRER',null,1,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (541,31700,'BP 45848','BP 45848',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (542,31700,'Cedex 5""','Cedex 5""',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (543,31700,'NIFLORE','NIFLORE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (544,31700,'CHOUHDI','CHOUHDI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (545,31700,'HANI','HANI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (546,31770,'CHERIFI','CHERIFI',null,0,'67289xx25');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (547,31000,'MEROUANE','MEROUANE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (548,31770,'GHOBRINI','GHOBRINI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (549,31700,'BEUGRE','BEUGRE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (550,33000,'RAHAL','RAHAL','8 esplanade Compans Caffarelli',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (551,31000,'ARAB','ARAB','1-5 Avenue Albert Durand',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (552,31700,'CHEBOUB','CHEBOUB',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (553,31700,'JOULIE','JOULIE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (554,31700,'OUEDRHIRI','OUEDRHIRI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (555,31700,'SMAIL','SMAIL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (556,33000,'PHAM','PHAM','5 Avenue Marcel Dassault',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (557,32300,'SOW','SOW','Rue mesple',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (558,32200,'MECKES','MECKES','RUE MESPLE',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (559,31700,'DULAC','DULAC',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (560,31700,'GUO','GUO',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (561,34000,'DETRUIT','DETRUIT',null,0,'06.98.41.xx.52');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (562,31770,'HANI','HANI',null,0,'66414xx18');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (563,31770,'RABEMANANJARA','RABEMANANJARA',null,0,'68694xx26');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (564,33600,'AFRITT','AFRITT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (565,33700,'NEPLE','NEPLE','Parc du Cabanis - 6 rue du Cabanis - BP 60130 -',0,'05-62-xx-33-53');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (566,31170,'RAHAL','RAHAL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (567,34000,'DA SILVA','DA SILVA',null,0,'05-62-47-xx-70');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (568,33600,'LENFANT','LENFANT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (569,33600,'HANI','HANI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (570,66000,'LAFITTE','LAFITTE',null,0,'561xx8881');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (571,33600,'SMAIL','SMAIL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (572,33600,'RABEMANANJARA','RABEMANANJARA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (573,33600,'PONT','PONT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (574,33600,'LAPIERRE','LAPIERRE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (575,31600,'ROULY','ROULY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (576,33600,'cedex 3""','cedex 3""',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (577,32000,'FALIÈRE','FALIÈRE','colomiers',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (578,31700,'BELAMINE','BELAMINE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (579,31830,'MEZUI-ONA','MEZUI-ONA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (580,33600,'RANDRIAMIHAMINA','RANDRIAMIHAMINA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (581,33600,'EHRMANN','EHRMANN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (582,33400,'ALLAIS','ALLAIS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (583,33400,'AMROUCHE','AMROUCHE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (584,32000,'BENKACI','BENKACI','Caserne Pérignon, rue Pérignon',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (585,32000,'GUO','GUO',null,0,'5614577');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (586,33400,'ESTRADE','ESTRADE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (587,33400,'PHAM','PHAM',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (588,33400,'PHAM','PHAM',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (589,33000,'RAKOTOMAHEFA','RAKOTOMAHEFA','9 rue Paulin Talabot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (590,33000,'DEAT','DEAT','69 BIS CH DES CLOTASSES',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (591,33000,'NAKACHE','NAKACHE','75 voie du Toec',0,'562xx7120');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (592,66750,'SERRANO','SERRANO','UN IMP MARCEL CHALARD',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (593,33400,'BLEYS','BLEYS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (594,33400,'Meyer','Meyer',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (595,66000,'PROUFIT','PROUFIT',null,0,'6580xx504');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (596,31770,'BENOITON','BENOITON',null,0,'6630xx394');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (597,66000,'MABONGO','MABONGO',null,0,'5677xx311');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (598,31770,'DAX','DAX',null,0,'6855xx874');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (599,31770,'CUCULIERE','CUCULIERE',null,0,'6693xx953');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (600,32000,'ROBERT','ROBERT','Avenue Escadrille Normandie-Niemen',0,'5672xx114');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (601,66000,'FRITZ','FRITZ',null,0,'6203xx213');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (602,33000,'DUQUE','DUQUE','41 RUE SAINT AUGUSTIN',0,'6634xx069');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (603,31770,'KAYA','KAYA',null,0,'6869xx543');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (604,31770,'LAMKAISSI','LAMKAISSI',null,0,'6845xx391');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (605,31770,'SANCHEZ','SANCHEZ',null,0,'6630xx394');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (606,66000,'BOUGNOL','BOUGNOL',null,0,'6302xx769');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (607,33000,'RAMIER','RAMIER','75 voie du Toec',0,'05.34.50.xx.10');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (608,34000,'GARY','GARY',null,0,'05.34.50.xx.11');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (609,66000,'TEST','TEST',null,0,'561xx7316');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (610,34000,'ALI ARREH','ALI ARREH',null,0,'06.75.02.14.XX');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (611,34000,'NDIAYE','NDIAYE',null,0,'06-XX-34-28-35');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (612,31770,'TRAORE','TRAORE',null,0,'6632xx366');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (613,34000,'DIALLO','DIALLO',null,0,'335 61 XX 57');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (614,31270,'ALANOIX','ALANOIX',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (615,33140,'MANEZ','MANEZ','Parc du Millénaire, C2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (616,31830,'HANSER','HANSER','RUE DU PONT ST PIERRE',0,'60XX82659');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (617,66330,'JARDIN','JARDIN','Passerelle SUD-1er étage""',0,'06 83 10 XX 37');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (618,34000,'THOONSEN','THOONSEN',null,0,'14XX94127');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (619,34000,'TINTIN','TINTIN',null,0,'05 61 XX 02 20');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (620,31130,'COSTES','COSTES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (621,34000,'BELLANGER','BELLANGER',null,0,'06 64 81 XX 00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (622,31770,'LARRIBE','LARRIBE',null,0,'688XX7822');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (623,66000,'RAVAT','RAVAT',null,0,'56114XX54');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (624,66000,'RANFT','RANFT',null,0,'53450XX05');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (625,33400,'LOGACHEVA','LOGACHEVA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (626,33400,'ULMASOVA','ULMASOVA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (627,34300,'NGUYEN','NGUYEN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (628,34300,'FONTEBASSO','FONTEBASSO',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (629,34300,'KONG','KONG',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (630,33000,'ABDELHANNANE','ABDELHANNANE','6, rue Roger Salengro',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (631,32000,'ROUSSEL','ROUSSEL','Immeuble Synapse Avenue Didier Daurat',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (632,32000,'JMT','JMT','Bâtiment C2, Parc du Millénaire, avenue escadrille normandie Niemen',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (633,34300,'NGASSU','NGASSU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (634,33000,'RAHARISON','RAHARISON','7 Avenue Didier Daurat',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (635,32550,'TARTARIN','TARTARIN','Rue Mesplé',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (636,33000,'SKAF','SKAF','7 avenue didier daurat',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (637,31520,'RASOLONJATOVO','RASOLONJATOVO',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (638,34300,'VERBIGUIÉ','VERBIGUIÉ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (639,31000,'SAOUD','SAOUD','2, Rue du Doyen Gabriel Marty',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (640,34000,'ELKHAOULANI','ELKHAOULANI',null,0,'06.75.02.14.XX');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (641,34000,'KAID OMAR','KAID OMAR',null,0,'06-XX-34-28-35');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (642,31770,'AGAD','AGAD',null,0,'6632xx366');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (643,66000,'PERRON','PERRON',null,0,'335 61 XX 57');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (644,31320,'HERMAN','HERMAN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (646,66000,'CHIOUA','CHIOUA',null,0,'60XX82659');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (647,34000,'OULD SI BOUZIANE','OULD SI BOUZIANE',null,0,'06 83 10 XX 37');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (648,34000,'RODRIGUEZ','RODRIGUEZ',null,0,'14XX94127');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (649,34000,'LENFANT','LENFANT',null,0,'05 61 XX 02 20');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (650,33000,'HUNEAU','HUNEAU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (651,34000,'THIA','THIA',null,0,'06 64 81 XX 00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (652,31770,'FALLETTA','FALLETTA',null,0,'688XX7822');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (653,66000,'CHABAUD','CHABAUD',null,0,'56114XX54');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (654,33130,'GROS','GROS','Passerelle Sud',0,'53450XX05');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (655,34300,'FALGA','FALGA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (656,34300,'VALLET','VALLET',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (657,34300,'BRETHOUS','BRETHOUS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (658,34400,'LENFANT','LENFANT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (659,34400,'RABEMANANJARA','RABEMANANJARA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (660,32000,'MARTINEZ','MARTINEZ','BP 7',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (661,66000,'PEPIN','PEPIN','rue S.Allende',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (662,34400,'TAVERNIER','TAVERNIER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (1,34000,'LAMBERT','LAMBERT',null,0,'06 82 41 XX 76');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (2,31000,'PAUL','PAUL','216, Route de Saint Simon',0,'06.13.45.XX.70');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (3,32000,'OULD EL HACEN','OULD EL HACEN','Caserne Pérignon',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (4,31000,'GUY','GUY','11 AVENUE PARMENTIER',0,'06.89.43.XX.43');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (6,31000,'DIMOVA','DIMOVA','216 route de saint simon',0,'05 61 XX 45 03');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (7,31000,'HAJOUI','HAJOUI','3 rue Dieudonné Costes',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (8,31000,'DOUZAL','DOUZAL','11 Avenue Parmentier - BP 70117',0,'05 34 XX 75 75');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (9,31000,'DURAND','DURAND','24 rue Edouard Vaillant',0,'06 63 25 31 86');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (10,31000,'MILARD','MILARD','1 Rond-point Maurice Bellonte',0,'05 62 XX 18 65');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (12,32000,'BELMEHDI','BELMEHDI','Caserne Pérignon',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (13,33000,'RACHINEL','RACHINEL','9 RUE PIERRE DUPONT',0,'05-62-XX-61-05');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (14,31000,'FOISSAC','FOISSAC','22, bd Déodat de Séverac',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (15,31000,'NAKACHE','NAKACHE','22, bd Déodat de Séverac',1,'05 61 12 87 99');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (16,31000,'XENOPHANE','XENOPHANE','106 rte du chapitre',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (17,31000,'CADIOT','CADIOT','2 Impasse du Bassin',0,'05-61-00-XX-44');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (18,32000,'SEEBAH','SEEBAH','buroparc 3',0,'06-60-74-XX-90');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (19,33000,'LOUGE','LOUGE','7, impasse Georges Brassens',0,'05-61-31-XX-41');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (20,33000,'DI BENEDETTO','DI BENEDETTO','7 rue jean bart',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (21,31520,'TCHOUDJINOFF','TCHOUDJINOFF','Rue mesple',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (22,31770,'DEBREGEAS','DEBREGEAS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (23,31000,'MIDELET','MIDELET','300 rue Léon Joulin',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (24,33160,'RUIZ','RUIZ','parc technologique de basso cambo 6 impasse paul Mesplé BP 1304',0,'06-72-89-XX-60');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (25,33000,'FLORENTIN','FLORENTIN','64 bis rue La Boétie',0,'06-13-16-XX-09');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (26,33000,'SORNOM','SORNOM','9, rue du Colombier',0,'00-00-00-00-00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (27,66140,'FLEJOU','FLEJOU','parc du canal, 1 rue Marie Curie',0,'00-00-00-00-00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (28,33000,'BATUT','BATUT','5 rue hérold',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (29,32800,'DUONG','DUONG','sans',0,'05-61-42-XX-01');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (30,31000,'LESGOURGUES','LESGOURGUES','20 rue sainte anne',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (31,33000,'BAUDRU','BAUDRU','75 voie du Toec',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (32,34000,'VERRANDO','VERRANDO',null,0,'05-61-42-XX-03');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (33,34400,'NORCIA','NORCIA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (34,33700,'DUVAL','DUVAL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (35,33700,'BARATHIEU','BARATHIEU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (36,33700,'WONG HUON KWON','WONG HUON KWON',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (37,34000,'MECEGUER','MECEGUER',null,0,'05-34-50-XX-05');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (38,34000,'MARIANINI','MARIANINI',null,0,'06-82-49-XX-32');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (39,34400,'FONTANINI','FONTANINI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (40,34000,'BARGACH','BARGACH',null,0,'06-10-62-46-18');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (41,34400,'DE LANNURIEN','DE LANNURIEN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (42,33700,'KERBIQUET','KERBIQUET',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (43,33700,'CHAUVET','CHAUVET',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (44,31700,'PITUELLO','PITUELLO','Rue de la découverte BP 20 ',0,'5611XX454');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (45,34000,'NGUYEN','NGUYEN',null,0,'06-71-13-XX-64');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (46,33700,'MARIN','MARIN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (47,31320,'CANDEAU','CANDEAU','RUE MESPLE',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (48,33000,'CHAIGNEAU','CHAIGNEAU','Rue Mesplé',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (49,33700,'RIGELO','RIGELO','rue S.Allende',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (50,33600,'MAHEKOLBE','MAHEKOLBE','rue salvador Allende',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (51,33400,'DUROCHER','DUROCHER','sans',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (52,33140,'DE VILLOUTREYS','DE VILLOUTREYS','sans',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (53,33160,'SAINT-CRIQ','SAINT-CRIQ','UN IMP MARCEL CHALARD',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (54,33130,'SAINT GERMAIN','SAINT GERMAIN','Université Toulouse 1, Place Anatole france',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (55,33260,'GAETANO','GAETANO','ZI de la Herray',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (56,33170,'BLANCHARD','BLANCHARD','ZONE DE LA HERRAY',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (57,66200,'CHAYNES NÉE PLESSIS','CHAYNES NÉE PLESSIS','Place Anatole France',0,'06-63-73-XX-97');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (58,33700,'FABRIES','FABRIES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (59,66600,'BARRE','BARRE','place alphonse jourdain',0,'06-63-38-XX-46');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (60,33500,'DE SULZER WART','DE SULZER WART','Parc du Cabanis - 6 rue du Cabanis - BP 60130 -',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (61,34000,'VINCENT','VINCENT','parc du canal, 1 rue Marie Curie',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (62,66750,'LEVY-VALENSI','LEVY-VALENSI','Parc du Millénaire, C2',0,'01-46-78-XX-65');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (63,33700,'BONAFOUS','BONAFOUS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (64,34500,'DJAOUTI','DJAOUTI','PARC du MILLENAIRE    BAT C2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (65,34000,'BERNARDINI','BERNARDINI',null,0,'06-22-45-XX-64');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (66,34000,'MOLINIE','MOLINIE',null,0,'05-61-16-XX-52');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (67,34000,'DE GROOTH','DE GROOTH',null,0,'05-61-42-XX-02');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (68,34200,'THÉVENIN','THÉVENIN','Parc du Millénaire, C2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (69,31000,'DI BENEDETTO','DI BENEDETTO','Place Occitane',0,'06-64-13-XX-00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (70,34500,'LUISETTO','LUISETTO','Place Occitane',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (71,32600,'DE NARDO','DE NARDO','Rue Mesplé',0,'05-61-54-XX-41');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (72,34000,'TIRACH','TIRACH',null,0,'06-07-83-XX-72');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (73,34140,'HAMMAMI','HAMMAMI','Rue mesple',0,'615830096');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (74,32000,'FLORENTIN','FLORENTIN','Aeroport',0,'06-15-33-XX-04');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (75,32000,'LECLERCQ','LECLERCQ','Aéroport de Toulouse Blagnac',0,'05-61-16-XX-40');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (76,34000,'RICHARD','RICHARD',null,0,'05-61-42-XX-57');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (77,33000,'TCHOUDJINOFF','TCHOUDJINOFF','54 bld de l''''embouchure',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (78,31000,'CADIOT','CADIOT','25, bis av Marcel Dassault',0,'06-20-97-XX-97');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (79,33600,'BARGACH','BARGACH','parc du canal, 1 rue Marie Curie',0,'06-62-38-XX-01');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (80,34400,'CABAL','CABAL',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (81,34000,'MOUTAMAMALLE','MOUTAMAMALLE',null,0,'05-62-16-XX-52');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (82,32000,'FABRIES','FABRIES','AV MAXWELL',0,'04-78-33-XX-23');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (83,34000,'COUPIN','COUPIN',null,0,'05-62-71-XX-08');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (84,34000,'HAYDER','HAYDER',null,0,'05-62-71-XX-84');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (85,34000,'BARRE','BARRE',null,0,'05-61-42-XX-76');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (86,34130,'Aéroport de Toulouse Blagnac""','Aéroport de Toulouse Blagnac""','RUE JEAN BART QUATIER PLANTAUREL AGORA',0,'05-61-13-XX-59');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (87,32000,'GOVINDIN','GOVINDIN','NÉANT',0,'06-80-57-XX-73');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (88,32000,'PISTRE','PISTRE','RUE MESPLE',0,'06-14-69-XX-28');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (89,34000,'DIFOU','DIFOU',null,0,'06-64-84-XX-21');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (90,34000,'NAKACHE','NAKACHE',null,0,'05-34-61-XX-80');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (91,34000,'MAHE-KOLBE','MAHE-KOLBE',null,0,'05-34-61-XX-80');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (92,34000,'la barigoude""','la barigoude""',null,0,'05-61-62-XX-03');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (93,34170,'DIMOVA','DIMOVA','RUE DU PONT ST PIERRE',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (94,32190,'Bât B""','Bât B""','UN IMP MARCEL CHALARD',0,'05-61-00-XX-40');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (95,32000,'MARTINEZ','MARTINEZ','LABEGE INNOPOLE',0,'05-61-12-XX-81');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (96,34970,'MAUDOU','MAUDOU','RUE LEON JOULIN',0,'06-22-69-XX-62');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (97,34000,'foissac','foissac',null,0,'06-13-16-XX-09');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (98,32000,'TILLET','TILLET','Aeroport Toulouse Blagnac',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (99,34000,'FONTANIER','FONTANIER',null,0,'06-63-73-XX-97');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (100,34000,'FINETTE-CONSTANTIN','FINETTE-CONSTANTIN',null,0,'06-66-63-XX-51');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (101,32000,'RELUN','RELUN','Bâtiment Passerelle Sud',0,'06-84-96-XX-78');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (102,31770,'OUANES','OUANES','Prologue 1, la Pyrénéenne',0,'06-65-45-XX-37');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (103,33700,'ROUYARD','ROUYARD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (104,33700,'EDOH','EDOH',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (105,33700,'LY','LY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (106,33000,'PRATVIEL','PRATVIEL','75 Voie du Toec',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (107,33000,'LESBATS','LESBATS','5 avenue Maxwell',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (108,34300,'GUESTIN','GUESTIN','parc technologique de basso cambo 6 impasse paul Mesplé BP 1304',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (109,33000,'LE RASLE','LE RASLE','5 Esplanade Compans  Cafarelli',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (110,34400,'PAILLART','PAILLART','Passerelle Sud',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (111,33700,'DALOUS','DALOUS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (112,33700,'GAYRARD','GAYRARD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (113,31000,'CARNOY','CARNOY','20 rue sainte anne',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (114,32000,'DEMMER','DEMMER','Chemin de la Crabe',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (115,34000,'BATUT','BATUT',null,0,'06-64-16-XX-94');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (116,33700,'MANTEROLA','MANTEROLA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (117,34000,'SHUMMOGAM','SHUMMOGAM',null,0,'06-84-60-XX-05');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (118,34400,'MERCIER','MERCIER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (119,34000,'FAURE','FAURE',null,0,'06-71-90-XX-78');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (120,33700,'POITOU','POITOU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (121,33700,'MEJIA','MEJIA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (122,33700,'DUROCHER','DUROCHER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (123,33700,'FAYE','FAYE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (124,33700,'CHIKHI','CHIKHI',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (125,33700,'LEPLUS-HABENECK','LEPLUS-HABENECK',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (126,33000,'AGUIAR-PATERSON','AGUIAR-PATERSON','5 Avenue Albert Durand',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (127,33700,'AUTHESSERRE','AUTHESSERRE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (128,32100,'ARTHUIS','ARTHUIS','rue S.Allende',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (129,33700,'VAILLE','VAILLE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (130,33700,'MARCHAND','MARCHAND',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (131,33000,'PAQUIOT','PAQUIOT','94 96 quai de la Râpée',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (132,33700,'PEREZ','PEREZ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (133,33700,null,null,null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (134,33500,'NEIROTTI','NEIROTTI','place alphonse jourdain',0,'05-34-XX-70-70');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (135,33000,'BLANCHARD','BLANCHARD','5 avenue albert durand',0,'06-72-89-XX-60');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (136,32000,'ROSE','ROSE','BP 90103',0,'05-62-71-XX-84');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (137,34400,'CARRER','CARRER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (138,33000,'VERBIGUIE','VERBIGUIE','5 avenue albert durand',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (139,34000,'SIGOGNE','SIGOGNE',null,0,'05-62-71-XX-08');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (140,33000,'LOUGE','LOUGE','5 impasse henri pitot',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (141,31000,'PITUELLO','PITUELLO','16 rue du Soleil d''''OR',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (142,34000,'KABECHE','KABECHE',null,0,'06-82-49-XX-32');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (143,33170,'COSTES-DRUILHE','COSTES-DRUILHE','place alfonse jourdain',0,'05-34-50-XX-05');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (144,33000,'BETSCHER','BETSCHER','5, Avenue Albert Durand',0,'05-34-50-XX-00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (145,31000,'MERILHOU','MERILHOU','20-24 rue du Pont St Pierre',0,'619XX1710');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (146,34400,null,null,null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (147,31000,'LE MOING','LE MOING',' rue Paulin Talabot ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (148,31000,'RAVAT','RAVAT','4 rue brindejoncs des moulinais',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (149,66140,'HAYDER','HAYDER','rue salvador Allende',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (150,31000,'CADIOT','CADIOT','4 Rue Brindejoncs des Moulinais',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (151,31000,'Le Solenzara""','Le Solenzara""','300 Route Nationale 6',0,'66XX82546');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (152,33000,'PAILLART','PAILLART','5 av Marcel Dassault',0,'05 61 42 XX 77');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (153,33000,'VACARESSE','VACARESSE','5 av Marcel Dassault',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (154,32000,'DURAND','DURAND','Aeroport Toulouse-Blagnac',0,'05-34-30-XX-50');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (155,33000,'DI BENEDETTO','DI BENEDETTO','9 rue Paulin Talabot',0,'5621XX094');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (156,31000,'RIVIERE','RIVIERE','15 impasse de la Pélude',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (157,33000,'PERRIER','PERRIER','6,7 place jeanne d''''arc',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (158,31000,'BARKATI','BARKATI','4 rue brindejonc',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (159,31000,'ARQUÉ','ARQUÉ','1, Impasse Marcel Chalard - Technoparc de Basso Cambo - Batiment 2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (160,31000,'LACASSIN','LACASSIN','1, Impasse Marcel Chalard - Technoparc de Basso Cambo - Batiment 2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (161,33000,'BERNARD','BERNARD','9, rue Matabiau',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (162,34110,'BRETHOUS','BRETHOUS','Passerelle SUD-1er étage""',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (163,32000,'TRILLES','TRILLES','Buroparc 3 - Voie 2 La découverte',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (164,34000,'RIGAL','RIGAL','Place Anatole France',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (165,32300,'VILLERS','VILLERS','Université Toulouse 1, Place Anatole france',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (166,33000,'LEPILLEUR','LEPILLEUR','9 rue Paulin Talabot,',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (167,34170,'DUPUY','DUPUY','place alfonse jourdain',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (168,33000,'FINETTE-CONSTANTIN','FINETTE-CONSTANTIN','6 Avenue Albert DURAND',0,'5611XX757');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (169,31000,'MONGE','MONGE','18 BI rue de Villiers',0,'05 61 31 XX 97');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (170,33000,'ARTHUIS','ARTHUIS','64 rue la boetie',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (172,66000,'ADOLPHE','ADOLPHE',null,0,'5616XX988');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (173,32000,'DA COSTA','DA COSTA',null,0,'05 34 61 XX 80');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (174,34000,'BADAOUI','BADAOUI',null,0,'06 87 39 XX 64');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (175,32000,'TRAORÉ','TRAORÉ',null,0,'0');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (176,66000,'CAVAILLON','CAVAILLON',null,0,'44XX1860');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (177,66000,'GARRIGUE','GARRIGUE',null,0,'609XX0767');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (178,33700,'TREMOUILLERES','TREMOUILLERES',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (179,32000,'AGUIAR-PATERSON','AGUIAR-PATERSON',null,0,'05 61 12 XX 81');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (180,33700,'CUCULIERE','CUCULIERE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (181,33700,'MEUNIER','MEUNIER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (182,33700,'SIRVEN','SIRVEN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (183,33700,'SAHUN','SAHUN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (184,32000,'DETRUIT','DETRUIT','a',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (185,33700,'BONTEMPS','BONTEMPS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (186,33400,'RENE','RENE','PARC du MILLENAIRE    BAT C2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (187,34130,'LE MOING','LE MOING','place alphonse jourdain',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (188,32000,'TCHOUDJINOFF','TCHOUDJINOFF','Avenue de L''''escadrille Normandie Niémen',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (189,33700,'CARRER','CARRER',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (192,33700,'ROSE','ROSE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (195,31000,'MAHE-KOLBE','MAHE-KOLBE',' rue Paulin Talabot""',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (196,31000,'NAKACHE','NAKACHE','31100 Toulouse ',0,'66271xx72');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (197,66000,'MIREBEAU','MIREBEAU',null,0,'614xx9410');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (198,32000,'COUPIN','COUPIN','Immeuble Le Solenzara ',0,'6722xx474');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (203,31000,'LARREY','LARREY','1 avenue André-Marie Ampère',0,'21269xx5905');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (204,31000,'GAYRARD','GAYRARD','20-24 rue du Pont St Pierre',1,'22464xx6573');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (205,33000,'VERBIGUIÉ','VERBIGUIÉ','5 avenue Marcel Dassault BP 103',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (207,33000,'MAUVAIS','MAUVAIS','5 Av. Maxwell',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (208,33000,'GALINIE','GALINIE','5 avenue Marcel Dassault',0,'557xx3936');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (210,31600,'AGUIAR-PATERSON','AGUIAR-PATERSON','Rue de la découverte',0,'534xx4350');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (211,32000,'NARAYANEN','NARAYANEN','avenue J Baylet',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (212,33000,'JANDRAU','JANDRAU','75 voie du Toec',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (213,33000,'TCHEUTCHOUA','TCHEUTCHOUA','75 Voie du Toec',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (214,32000,'HUANG','HUANG','Actiparc ',1,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (215,66250,'VIGUIER','VIGUIER','Passerelle Sud',0,'06 72 89 xx 25');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (216,31000,'ESCANDE','ESCANDE',' rue Paulin Talabot ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (217,31170,'ABADIE','ABADIE','qfvqv',0,'06-84-50-xx-91');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (218,31000,'ONOUFRIENKO','ONOUFRIENKO',' Boulevard de l’Embouchure',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (219,34000,'KOUPTSOVA','KOUPTSOVA',null,0,'06-63-63-xx-68');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (220,32500,'ADJOMAYI','ADJOMAYI','rue salvador Allende',0,'67998xx90');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (221,32000,'PICOLO','PICOLO','Immeuble la passerelle',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (222,66240,'CABAL','CABAL','sans',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (223,31000,'LATREILLE','LATREILLE','24 rue Théron de Montaugé',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (224,32000,'FONTANINI','FONTANINI','La Barigoude',0,'68496xx78');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (225,31130,'KABECHE','KABECHE','RUE LEON JOULIN',0,'66352xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (226,32500,'COSTES-DRUILHE','COSTES-DRUILHE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (227,32500,'AURY','AURY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (228,32500,'JUBERT','JUBERT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (229,32500,'VERAS','VERAS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (230,31770,'BENSOUSSAN','BENSOUSSAN',null,0,'66077xx71');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (231,33700,'DAUTREY','DAUTREY',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (232,32500,'RAVAT','RAVAT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (233,31770,'GODDE','GODDE',null,0,'68133xx12');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (234,32500,'LAGADU','LAGADU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (235,33700,'BOUCHARD','BOUCHARD',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (236,33700,'LEROUX','LEROUX',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (237,31000,'MOURCELY','MOURCELY','216 route de saint Simon',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (238,31000,'YAN','YAN','270 rue Léon Joulin',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (239,33700,'MANEZ','MANEZ',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (240,32000,'LOUPEC','LOUPEC','Immeuble Stratège - Bat A - rue Ampere - BP 77206',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (241,31000,'BOYRIVENT','BOYRIVENT','1, Impasse Chalard',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (242,31000,'KOTZABASSIAN','KOTZABASSIAN','1 impasse Marcel Chalard Technoparc Basso Cambo',0,'56580xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (243,31000,'CAZORLA','CAZORLA','1, impasse marcel chalard',0,'56580xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (244,31000,'BONACHE','BONACHE','1 impasse Marcel Chalard',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (245,32000,'GONARD','GONARD','europarc pichaury',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (246,32000,'LAABOUBI','LAABOUBI','avenue des apothicaire',0,'66939xx22');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (247,33700,'BOGDANOVA','BOGDANOVA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (248,66000,'LORENZO','LORENZO',null,0,'62079xx04');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (249,66000,'FRANCHINI','FRANCHINI',null,0,'56117xx07');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (250,32500,'MOUTAMALLE','MOUTAMALLE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (251,32800,'MAINVILLE','MAINVILLE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (252,34500,'Immeuble Le Solenzara','Immeuble Le Solenzara',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (254,34500,'MOUGENOT','MOUGENOT',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (255,34500,'OUKHELLOU','OUKHELLOU',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (256,34000,'CHOUKROUN','CHOUKROUN',null,0,'06 30 82 xx 68');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (257,34500,'MARA','MARA',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (258,34500,'IHONGUI MOUTENG','IHONGUI MOUTENG',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (259,34500,'NARAYANEN','NARAYANEN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (260,34500,'LEROUX','LEROUX',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (261,34500,'DE LANNURIEN','DE LANNURIEN',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (262,34500,'MAUVAIS','MAUVAIS',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (263,34500,'AGUIAR-PATERSON','AGUIAR-PATERSON',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (264,66000,'VIGUIER','VIGUIER',null,0,'56296xx00');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (265,31000,'IHONGUI MOUTENG','IHONGUI MOUTENG','300 route N6',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (266,32000,'EL MERNISSI','EL MERNISSI','nada',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (267,31000,'KOUPTSOVA','KOUPTSOVA',' Actiparc',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (268,34970,'CUCULIERE','CUCULIERE','Place Anatole France',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (269,66750,'YAN','YAN','sans',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (270,34110,'BRETHOUS','BRETHOUS','Rue de la découverte BP 20 ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (272,66000,'MONGE','MONGE',null,0,'619xx1710');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (273,32000,'LEPILLEUR','LEPILLEUR','Buroparc 2 – voie n°2',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (277,31000,'DURAND','DURAND','122, avenue Robert Schuman',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (278,31000,'ARNALOT','ARNALOT','2'''' rue théron de montaugé 31677 Labege Cedex',1,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (280,34000,'Jules','Jules',null,0,'05 61 12 xx 81');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (281,34500,'Robert','Robert',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (282,34400,'IRIS','IRIS','Rue de la découverte',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (283,32800,'ARQUE','ARQUE',null,0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (284,31000,'ONOUFRIENKO','ONOUFRIENKO','271 Avenue de Grande Bretagne',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (285,66000,'PENANHOAT','PENANHOAT',null,0,'62497xx51');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (286,32000,'DETRUIT','DETRUIT','Centre d’Affaires Offshore de Toulouse',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (287,34140,'BP 10 134""','BP 10 134""','Place Occitane',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (288,33000,'MENGUE NGUEMA','MENGUE NGUEMA','6 rue Roger Camboulives',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (289,31000,'TOUZANI','TOUZANI','18 av de l''''escadrille Normandie-Niemen ',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (290,32000,'BAH','BAH','Prologue 1, la Pyrénéenne',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (291,32600,'JANDRAU','JANDRAU','qfvqv',0,null);
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (292,66000,'ROHBAN','ROHBAN','Parc du Cabanis - 6 rue du Cabanis - BP 60130 -',0,'101010101');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (293,33000,'APETOFIA','APETOFIA','9, rue Paulin Talabot',0,'101010101');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (294,32000,'KONIAN','KONIAN','ASTEK SUD OUEST',0,'6813xx312');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (295,66320,'WENZEK','WENZEK','place alfonse jourdain',0,'06 84 50 xx 91');
Insert into CLIENT (IDCLI,CP,NOMCLI,EMAILCLI,ADRESSECLI,PREMIUMCLI,TELCLI) values (296,66750,'CORDOBA','CORDOBA','parc technologique de basso cambo 6 impasse paul Mesplé BP 1304',0,'05 61 99 xx 14');


-- -----------------------------------------------------------------------------
REM INSERTING into COMMANDE
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (1,'dep31',23,to_timestamp('03/01/20','DD/MM/RR HH24:MI:SSXFF'),2,to_timestamp('05/01/20','DD/MM/RR HH24:MI:SSXFF'),3);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (2,'dep32',214,to_timestamp('05/01/20','DD/MM/RR HH24:MI:SSXFF'),3,to_timestamp('11/01/20','DD/MM/RR HH24:MI:SSXFF'),3);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (3,'dep31',278,to_timestamp('05/01/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('06/01/20','DD/MM/RR HH24:MI:SSXFF'),2);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (4,'dep31',15,to_timestamp('05/01/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('06/01/20','DD/MM/RR HH24:MI:SSXFF'),1);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (5,'dep31',204,to_timestamp('07/01/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('09/01/20','DD/MM/RR HH24:MI:SSXFF'),1);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (6,'dep31',237,to_timestamp('07/01/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('09/01/20','DD/MM/RR HH24:MI:SSXFF'),2);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (7,'dep31',373,to_timestamp('09/01/20','DD/MM/RR HH24:MI:SSXFF'),4,to_timestamp('12/01/20','DD/MM/RR HH24:MI:SSXFF'),5);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (8,'dep31',533,to_timestamp('10/01/20','DD/MM/RR HH24:MI:SSXFF'),4,to_timestamp('13/01/20','DD/MM/RR HH24:MI:SSXFF'),5);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (9,'dep31',596,to_timestamp('11/01/20','DD/MM/RR HH24:MI:SSXFF'),4,to_timestamp('13/01/20','DD/MM/RR HH24:MI:SSXFF'),5);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (10,'dep31',402,to_timestamp('11/01/20','DD/MM/RR HH24:MI:SSXFF'),5,to_timestamp('13/01/20','DD/MM/RR HH24:MI:SSXFF'),6);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (11,'dep31',402,to_timestamp('15/01/20','DD/MM/RR HH24:MI:SSXFF'),3,to_timestamp('17/01/20','DD/MM/RR HH24:MI:SSXFF'),3);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (12,'dep31',278,to_timestamp('05/02/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('06/02/20','DD/MM/RR HH24:MI:SSXFF'),2);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (13,'dep31',15,to_timestamp('06/02/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('07/02/20','DD/MM/RR HH24:MI:SSXFF'),1);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (14,'dep31',204,to_timestamp('07/02/20','DD/MM/RR HH24:MI:SSXFF'),1,to_timestamp('08/02/20','DD/MM/RR HH24:MI:SSXFF'),1);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (15,'dep31',404,to_timestamp('08/02/20','DD/MM/RR HH24:MI:SSXFF'),5,to_timestamp('10/02/20','DD/MM/RR HH24:MI:SSXFF'),6);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (16,'dep31',417,to_timestamp('09/02/20','DD/MM/RR HH24:MI:SSXFF'),5,to_timestamp('11/02/20','DD/MM/RR HH24:MI:SSXFF'),6);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (17,'dep31',540,to_timestamp('09/02/20','DD/MM/RR HH24:MI:SSXFF'),5,to_timestamp('11/02/20','DD/MM/RR HH24:MI:SSXFF'),5);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (18,'dep31',559,to_timestamp('10/02/20','DD/MM/RR HH24:MI:SSXFF'),5,to_timestamp('12/02/20','DD/MM/RR HH24:MI:SSXFF'),7);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (19,'dep33',582,to_timestamp('03/01/20','DD/MM/RR HH24:MI:SSXFF'),3,to_timestamp('05/02/20','DD/MM/RR HH24:MI:SSXFF'),5);
Insert into COMMANDE (IDCOM,CODEDEPOT,IDCLI,DATECOM,PRIXLIVRAISON,DATELIV,COUTLIV) values (20,'dep33',134,to_timestamp('05/02/20','DD/MM/RR HH24:MI:SSXFF'),3,to_timestamp('07/02/20','DD/MM/RR HH24:MI:SSXFF'),5);



-- -----------------------------------------------------------------------------
REM INSERTING into CONTENIR
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('appC',1,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('appC',19,2,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('appM',19,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('appV',1,35,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('appV',19,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',3,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',4,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',5,2,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',6,5,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',12,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',13,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bc',14,2,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bp',3,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bp',4,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bp',5,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bp',12,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bp',13,4,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('bp',14,3,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('can',19,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('canE',1,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('cse',11,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csf',10,1,1);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csf',11,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csf',17,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csf',18,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csh',7,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csr',7,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csr',8,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csr',9,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('csr',16,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('ep',1,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('moul',2,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('moul',19,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',3,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',4,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',5,2,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',6,2,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',7,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',8,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',9,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',15,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s1',17,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s2',7,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s2',8,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s2',10,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('s2',16,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skg',7,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skg',10,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skg',15,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skg',16,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skg',18,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skr',7,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('skr',8,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('sks',10,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('sks',17,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('th',3,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('th',4,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('th',6,1,0);
Insert into CONTENIR (REFART,IDCOM,QTECOM,QTERETOUR) values ('th',15,1,0);
