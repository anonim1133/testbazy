UPDATE "RachunekBankowy" SET data_zamkniecia=NOW() where exists (select * from (select id_rach from((select id_rach from "RachunekBankowy") AS Rach 
LEFT JOIN
(select * from "Transakcja" where data_wykonania > (NOW() - interval '1 year')) AS Trans ON Rach.id_rach=Trans.id_poc) 
WHERE id_poc IS NULL) AS Pom where "RachunekBankowy".id_rach=Pom.id_rach);

UPDATE "RachunekBankowy" SET typ_konta='zamkniete' where exists (select * from (select id_rach from((select id_rach from "RachunekBankowy") AS Rach 
LEFT JOIN
(select * from "Transakcja" where data_wykonania > (NOW() - interval '1 year')) AS Trans ON Rach.id_rach=Trans.id_poc) 
WHERE id_poc IS NULL) AS Pom where "RachunekBankowy".id_rach=Pom.id_rach);