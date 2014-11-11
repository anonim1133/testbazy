select * from((select * from "Klient") AS Kl 
JOIN(select id_klienta from((select * from "Uprawnienie")AS Upr 
JOIN (select id_rach from "RachunekBankowy" AS RachBank 
LEFT JOIN (select id_rach AS id_rach_pom from (select DISTINCT(id_rach) from (select id_lok,id_rach from "Lokata") AS L1 
JOIN (Select id_kred,id_rach as id_rach2 from "Kredyt") AS K1 ON L1.id_rach=K1.id_rach2) AS POM) AS KLEJ 
ON KLEJ.id_rach_pom = RachBank.id_rach WHERE KLEJ.id_rach_pom IS NULL) AS Rach ON Upr.id_rach=Rach.id_rach)) AS UprRach ON Kl.id_klient=UprRach.id_klienta)