INSERT INTO public."Uprawnienie"  (id_klienta, id_rach, typ)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 100000)
SELECT 
(random() * (select max(id_klient) - min(id_klient) from public."Klient"  ))::int + (select min(id_klient) from public."Klient"  ) id_klienta,
(random() * ((select id_rach from "RachunekBankowy" group by id_rach order by id_rach desc limit 1)-(select id_rach from "RachunekBankowy" where id_rach>150000 limit 1 )))::int + (select id_rach from "RachunekBankowy" where id_rach>150000 limit 1)  id_rach,
'uzytkownik' typ
FROM source);


INSERT INTO public."Depozyt"  (id_upraw,id_bank, wartosc,data_zlozenia)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 100000)
SELECT 
(random() * ((select id_uprawnienie from "Uprawnienie" group by id_uprawnienie order by id_uprawnienie desc limit 1)-(select id_uprawnienie from "Uprawnienie" where id_uprawnienie>200000 limit 1 )))::int + (select id_uprawnienie from "Uprawnienie" where id_uprawnienie>200000 limit 1)  id_upraw,
(random() * (select max(id_bank) - min(id_bank) from public."Bank"  ))::int + (select min(id_bank) from public."Bank"  ) id_bank,
(random() *1000)::int wartosc,
(NOW()) data_zlozenia
FROM source);




