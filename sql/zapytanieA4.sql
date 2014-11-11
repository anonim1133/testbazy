select * from("Klient" AS Kl JOIN (select * from (select id_klienta from
(select id_klienta, COUNT(DISTINCT(id_bank)) AS Banki 
from ("Uprawnienie" As Upr 
JOIN "Depozyt" as Dep on Upr.id_uprawnienie=Dep.id_upraw) 
group by id_klienta)AS Klienci where Klienci.Banki>1) AS KliBank) AS Klienci ON Kl.id_klient=Klienci.id_klienta )