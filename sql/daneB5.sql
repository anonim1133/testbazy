select id_rach into Pom 
from ((SELECT id_rach FROM "Kredyt") AS Kred 
LEFT JOIN (SELECT id_rach AS rachZl 
FROM "Zlecenie_stale" ) AS Zlec 
ON Kred.id_rach=Zlec.rachZl) where rachzl is null;

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

INSERT INTO public."Zlecenie_stale" (id_rach, rachunek_odbiorcy, tytul_przelewu, dzien_wykonania_operacji, kwota_zlecenia)(
WITH RECURSIVE source (counter) AS ( SELECT 1 UNION ALL SELECT counter +1 FROM source where counter < (SELECT COUNT(*) FROM "pom"))
SELECT 
(SELECT id_rach FROM "pom" OFFSET counter-1 LIMIT 1) id_rach,
(random_string_int(26)) rachunek_odbiorcy,
(random_string((random()*40)::int)) tytul_przelewu,
(random()*28) dzien_wykonania_operacji,
(random() * 1000)::numeric::money kwota_zlecenia
FROM source);

drop table "pom";