select * from((select * from "Klient") AS Kl2 
JOIN(select id_klienta,count(id_bank) as LiczbaBank from ((select * from "Uprawnienie") AS Upr
JOIN (select * from "Depozyt") AS Dep
ON Upr.id_uprawnienie=Dep.id_upraw) group by id_klienta) AS KlDep
ON Kl2.id_klient=KlDep.id_klienta) where LiczbaBank =1
