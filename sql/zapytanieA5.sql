SELECT * FROM ("Klient" AS Klienci JOIN (SELECT id_klienta, sum(kwota_kredytu) AS Suma FROM("Kredyt" AS Kr 
JOIN (select * from("RachunekBankowy" AS Rach 
JOIN (select id_klienta,id_rach as klej from "Uprawnienie" AS Upr 
WHERE NOT EXISTS (select id_upraw from "Depozyt" where id_upraw=Upr.id_uprawnienie) )AS UprBez 
ON UprBez.klej=Rach.id_rach)) AS Rachunki 
ON Kr.id_rach=Rachunki.id_rach) GROUP BY Rachunki.id_klienta) AS Kredyty 
ON Klienci.id_klient=Kredyty.id_klienta)