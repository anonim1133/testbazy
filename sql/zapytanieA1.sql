﻿select id_trans, id_poc,id_cel,kwota_transakcji, data_wykonania from("Transakcja" as Trans 
JOIN "RachunekBankowy" AS rach1 on Trans.id_poc=rach1.id_rach ) as TransRach 
JOIN "RachunekBankowy" AS rach2 on TransRach.id_cel=rach2.id_rach where TransRach.id_bank=rach2.id_bank;