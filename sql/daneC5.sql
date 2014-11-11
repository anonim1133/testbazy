delete from "KartaKredytowa" where exists (select * from 
(select * from "KartaKredytowa" where now()-interval '1 year' > data_wygasniecia) AS Pom where "KartaKredytowa".id_karta=Pom.id_karta)