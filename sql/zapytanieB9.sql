select sum(kwota_kredytu), Rach.id_rach, Ban.id_bank, Kl.id_klient from "Bank" AS Ban, "RachunekBankowy" AS Rach, "Kredyt" As Kred, 
"Klient" as Kl, "Uprawnienie" as Upr 
where Ban.id_bank=Rach.id_bank AND Rach.id_rach=Kred.id_rach AND Kl.id_klient=Upr.id_klienta AND Upr.id_rach=Rach.id_rach
Group by Rach.id_rach, Ban.id_bank, Kl.id_klient ORDER BY id_klient