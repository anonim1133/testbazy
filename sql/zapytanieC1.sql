select DISTINCT(id_klient), imie, nazwisko, pesel, data_urodzenia, nr_telefonu from((select * from "Klient") AS Kl 
JOIN (select id_klienta, id_rach, id_bank, id_bank2,rach_pom from ((select id_kred, id_rach, id_klienta,id_bank from 
 ((select * from((select id_uprawnienie,id_klienta,id_rach AS rach from "Uprawnienie" group by id_klienta, id_uprawnienie) AS Upr 
JOIN (select id_upraw,id_bank from "Depozyt") AS Dep ON Upr.id_uprawnienie=Dep.id_upraw) AS UprDep) AS UprDep2
LEFT JOIN (select * from "Kredyt") AS Kred ON UprDep2.rach=Kred.id_rach)) AS Klej 
LEFT JOIN (select id_rach AS rach_pom, id_bank AS id_bank2 from "RachunekBankowy") AS RachBank
ON RachBank.rach_pom=Klej.id_rach) where id_bank !=id_bank2) AS Calosc ON Kl.id_klient=id_klienta) 
 

