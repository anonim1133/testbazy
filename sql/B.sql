select id_trans, id_poc,id_cel,kwota_transakcji, data_wykonania from("Transakcja" as Trans 
JOIN "RachunekBankowy" AS rach1 on Trans.id_poc=rach1.id_rach ) as TransRach 
JOIN "RachunekBankowy" AS rach2 on TransRach.id_cel=rach2.id_rach where TransRach.id_bank<>rach2.id_bank AND kwota_transakcji::numeric > (SELECT AVG(kwota_transakcji::numeric) FROM "Transakcja") ;
KONIEC
select avg(kwota_kredytu::numeric) from ( (SELECT id_kred, id_rach, kwota_kredytu FROM "Kredyt") AS Kredyty 
LEFT JOIN (SELECT id_rach as id_rachunku from ((SELECT * FROM "Uprawnienie") AS Upr 
LEFT JOIN (SELECT * FROM "Depozyt") as Dep ON Upr.id_uprawnienie=Dep.id_upraw) where id_upraw is null )  AS Rach
 ON Kredyty.id_rach=Rach.id_rachunku) where id_rachunku is not null
KONIEC
SELECT id_bank, SUM(kwota_lokaty) FROM ((SELECT id_rach, kwota_lokaty FROM "Lokata" ) AS Lok 
JOIN (SELECT id_rach, id_bank FROM "RachunekBankowy" ) AS Rach ON Lok.id_rach=Rach.id_rach) group by id_bank
KONIEC
select * from("Klient" AS Kl JOIN (select * from (select id_klienta from
(select id_klienta, COUNT(DISTINCT(id_bank)) AS Banki
FROM ("Uprawnienie" as Upr
JOIN "RachunekBankowy" as Rach on Upr.id_rach=Rach.id_rach) JOIN "Kredyt" as Kred on Rach.id_rach=Kred.id_rach
group by id_klienta) as Klienci where Klienci.Banki>1) as KlientBanku) as Klienci on Kl.id_klient=Klienci.id_klienta )
KONIEC
select sum(kwota_kredytu), Rach.id_rach, Ban.id_bank, Kl.id_klient from "Bank" AS Ban, "RachunekBankowy" AS Rach, "Kredyt" As Kred, 
"Klient" as Kl, "Uprawnienie" as Upr 
where Ban.id_bank=Rach.id_bank AND Rach.id_rach=Kred.id_rach AND Kl.id_klient=Upr.id_klienta AND Upr.id_rach=Rach.id_rach
Group by Rach.id_rach, Ban.id_bank, Kl.id_klient ORDER BY id_klient
