/*
 PAYS (PAYSNUM, PAYSNOM)
AEROPORT(AERONUM, PAYSNUM*, AERONOM, AEROTAXE)
VOL (VOLNUM, AERONUM_ARRIVEE_VOL*, AERONUM_DEPART_VOL*,
H_DEPART, H_ARRIVEE, VOLNBPLACES)
COMPAGNIE (COMPNUM, COMPNOM)
OPERER (VOLNUM*, COMPNUM*, ANNEE_OPERER, OPETARIFCOUPON, OPETARIFKGSUPP)
OCCURRENCE_VOL(OCCNUM, VOLNUM*, OCCDATE,OCCETAT)
TRAJET(TRANUM, AERONUM_DEPART*, AERONUM_ARRIVEE*, TRANOM)
COUTER (TRANUM*, ANNEE_TARIF, TRATARIFBILLET, TRANBKGBAG, TRATARIFKGSUP)
CONSTITUER (TRANUM*, VOLNUM*, NUMORDRE, JOURPLUS)
CLIENT (CLINUM, CLINOM, CLITEL, CLIADRESSE)
BILLET (BILLNUM, CLINUM*, TRANUM*, BILLDATEACHAT, BILLDATEDEPART, BILLETAT)
COUPON_VOL (COUPNUM, OCCNUM*, BILLNUM*, COUPETAT)
BAGAGE (BAGNUM, BILLNUM*, BAGKG)
CONTAINER (CONTNUM, OCCNUM_PROVENIR*, OCCNUM_DESTINER*, CONTPOIDSMAX)
AFFECTER(BAGNUM*, CONTNUM*)
 */

/*
 B1 : Afficher chaque billet de monsieur Ravat en précisant pour chacun son numéro et la date de
départ.
B1’ : Afficher chaque billet de monsieur Ravat en précisant pour chacun son numéro, la date de départ,
la ville d’arrivée et le pays d’arrivée.
B1’’ : Afficher chaque billet de monsieur Ravat en précisant pour chacun son numéro, la date de
départ, la ville de départ, le pays de départ, la ville d’arrivée et le pays d’arrivée.
B1’’’ : Afficher chaque billet de monsieur Ravat en précisant pour chacun son numéro, la date de
départ et le nombre de jours entre la date d’achat du billet et la date de départ du billet.
 */

/* B1 */
SELECT CLIENT.CLINUM, BILLET.BILLDATEDEPART
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
WHERE CLIENT.CLINOM LIKE 'RAVAT';

/* B1' */
SELECT CLIENT.CLINUM, BILLET.BILLDATEDEPART, PAYS.PAYSNOM
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
         JOIN TRAJET ON BILLET.TRANUM = TRAJET.TRANUM
         JOIN PAYS ON TRAJET.AERONUM_ARRIVEE = PAYS.PAYSNUM
WHERE CLIENT.CLINOM LIKE 'RAVAT';

/* B1'' */
SELECT CLIENT.CLINUM, BILLET.BILLDATEDEPART, PAYS.PAYSNOM, dest.PAYSNOM
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
         JOIN TRAJET ON BILLET.TRANUM = TRAJET.TRANUM
         JOIN PAYS ON TRAJET.AERONUM_ARRIVEE = PAYS.PAYSNUM
         JOIN PAYS dest ON TRAJET.AERONUM_DEPART = dest.PAYSNUM
WHERE CLIENT.CLINOM LIKE 'RAVAT';

/* B1''' */
SELECT CLIENT.CLINUM, BILLET.BILLDATEDEPART, (BILLET.BILLDATEDEPART - BILLET.BILLDATEACHAT) diff_temps
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
WHERE CLIENT.CLINOM LIKE 'RAVAT';

/*
 Exécuter les requêtes suivantes et commenter :
Select sysdate from dual ;
Select to_char(sysdate,'dd/mm/yy hh:mi') from dual;
Select to_char(sysdate + 1,'dd/mm/yy hh:mi') from dual;
Select to_char(sysdate + (1/24),'dd/mm/yy hh:mi') from dual;
 */

Select sysdate
from dual;


Select to_char(sysdate, 'dd/mm/yy hh:mi')
from dual;

Select to_char(sysdate + 1, 'dd/mm/yy hh:mi')
from dual;

Select to_char(sysdate + (1 / 24), 'dd/mm/yy hh:mi')
from dual;

