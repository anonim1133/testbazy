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

INSERT INTO public."Uprawnienie"  (id_klienta, id_rach, typ)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 50000)
SELECT 
(random() * (select max(id_klient) - min(id_klient) from public."Klient"  ))::int + (select min(id_klient) from public."Klient"  ) id_klienta,
(random() * (select max(id_rach) - min(id_rach) from public."RachunekBankowy"  ))::int + (select min(id_rach) from public."RachunekBankowy"  ) id_rach,
'wlasciciel' typ
FROM source);


INSERT INTO public."KartaKredytowa"  (id_upraw, nr_karty, typ, data_wydania, data_wygasniecia)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 50000)
SELECT 
(random() * ((select id_rach from "Uprawnienie" group by id_uprawnienie order by id_rach desc limit 1)-(select id_rach from "Uprawnienie" where id_uprawnienie>300000 limit 1 )))::int + (select id_rach from "Uprawnienie" where id_uprawnienie>300000 limit 1)  id_upraw,
(select random_string(26) ) nr_karty,
'standard' typ,
(NOW()) data_wydania,
(NOW() + interval '4 years')::date data_wygasniecia
FROM source);
