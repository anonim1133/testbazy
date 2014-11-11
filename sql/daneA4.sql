delete from "Lokata" where exists (select * from
(select * from "Lokata" where data_zalozenia+(czas*30) > NOW() - interval '9 months') as Pom 
where "Lokata".id_lok=Pom.id_lok)