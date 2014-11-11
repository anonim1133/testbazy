create or replace function random_string_int(length integer) returns text as 
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

create or replace function random_string(length integer) returns text as 
$$
declare
	chars text[] := '{A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
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

--select random_string((random()*15)::int);
--select random_string_int((random()*15)::int);


INSERT INTO public."Klient"   (imie, nazwisko, pesel, data_urodzenia, nr_telefonu)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 20000)
SELECT 
(random_string((random()*30)::int)) imie,
(random_string((random()*60)::int)) nazwisko,
(random_string_int(11)) pesel,
('1996-01-01'::date + ((now()::date - '2014-01-01'::date)::int * random())::int ) data_urodzenia,
(random_string_int(9)) pesel
FROM source);

INSERT INTO public."Uprawnienie"  (id_klienta, id_rach, typ)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < 100000)
SELECT 
(random() * (select max(id_klient) - 75000 from public."Klient"  ))::int + 75000 id_klienta,
(random() * (select max(id_rach) - min(id_rach) from public."RachunekBankowy"   ))::int + (select min(id_rach) from public."RachunekBankowy"   ) id_rach,
'uzytkownik' typ
FROM source);