/*
B2 : Afficher la liste des billets achetés le 28/10/2019.
10
B2’ : Afficher la liste des billets achetés en octobre toute années confondues.
B2’’ : Afficher la liste des billets achetés en octobre 2019.
B3 : Afficher la liste des billets comportant au moins un bagage.
B4 : Afficher les billets achetés en dernière minute, c’est-à-dire achetés la veille du départ. Préciser
pour chacun de ces billet son numéro, la date de départ et le nom du propriétaire.
B5 : Afficher pour chaque billet, le numéro de l’occurrence de vol pour laquelle le billet dispose d’un
coupon de vol et dont la date correspond à la date de départ du billet.
B6 : Y a-t-il des trajets pour lesquels l’aéroport de départ du vol n+1 est différent de l’aéroport
d’arrivée du vol n ?
B7 : Afficher pour chaque trajet la liste des aéroports de destination (pays, ville) des vols le constituant,
en présentant ces aéroports dans l’ordre du trajet.
B8 : Afficher la liste des compagnies ayant opéré des vols sur lesquels M. Ravat a eu un coupon de vol.
B9 : Afficher la liste des compagnies ayant opéré des vols constituant les trajets sur lesquels M. Ravat
a acheté un billet.
*/

/* B2 */
SELECT *
FROM BILLET
WHERE BILLDATEACHAT = DATE '2019-10-28';


/* B2' */
SELECT *
FROM BILLET
WHERE EXTRACT(MONTH FROM BILLDATEACHAT) = 10;

/* B2'' */
SELECT *
FROM BILLET
WHERE EXTRACT(MONTH FROM BILLDATEACHAT) = 10
  AND EXTRACT(YEAR FROM BILLDATEACHAT) = 2019;

/* B3' */
SELECT BAGAGE.BILLNUM, COUNT(BAGAGE.BILLNUM)
FROM BILLET
         JOIN BAGAGE ON BILLET.BILLNUM = BAGAGE.BILLNUM
GROUP BY BAGAGE.BILLNUM;

/* B4 */
SELECT BILLET.BILLNUM, BILLET.BILLDATEACHAT, CLIENT.CLINOM
FROM BILLET
         JOIN CLIENT ON CLIENT.CLINUM = BILLET.CLINUM
WHERE BILLET.BILLDATEDEPART - BILLET.BILLDATEACHAT <= 1;

/* B5 */
SELECT BILLET.BILLNUM
FROM BILLET
         JOIN CLIENT ON CLIENT.CLINUM = BILLET.CLINUM
WHERE BILLET.BILLDATEDEPART - BILLET.BILLDATEACHAT = 0;

/* B6 */
SELECT *
FROM (SELECT TRANUM,
             AERONUM_DEPART,
             AERONUM_ARRIVEE,
             LEAD(AERONUM_DEPART) OVER (ORDER BY TRANUM) AS DEPART_VOL_SUIVANT
      FROM TRAJET) t
WHERE t.AERONUM_ARRIVEE != t.DEPART_VOL_SUIVANT;

/* B7 */
SELECT TRAJET.TRANUM, PAYS.PAYSNOM, AEROPORT.AERONOM
FROM TRAJET
         JOIN CONSTITUER ON TRAJET.TRANUM = CONSTITUER.TRANUM
         JOIN VOL ON CONSTITUER.VOLNUM = VOL.VOLNUM
         JOIN AEROPORT ON VOL.AERONUM_ARRIVEE_VOL = AEROPORT.AERONUM
         JOIN PAYS ON AEROPORT.PAYSNUM = PAYS.PAYSNUM
ORDER BY TRAJET.TRANUM, CONSTITUER.NUMORDRE;

/* B8 */
SELECT DISTINCT COMPAGNIE.COMPNOM
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
         JOIN COUPON_VOL ON BILLET.BILLNUM = COUPON_VOL.BILLNUM
         JOIN OCCURRENCE_VOL ON COUPON_VOL.OCCNUM = OCCURRENCE_VOL.OCCNUM
         JOIN VOL ON OCCURRENCE_VOL.VOLNUM = VOL.VOLNUM
         JOIN OPERER ON VOL.VOLNUM = OPERER.VOLNUM
         JOIN COMPAGNIE ON OPERER.COMPNUM = COMPAGNIE.COMPNUM
WHERE CLIENT.CLINOM LIKE 'RAVAT';

