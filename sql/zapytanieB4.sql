select * from("Klient" AS Kl JOIN (select * from (select id_klienta from
(select id_klienta, COUNT(DISTINCT(id_bank)) AS Banki
FROM ("Uprawnienie" as Upr
JOIN "RachunekBankowy" as Rach on Upr.id_rach=Rach.id_rach) JOIN "Kredyt" as Kred on Rach.id_rach=Kred.id_rach
group by id_klienta) as Klienci where Klienci.Banki>1) as KlientBanku) as Klienci on Kl.id_klient=Klienci.id_klienta )