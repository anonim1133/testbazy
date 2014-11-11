select id_klienta, avg(wartosc::numeric) from (select * from((select * from ((select * from "Uprawnienie") AS Upr 
JOIN (select * from "Depozyt") AS Dep 
ON Upr.id_uprawnienie=Dep.id_upraw)) AS UprDep
LEFT JOIN (select id_rach AS rach from "Kredyt") AS Kr
ON UprDep.id_rach=Kr.rach) where rach is null) AS Pom group by id_klienta