/* B9 */
SELECT DISTINCT COMPAGNIE.COMPNOM
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
         JOIN TRAJET ON BILLET.TRANUM = TRAJET.TRANUM
         JOIN CONSTITUER ON TRAJET.TRANUM = CONSTITUER.TRANUM
         JOIN VOL ON CONSTITUER.VOLNUM = VOL.VOLNUM
         JOIN OPERER ON VOL.VOLNUM = OPERER.VOLNUM
         JOIN COMPAGNIE ON OPERER.COMPNUM = COMPAGNIE.COMPNUM
WHERE CLIENT.CLINOM LIKE 'RAVAT';

/*
 Q1 :
M. Ravat a-t-il effectivement voyagé avec chacune des compagnies affichées en B8 & B9 ?
Peut-on corriger les requêtes B6 & B7 pour obtenir les compagnies avec lesquelles M. Ravat a
effectivement voyagé ?

-- M. Ravat n'as voyager qu'avec une seule compagnie 'Luftansa' pour B8 et B9 donc oui il a voyagé avec chacune des compagnies affichées en B8 & B9

B10 : Afficher la liste des trajets proposés en précisant pour chacun et année par année, la liste des
compagnies constituant ces trajets.
Trouve-t-on tous les trajets ? Si non, pourquoi ? Avez-vous une solution ?

 */

/* B10 */
SELECT TRAJET.TRANUM, OPERER.COMPNUM, OPERER.ANNEE_OPERER
FROM TRAJET
         JOIN CONSTITUER ON TRAJET.TRANUM = CONSTITUER.TRANUM
         JOIN VOL ON CONSTITUER.VOLNUM = VOL.VOLNUM
         JOIN OPERER ON VOL.VOLNUM = OPERER.VOLNUM
ORDER BY TRAJET.TRANUM, OPERER.ANNEE_OPERER;

SELECT t.tranum, o.compnum, o.annee_operer
FROM trajet t,
     constituer c,
     vol v,
     operer o
WHERE t.tranum = c.tranum
  AND c.volnum = v.volnum
  AND v.volnum = o.volnum
ORDER BY t.tranum, o.annee_operer;

-- Non, car il peut y avoir des trajets qui n'ont pas de vols (foreign key)
--     verification avec LEFT JOIN
SELECT TRAJET.TRANUM, OPERER.COMPNUM, OPERER.ANNEE_OPERER
FROM TRAJET
         LEFT JOIN CONSTITUER ON TRAJET.TRANUM = CONSTITUER.TRANUM
         LEFT JOIN VOL ON CONSTITUER.VOLNUM = VOL.VOLNUM
         LEFT JOIN OPERER ON VOL.VOLNUM = OPERER.VOLNUM
ORDER BY TRAJET.TRANUM, OPERER.ANNEE_OPERER;

/*
Requêtes : savoir lire du SQL
Donner la phrase qui correspond à chacune des requêtes suivantes. Si une requête comporte des
erreurs, proposer une correction de la requête et indiquer ce qu’elle fait.

1.1. Requête :
SELECT c.clinum, c.clinom
FROM client c;

-- affiche le num & nom de chaque clients

1.2. Requête :
SELECT c.clinum, c.clinom
FROM client c, billet b
WHERE c.clinum = b.clinum;

-- Affiche le num & nom de chaque clients ou un billet existe

1.3. Requête :
SELECT c.clinum, c.clinom
FROM client c, billet b, trajet t, aeroport a, pays p
WHERE c.clinum = b.clinum AND b.tranum = t.tranum AND t.aeronum_depart = a.aeronum AND
a.paysum = p.paysnum;

-- Affiche le num & nom de chaque clients ou un billet existe, as un trajet et un pays

1.4. Requête :
SELECT c.clinum, c.clinom
FROM client c, billet bi, enregistrer e, baggage ba
WHERE c.clinum = bi.clinum AND bi.billnum = e.billnum AND e.bagnum = ba.bagnum;

-- Affiche le num & nom de chaque clients ou un billet existe avec un bagage

*/

