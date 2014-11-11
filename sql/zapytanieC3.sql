select * from((select * from "KartaKredytowa") AS Kr2 
JOIN (select id_uprawnienie from((select * from "Uprawnienie") AS Upr2 
JOIN (select * from (select id_klienta, count(id_klienta) AS liczba from((select * from "KartaKredytowa") AS Karta
JOIN (select id_uprawnienie,id_klienta from "Uprawnienie") AS Upr 
ON Karta.id_upraw=Upr.id_uprawnienie) group by id_klienta )AS Kl where liczba=1) AS Pom
ON Upr2.id_klienta=Pom.id_klienta) AS Pom2) AS Pom3
ON Kr2.id_upraw=Pom3.id_uprawnienie) where data_wygasniecia > NOW()-interval '12 months'