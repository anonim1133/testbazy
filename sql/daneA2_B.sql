create or replace function random_string(length integer) returns text as 
$$
declare
  chars text[] := '{0,1,2,3,4,5,6,7,8,9}';
  result text := '';
  i integer := 0;
begin
  if length < 0 then
    raise exception 'Given length cannot be less than 0';
  end if;
  for i in 1..length loop
    result := result || chars[1+random()*(array_length(chars, 1)-1)];
  end loop;
  return result;
end;
$$ language plpgsql;


INSERT INTO public."RachunekBankowy"  (id_bank, numer_rachunku,data_zalozenia, stan_konta, typ_konta)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 100000)
SELECT 
(random() * (select max(id_bank) - min(id_bank) from public."Bank"  ))::int + (select min(id_bank) from public."Bank"  ) id_bank,
(select random_string(25) ) numer_rachunku,
(NOW()) data_zalozenia,
(0)::int stan_konta,
'standard' typ_konta
FROM source);

INSERT INTO public."Uprawnienie"  (id_klienta, id_rach, typ)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 100000)
SELECT 
(random() * (select max(id_klient) - min(id_klient) from public."Klient"  ))::int + (select min(id_klient) from public."Klient"  ) id_klienta,
(random() * ((select id_rach from "RachunekBankowy" group by id_rach order by id_rach desc limit 1)-(select id_rach from "RachunekBankowy" where id_rach>150000 limit 1 )))::int + (select id_rach from "RachunekBankowy" where id_rach>150000 limit 1)  id_rach,
'uzytkownik' typ
FROM source);