/*
 B11 : Afficher chaque billet en présentant pour chacun la liste des coupons de vol correspondants en
donnant ces coupons dans l’ordre des vols du trajet.
B11’ : Afficher chaque billet en présentant pour chacun la liste des coupons de vol correspondants en
donnant ces coupons dans l’ordre des vols du trajet. Précisez en plus les noms des aéroports d’arrivée
de chaque coupon.
B12 : Afficher chaque bagage affecté à un container destiné à un occurrence de vol pour laquelle le
billet associé au bagage possède effectivement un coupon de vol. Préciser le numéro du bagage, celui
du billet et le numéro du container affecté.
Cette requête retrouve-t-elle toutes les affectations de container à des bagages ? Si non, pourquoi et
comment peut-on caractériser les affectation manquantes ?
B13 : Afficher le tarif de chaque billet de M. Ravat
 */

/* B11 */
SELECT BILLET.BILLNUM, COUPON_VOL.COUPNUM
FROM BILLET
         JOIN COUPON_VOL ON BILLET.BILLNUM = COUPON_VOL.BILLNUM
ORDER BY COUPON_VOL.OCCNUM;

/* B11' */
SELECT BILLET.BILLNUM, COUPON_VOL.COUPNUM, AEROPORT.AERONOM
FROM BILLET
         JOIN COUPON_VOL ON BILLET.BILLNUM = COUPON_VOL.BILLNUM
         JOIN OCCURRENCE_VOL ON COUPON_VOL.OCCNUM = OCCURRENCE_VOL.OCCNUM
         JOIN VOL ON OCCURRENCE_VOL.VOLNUM = VOL.VOLNUM
         JOIN AEROPORT ON VOL.AERONUM_ARRIVEE_VOL = AEROPORT.AERONUM
ORDER BY COUPON_VOL.OCCNUM;

/* B12 */
SELECT BAGAGE.BAGNUM, BAGAGE.BILLNUM, AFFECTER.CONTNUM
FROM BAGAGE
         JOIN AFFECTER ON BAGAGE.BAGNUM = AFFECTER.BAGNUM
         JOIN CONTAINER ON AFFECTER.CONTNUM = CONTAINER.CONTNUM
         JOIN OCCURRENCE_VOL ON CONTAINER.OCCNUM_DESTINER = OCCURRENCE_VOL.OCCNUM
         JOIN COUPON_VOL ON OCCURRENCE_VOL.OCCNUM = COUPON_VOL.OCCNUM
         JOIN BILLET ON COUPON_VOL.BILLNUM = BAGAGE.BILLNUM;

-- Non, car il peut y avoir des bagages qui n'ont pas de container (foreign key)

/* B13 */
SELECT BILLET.BILLNUM, SUM(COUTER.TRATARIFBILLET)
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
         JOIN COUTER ON BILLET.TRANUM = COUTER.TRANUM
WHERE CLIENT.CLINOM LIKE 'RAVAT'
GROUP BY BILLET.BILLNUM;

/*
 B14 : Afficher tous les bagages.
B14’ : Afficher poids total de tous les bagages qui ont été transportés.
B14’’ : Afficher tous les bagages qui ont été transportés, triés par billet.
B14’’’ : Afficher poids total de tous les bagages qui ont été enregistrés par billet.
B14’’’’ : Afficher poids total de tous les bagages qui ont été transportés par trajet.
B14’’’’’ : Afficher tous les trajets qui ont transporté plus de 40kg de bagage en précisant ce poids total.
B14’’’’’ : Afficher tous les trajets qui ont transporté plus de 40kg de bagage sans préciser ce poids
total.
B15 : Afficher le montant total payé par M. Ravat pour son billet n°1.
B16 : Afficher le montant total payé par M. Ravat pour chacun de ses billets, triés par date.
B17 : Afficher le nombre de coupons émis par billet.
B18 : Afficher le nombre de vol constituant chaque vol.
B19 : Afficher le CA réalisé au total par AéroFrance par trajet.

 */

/* B14 */
SELECT *
FROM BAGAGE;

/* B14' */
SELECT SUM(BAGAGE.BAGKG) AS POIDS_TOTAL
FROM BAGAGE;

/* B14'' */
SELECT BAGAGE.BAGNUM, BAGAGE.BILLNUM, BAGAGE.BAGKG
FROM BAGAGE
ORDER BY BAGAGE.BILLNUM;

/* B14''' */
SELECT BAGAGE.BILLNUM, SUM(BAGAGE.BAGKG) AS POIDS_TOTAL
FROM BAGAGE
GROUP BY BAGAGE.BILLNUM;

