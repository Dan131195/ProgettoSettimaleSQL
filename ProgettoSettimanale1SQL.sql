CREATE DATABASE Progetto_1_SQL;

USE Progetto_1_SQL;

CREATE TABLE ANAGRAFICA (
    idanagrafica INT IDENTITY(1,1) PRIMARY KEY,
    Cognome VARCHAR(50) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Indirizzo VARCHAR(100) NOT NULL,
    Città VARCHAR(50) NOT NULL,
    CAP VARCHAR(10) NOT NULL,
    Cod_Fisc VARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE TIPO_VIOLAZIONE (
    idviolazione INT IDENTITY(1,1) PRIMARY KEY,
    descrizione VARCHAR(255) NOT NULL
);

CREATE TABLE VERBALE (
    idverbale INT IDENTITY(1,1) PRIMARY KEY,
    idanagrafica INT NOT NULL,
    idviolazione INT NOT NULL,
    DataViolazione DATE NOT NULL,
    IndirizzoViolazione VARCHAR(100) NOT NULL,
    Nominativo_Agente VARCHAR(100),
    DataTrascrizioneVerbale DATE NOT NULL,
    Importo DECIMAL(7,2) NOT NULL,
    DecurtamentoPunti INT NOT NULL,
    CONSTRAINT FK_Id_Anagrafica FOREIGN KEY (idanagrafica) REFERENCES ANAGRAFICA(idanagrafica),
    CONSTRAINT FK_Id_Violazione FOREIGN KEY (idviolazione) REFERENCES TIPO_VIOLAZIONE(idviolazione)
);


INSERT INTO ANAGRAFICA (Cognome, Nome, Indirizzo, Città, CAP, Cod_Fisc)
VALUES ('Rossi', 'Mario', 'Via Roma 10', 'Palermo', '90100', 'RSSMRA80A01H501Z'),
       ('Bianchi', 'Luca', 'Via Milano 20', 'Milano', '20100', 'BNCLCU85B02F205X'),
	   ('Verdi', 'Giulia', 'Corso Venezia 15', 'Torino', '10100', 'VRDGLL90C03L219Y'),
       ('Neri', 'Andrea', 'Piazza Duomo 5', 'Firenze', '50100', 'NRIAND92D04H501P'),
       ('Gialli', 'Sara', 'Viale Europa 25', 'Roma', '00100', 'GLLSRA88E05R001T'),
       ('Marroni', 'Elena', 'Via Napoli 8', 'Napoli', '80100', 'MRRLNE93F06H801U'),
	   ('Azzurri', 'Marco', 'Largo Garibaldi 12', 'Bologna', '40100', 'AZZMRX81G07B401V');


INSERT INTO TIPO_VIOLAZIONE (descrizione)
VALUES ('Eccesso di velocità'), ('Passaggio con semaforo rosso');

INSERT INTO VERBALE (idanagrafica, idviolazione, DataViolazione, IndirizzoViolazione, Nominativo_Agente, DataTrascrizioneVerbale, Importo, DecurtamentoPunti)
VALUES (1, 1, '2024-01-15', 'Via Libertà 45', 'Agente Verdi', '2024-01-16', 150.00, 3),
       (2, 2, '2024-02-10', 'Corso Buenos Aires 100', 'Agente Neri', '2024-02-11', 200.00, 5),
	   (3, 2, '2006-05-20', 'Viale Europa 30', 'Agente Bianchi', '2006-05-21', 120.00, 2),
       (4, 1, '2010-09-15', 'Piazza Duomo 5', 'Agente Rossi', '2010-09-16', 180.00, 4),
       (5, 2, '2015-07-10', 'Via Napoli 8', 'Agente Gialli', '2015-07-11', 250.00, 6),
       (6, 2, '2018-12-03', 'Corso Venezia 15', 'Agente Marroni', '2018-12-04', 90.00, 1),
       (7, 1, '2020-06-25', 'Largo Garibaldi 12', 'Agente Azzurri', '2020-06-26', 300.00, 7),
	   (1, 2, '2009-02-15', 'Via Libertà 45', 'Agente Verdi', '2024-01-16', 800.00, 10);

	   
SELECT * FROM ANAGRAFICA;
SELECT * FROM TIPO_VIOLAZIONE;
SELECT * FROM VERBALE;


-- 1)
SELECT COUNT(*) AS TotaleVerbali FROM VERBALE;

-- 2)
SELECT idanagrafica, COUNT(*) AS NumeroVerbali FROM VERBALE GROUP BY idanagrafica;

-- 3)
SELECT idviolazione, COUNT(*) AS NumeroViolazioni FROM VERBALE GROUP BY idviolazione;

-- 4)
SELECT idanagrafica, SUM(DecurtamentoPunti) AS TotalePuntiDecurtati FROM VERBALE GROUP BY idanagrafica;

-- 5)
SELECT A.Cognome, A.Nome, V.DataViolazione, V.IndirizzoViolazione, V.Importo, V.DecurtamentoPunti
FROM VERBALE V
JOIN ANAGRAFICA A ON V.idanagrafica = A.idanagrafica
WHERE A.Città = 'Palermo';

-- 6)
SELECT A.Cognome, A.Nome, A.Indirizzo, V.DataViolazione, V.Importo, V.DecurtamentoPunti
FROM VERBALE V
JOIN ANAGRAFICA A ON V.idanagrafica = A.idanagrafica
WHERE V.DataViolazione BETWEEN '2009-02-01' AND '2009-07-31';

-- 7)
SELECT idanagrafica, SUM(Importo) AS TotaleImporti FROM VERBALE GROUP BY idanagrafica;

-- 8)
SELECT * FROM ANAGRAFICA WHERE Città = 'Palermo';

-- 9)
SELECT DataViolazione, Importo, DecurtamentoPunti FROM VERBALE WHERE DataViolazione = '2024-01-15';

-- 10)
SELECT Nominativo_Agente, COUNT(*) AS NumeroViolazioni FROM VERBALE GROUP BY Nominativo_Agente;

-- 11)
SELECT A.Cognome, A.Nome, A.Indirizzo, V.DataViolazione, V.Importo, V.DecurtamentoPunti
FROM VERBALE V
JOIN ANAGRAFICA A ON V.idanagrafica = A.idanagrafica
WHERE V.DecurtamentoPunti >= 5;

-- 12)
SELECT A.Cognome, A.Nome, A.Indirizzo, V.DataViolazione, V.Importo, V.DecurtamentoPunti
FROM VERBALE V
JOIN ANAGRAFICA A ON V.idanagrafica = A.idanagrafica
WHERE V.Importo > 400;

-- EXTRA --

-- 13)
SELECT Nominativo_Agente, COUNT(*) AS NumeroVerbali, SUM(Importo) AS ImportoTotale 
FROM VERBALE 
GROUP BY Nominativo_Agente;

-- 14)
SELECT idviolazione, AVG(Importo) AS MediaImporto 
FROM VERBALE 
GROUP BY idviolazione;

