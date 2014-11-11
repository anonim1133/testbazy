UPDATE "RachunekBankowy" SET data_zamkniecia=NOW() where EXISTS ( select * from (
select id_rach5 from (select * from((select id_rach AS id_rach5 from "RachunekBankowy" where typ_konta='mlodziezowe') AS RachBank JOIN (select * from ((select * from "Uprawnienie") 
AS Upr3 JOIN (select * from(select id_klient, count(id_klient) AS lKont from((select id_klient, data_urodzenia from "Klient") AS Kl 
JOIN (select * from((select id_klienta, id_uprawnienie,id_rach AS id_rach2 from "Uprawnienie") AS Upr 
JOIN (select id_rach from "RachunekBankowy") AS Rach
ON Upr.id_rach2=Rach.id_rach)) AS UprRach
ON Kl.id_klient=UprRach.id_klienta) 
where NOW() - interval '18 years' > data_urodzenia group by id_klient) AS LiczbaKont where lKont > 1) AS KlientLKont
ON Upr3.id_klienta = KlientLKont.id_klient)) AS KlUprLiczba
ON RachBank.id_rach5=KlUprLiczba.id_rach) AS Mlodziezowe
LEFT JOIN
(select * from((select id_rach from "RachunekBankowy" where typ_konta='standard') AS RachBank JOIN (select * from ((select id_klienta AS id_klienta3, id_uprawnienie AS id_uprawnienie3, id_rach from "Uprawnienie") 
AS Upr3 JOIN (select * from(select id_klient, count(id_klient) AS lKont from((select id_klient, data_urodzenia from "Klient") AS Kl 
JOIN (select * from((select id_klienta AS id_klienta2, id_uprawnienie AS id_uprawnienie2 ,id_rach AS id_rach2 from "Uprawnienie") AS Upr 
JOIN (select id_rach from "RachunekBankowy") AS Rach
ON Upr.id_rach2=Rach.id_rach)) AS UprRach
ON Kl.id_klient=UprRach.id_klienta2) 
where NOW() - interval '18 years' > data_urodzenia group by id_klient) AS LiczbaKont where lKont > 1) AS KlientLKont
ON Upr3.id_klienta3 = KlientLKont.id_klient)) AS KlUprLiczba
ON RachBank.id_rach=KlUprLiczba.id_rach) AS Standard2)AS Standard
ON Mlodziezowe.id_klienta=Standard.id_klienta3) AS Wynik where id_klienta3 is not null ) AS Wynik where "RachunekBankowy".id_rach=Wynik.id_rach5);

UPDATE "RachunekBankowy" SET typ_konta='zamkniete' where EXISTS ( select * from (
select id_rach5 from (select * from((select id_rach AS id_rach5 from "RachunekBankowy" where typ_konta='mlodziezowe') AS RachBank JOIN (select * from ((select * from "Uprawnienie") 
AS Upr3 JOIN (select * from(select id_klient, count(id_klient) AS lKont from((select id_klient, data_urodzenia from "Klient") AS Kl 
JOIN (select * from((select id_klienta, id_uprawnienie,id_rach AS id_rach2 from "Uprawnienie") AS Upr 
JOIN (select id_rach from "RachunekBankowy") AS Rach
ON Upr.id_rach2=Rach.id_rach)) AS UprRach
ON Kl.id_klient=UprRach.id_klienta) 
where NOW() - interval '18 years' > data_urodzenia group by id_klient) AS LiczbaKont where lKont > 1) AS KlientLKont
ON Upr3.id_klienta = KlientLKont.id_klient)) AS KlUprLiczba
ON RachBank.id_rach5=KlUprLiczba.id_rach) AS Mlodziezowe
LEFT JOIN
(select * from((select id_rach from "RachunekBankowy" where typ_konta='standard') AS RachBank JOIN (select * from ((select id_klienta AS id_klienta3, id_uprawnienie AS id_uprawnienie3, id_rach from "Uprawnienie") 
AS Upr3 JOIN (select * from(select id_klient, count(id_klient) AS lKont from((select id_klient, data_urodzenia from "Klient") AS Kl 
JOIN (select * from((select id_klienta AS id_klienta2, id_uprawnienie AS id_uprawnienie2 ,id_rach AS id_rach2 from "Uprawnienie") AS Upr 
JOIN (select id_rach from "RachunekBankowy") AS Rach
ON Upr.id_rach2=Rach.id_rach)) AS UprRach
ON Kl.id_klient=UprRach.id_klienta2) 
where NOW() - interval '18 years' > data_urodzenia group by id_klient) AS LiczbaKont where lKont > 1) AS KlientLKont
ON Upr3.id_klienta3 = KlientLKont.id_klient)) AS KlUprLiczba
ON RachBank.id_rach=KlUprLiczba.id_rach) AS Standard2)AS Standard
ON Mlodziezowe.id_klienta=Standard.id_klienta3) AS Wynik where id_klienta3 is not null ) AS Wynik where "RachunekBankowy".id_rach=Wynik.id_rach5);