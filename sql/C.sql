select DISTINCT(id_klient), imie, nazwisko, pesel, data_urodzenia, nr_telefonu from((select * from "Klient") AS Kl 
JOIN (select id_klienta, id_rach, id_bank, id_bank2,rach_pom from ((select id_kred, id_rach, id_klienta,id_bank from 
 ((select * from((select id_uprawnienie,id_klienta,id_rach AS rach from "Uprawnienie" group by id_klienta, id_uprawnienie) AS Upr 
JOIN (select id_upraw,id_bank from "Depozyt") AS Dep ON Upr.id_uprawnienie=Dep.id_upraw) AS UprDep) AS UprDep2
LEFT JOIN (select * from "Kredyt") AS Kred ON UprDep2.rach=Kred.id_rach)) AS Klej 
LEFT JOIN (select id_rach AS rach_pom, id_bank AS id_bank2 from "RachunekBankowy") AS RachBank
ON RachBank.rach_pom=Klej.id_rach) where id_bank !=id_bank2) AS Calosc ON Kl.id_klient=id_klienta)
KONIEC
select * from((select * from "Klient") AS Kl JOIN (select id_klienta, avg(kwota_zlecenia::numeric) from ((select * from "Uprawnienie" ) AS Upr 
JOIN (select * from "Zlecenie_stale") AS Zlec 
ON Upr.id_rach=Zlec.id_rach) group by id_klienta) AS ZlSrednia
ON Kl.id_klient=ZlSrednia.id_klienta)
KONIEC
select * from((select * from "KartaKredytowa") AS Kr2 
JOIN (select id_uprawnienie from((select * from "Uprawnienie") AS Upr2 
JOIN (select * from (select id_klienta, count(id_klienta) AS liczba from((select * from "KartaKredytowa") AS Karta
JOIN (select id_uprawnienie,id_klienta from "Uprawnienie") AS Upr 
ON Karta.id_upraw=Upr.id_uprawnienie) group by id_klienta )AS Kl where liczba=1) AS Pom
ON Upr2.id_klienta=Pom.id_klienta) AS Pom2) AS Pom3
ON Kr2.id_upraw=Pom3.id_uprawnienie) where data_wygasniecia > NOW()-interval '12 months'
KONIEC
select * from((select * from "Klient") AS Kl2 
JOIN(select id_klienta,count(id_bank) as LiczbaBank from ((select * from "Uprawnienie") AS Upr
JOIN (select * from "Depozyt") AS Dep
ON Upr.id_uprawnienie=Dep.id_upraw) group by id_klienta) AS KlDep
ON Kl2.id_klient=KlDep.id_klienta) where LiczbaBank =1
KONIEC
select id_klienta, avg(wartosc::numeric) from (select * from((select * from ((select * from "Uprawnienie") AS Upr 
JOIN (select * from "Depozyt") AS Dep 
ON Upr.id_uprawnienie=Dep.id_upraw)) AS UprDep
LEFT JOIN (select id_rach AS rach from "Kredyt") AS Kr
ON UprDep.id_rach=Kr.rach) where rach is null) AS Pom group by id_klienta