/* B14'''' */
SELECT TRAJET.TRANUM, SUM(BAGAGE.BAGKG) AS POIDS_TOTAL
FROM BAGAGE
         JOIN BILLET ON BAGAGE.BILLNUM = BILLET.BILLNUM
         JOIN TRAJET ON BILLET.TRANUM = TRAJET.TRANUM
GROUP BY TRAJET.TRANUM;

/* B14''''' */
SELECT TRAJET.TRANUM, SUM(BAGAGE.BAGKG) AS POIDS_TOTAL
FROM BAGAGE
         JOIN BILLET ON BAGAGE.BILLNUM = BILLET.BILLNUM
         JOIN TRAJET ON BILLET.TRANUM = TRAJET.TRANUM
GROUP BY TRAJET.TRANUM
HAVING SUM(BAGAGE.BAGKG) > 40;

/* B14'''''' */
SELECT TRAJET.TRANUM
FROM BAGAGE
         JOIN BILLET ON BAGAGE.BILLNUM = BILLET.BILLNUM
         JOIN TRAJET ON BILLET.TRANUM = TRAJET.TRANUM
GROUP BY TRAJET.TRANUM
HAVING SUM(BAGAGE.BAGKG) > 40;

/* B15 */
SELECT SUM(COUTER.TRATARIFBILLET) AS MONTANT_TOTAL
FROM CLIENT
         JOIN BILLET ON CLIENT.CLINUM = BILLET.CLINUM
         JOIN COUTER ON BILLET.TRANUM = COUTER.TRANUM
WHERE CLIENT.CLINOM LIKE 'RAVAT'
  AND BILLET.BILLNUM = 1;

/*
 Requêtes : savoir lire du SQL
Donner la phrase qui correspond à chacune des requêtes suivantes. Si une requête comporte des
erreurs, proposer une correction de la requête et indiquer ce qu’elle fait.

2.1 Requête :
SELECT c.contnum, ov.occnum
FROM container c, occurrence_vol ov
WHERE c.occnum_destiner = ov.occnum;

-- Affiche le num du container et de l'occurrence de vol ou le container est destiné à cette occurrence de vol

2.2 Requête :
SELECT c.contnum, ov.occnum
FROM container c, occurrence_vol ov
WHERE c.occnum_provenir = ov.occnum;

-- Affiche le num du container et de l'occurrence de vol ou le container provient de cette occurrence de vol

2.3 Requête :
SELECT c.contnum, ov.occnum
FROM container c, occurrence_vol ov
WHERE c.occnum_destiner = ov.occnum AND c.occnum_provenir = ov.occnum;

-- Affiche le num du container et de l'occurrence de vol ou le container est destiné et provient de cette occurrence de vol (impossible)

2.4 Requête :
SELECT c.contnum, ovp.occnum, ovd.occnum
FROM container c, occurrence_vol ovp, occurrenc_vol ovd
WHERE c.occnum_destiner = ovp.occnum AND c.occnum_provenir = ovd.occnum;

-- Affiche le num du container, de l'occurrence de vol ou le container est destiné à cette occurrence de vol et de l'occurrence de vol ou le container provient de cette occurrence de vol

2.5 Requête :
SELECT v.volnum
FROM vol v, aeroport a
WHERE v.aeroport_depart_vol = a.aeronum AND v.aeroport_arrivee_vol = a.aeronum

-- Affiche le num du vol ou l'aéroport de départ est le même que l'aéroport d'arrivée

2.6 Requête :
SELECT DISTINCT t.tranum
FROM trajet t, constituer c1, constituer c2, constituer c3, vol v1, vol v2, vol v3
WHERE t.tranum = c1.tranum AND t.tranum = c2.tranum AND t.tranum = c3.tranum
AND c1.volnum = v1.volnum AND c1.numorbre = 1
AND c2.volnum = v2.volnum AND c2.numorbre = 2
AND c3.volnum = v3.volnum AND c3.numorbre = 3;

-- Affiche le num du trajet qui comporte au moins 3 vols

2.7 Requête :
SELECT t.tranum
FROM trajet t, constituer c
WHERE t.tranum = c.tranum AND c.numorbre = 3;

-- Affiche le num du trajet qui comporte un vol en 3ème position

2.8 Requête :
SELECT t.tranum
FROM trajet t, constituer c
WHERE t.tranum = c.tranum
GROUP BY t.tranum
HAVING COUNT(*) = 3;

-- Affiche le num du trajet qui comporte exactement 3 vols

 */