select id_trans, id_poc,id_cel,kwota_transakcji, data_wykonania from("Transakcja" as Trans 
JOIN "RachunekBankowy" AS rach1 on Trans.id_poc=rach1.id_rach ) as TransRach 
JOIN "RachunekBankowy" AS rach2 on TransRach.id_cel=rach2.id_rach where TransRach.id_bank=rach2.id_bank;
KONIEC
select AVG(kwota_transakcji::numeric)::money from ("Transakcja" as Trans 
JOIN "RachunekBankowy" AS rach1 
on Trans.id_poc=rach1.id_rach ) as TransRach 
JOIN "RachunekBankowy" AS rach2 on TransRach.id_cel=rach2.id_rach 
where TransRach.id_bank<>rach2.id_bank;
KONIEC
select * from((select * from "Klient") AS Kl 
JOIN(select id_klienta from((select * from "Uprawnienie")AS Upr 
JOIN (select id_rach from "RachunekBankowy" AS RachBank 
LEFT JOIN (select id_rach AS id_rach_pom from (select DISTINCT(id_rach) from (select id_lok,id_rach from "Lokata") AS L1 
JOIN (Select id_kred,id_rach as id_rach2 from "Kredyt") AS K1 ON L1.id_rach=K1.id_rach2) AS POM) AS KLEJ 
ON KLEJ.id_rach_pom = RachBank.id_rach WHERE KLEJ.id_rach_pom IS NULL) AS Rach ON Upr.id_rach=Rach.id_rach)) AS UprRach ON Kl.id_klient=UprRach.id_klienta)
KONIEC
select * from("Klient" AS Kl JOIN (select * from (select id_klienta from
(select id_klienta, COUNT(DISTINCT(id_bank)) AS Banki 
from ("Uprawnienie" As Upr 
JOIN "Depozyt" as Dep on Upr.id_uprawnienie=Dep.id_upraw) 
group by id_klienta)AS Klienci where Klienci.Banki>1) AS KliBank) AS Klienci ON Kl.id_klient=Klienci.id_klienta )
KONIEC
SELECT * FROM ("Klient" AS Klienci JOIN (SELECT id_klienta, sum(kwota_kredytu) AS Suma FROM("Kredyt" AS Kr 
JOIN (select * from("RachunekBankowy" AS Rach 
JOIN (select id_klienta,id_rach as klej from "Uprawnienie" AS Upr 
WHERE NOT EXISTS (select id_upraw from "Depozyt" where id_upraw=Upr.id_uprawnienie) )AS UprBez 
ON UprBez.klej=Rach.id_rach)) AS Rachunki 
ON Kr.id_rach=Rachunki.id_rach) GROUP BY Rachunki.id_klienta) AS Kredyty 
ON Klienci.id_klient=Kredyty.id_klienta)
