select * from((select * from "Klient") AS Kl JOIN (select id_klienta, avg(kwota_zlecenia::numeric) from ((select * from "Uprawnienie" ) AS Upr 
JOIN (select * from "Zlecenie_stale") AS Zlec 
ON Upr.id_rach=Zlec.id_rach) group by id_klienta) AS ZlSrednia
ON Kl.id_klient=ZlSrednia.id_klienta)