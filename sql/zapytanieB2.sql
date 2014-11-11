select avg(kwota_kredytu::numeric) from ( (SELECT id_kred, id_rach, kwota_kredytu FROM "Kredyt") AS Kredyty 
LEFT JOIN (SELECT id_rach as id_rachunku from ((SELECT * FROM "Uprawnienie") AS Upr 
LEFT JOIN (SELECT * FROM "Depozyt") as Dep ON Upr.id_uprawnienie=Dep.id_upraw) where id_upraw is null )  AS Rach
 ON Kredyty.id_rach=Rach.id_rachunku) where id_rachunku is not null