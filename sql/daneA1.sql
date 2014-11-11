INSERT INTO public."Transakcja" (id_poc, id_cel, kwota_transakcji, data_wykonania)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 200000)
SELECT 
(random() * (select max(id_rach) - min(id_rach) from public."RachunekBankowy" ))::int + (select min(id_rach) from public."RachunekBankowy" ) id_poc,
(random() * (select max(id_rach) - min(id_rach) from public."RachunekBankowy" ))::int + (select min(id_rach) from public."RachunekBankowy" ) id_cel,
(random() * 10000)::int kwota_transakcji,
( '2009-01-01'::date + ((now()::date - '2009-01-01'::date)::int * random())::int ) data_wykonania
FROM source);