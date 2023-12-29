-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Dic 28, 2023 alle 18:21
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Aide`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `Lezioni`
--

CREATE TABLE `Lezioni` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `descrizione` text DEFAULT NULL,
  `percorso_file` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Lezioni`
--

INSERT INTO `Lezioni` (`id`, `nome`, `descrizione`, `percorso_file`, `username`) VALUES
(1, 'Lezione 1: Software Requirements', 'Questa lezione approfondisce i fondamenti e il processo di ingegneria dei requisiti software, coprendo argomenti come definizione, classificazione, elicitation, analisi, specifica, validazione e considerazioni pratiche, offrendo una panoramica completa del ciclo di vita dei requisiti.', 'Lessons/Lezione1.txt', 'admin'),
(2, 'Lezione 2: Software Design', 'Questa lezione approfondisce i fondamenti del design del software, esaminando concetti generali, il contesto, i principi e le questioni chiave come la concorrenza, il controllo degli eventi e la sicurezza. Copre anche la struttura e l\'architettura del software, la progettazione dell\'interfaccia utente, l\'analisi della qualità e valutazione, utilizzando notazioni specifiche e strategie di progettazione, inclusi approcci orientati alla funzione, orientati agli oggetti e basati su componenti, insieme a strumenti pratici utilizzati in questo contesto.\r\n', 'Lessons/Lezione2.txt', 'admin'),
(3, 'Lezione 3: Software Construction', 'Questa lezione si occupa dei fondamenti della costruzione del software, esaminando aspetti come la minimizzazione della complessità, l\'anticipazione del cambiamento e il riutilizzo del codice. Affronta anche la gestione della costruzione, considerazioni pratiche come design, testing e integrazione, oltre a esplorare tecnologie di costruzione come design API, gestione degli errori e strumenti di analisi delle prestazioni.', 'Lessons/Lezione3.txt', 'utente2'),
(4, 'Lezione 4: Software Testing', 'Questa lezione introduce i fondamenti del testing software, includendo terminologia, livelli di test, tecniche di test, misure correlate e strumenti di testing. Copre anche il processo di test con considerazioni pratiche e attività associate.', 'Lessons/Lezione4.txt', 'utente2'),
(5, 'Lezione 5: Software Maintenance', 'Questa lezione introduce i fondamenti della manutenzione del software, coprendo definizioni, la natura e la necessità della manutenzione, insieme a costi e categorie. Affronta anche questioni chiave come aspetti tecnici e gestionali, stime dei costi e processi di misurazione. La lezione presenta inoltre tecniche di manutenzione come la comprensione del programma, la riconversione e strumenti correlati.', 'Lessons/Lezione5.txt', 'admin'),
(6, 'Lezione 6: Software Configuration Management', 'Questa lezione tratta la gestione del processo di Configuration Management Software (SCM), inclusi il contesto organizzativo, la pianificazione, la creazione del piano SCM e la sorveglianza del processo. Affronta l\'identificazione delle configurazioni software, il controllo, la rendicontazione dello stato e l\'auditing, insieme alla gestione delle release del software e agli strumenti di Configuration Management Software.', 'Lessons/Lezione6.txt', 'utente2'),
(7, 'Lezione 7: Software Engineering Management', 'Questa lezione si concentra sull\'iniziazione e definizione dello scope dei progetti software, pianificazione, implementazione, revisione e chiusura. Affronta anche la misurazione dell\'ingegneria del software e presenta gli strumenti di gestione dell\'ingegneria del software.', 'Lessons/Lezione7.txt', 'utente2'),
(8, 'Lezione 8: Software Engineering Process', 'Questa lezione esplora la definizione dei processi software, cicli di vita del software, adattamento dei processi e considerazioni pratiche. Affronta anche la valutazione e il miglioramento dei processi, la misurazione del software e presenta strumenti di ingegneria del software.', 'Lessons/Lezione8.txt', 'admin'),
(9, 'Lezione 9: Software Engineering Models', 'Questa lezione introduce i principi della modellazione, tipologie di modelli (informazione, comportamentale, strutturale), e analisi dei modelli per completezza, coerenza e correttezza. Copre anche vari metodi di ingegneria del software, tra cui euristici, formali, prototipazione e agili.', 'Lessons/Lezione9.txt', 'admin'),
(10, 'Lezione 10: Software Quality', 'Questa lezione esplora i fondamenti della qualità del software, comprendendo cultura ed etica dell\'ingegneria del software, valore e costi della qualità, modelli e miglioramento. Copre anche i processi di gestione della qualità, considerazioni pratiche come requisiti e caratterizzazione dei difetti, e presenta strumenti di gestione della qualità del software.', 'Lessons/Lezione10.txt', 'utente2');

-- --------------------------------------------------------

--
-- Struttura della tabella `Utenti`
--

CREATE TABLE `Utenti` (
  `Email` varchar(255) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `API_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Utenti`
--

INSERT INTO `Utenti` (`Email`, `Username`, `Password`, `API_key`) VALUES
('admin@admin.com', 'admin', 'Admin123@', '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'),
('utente2@gmail.com', 'utente2', 'Utente2@', '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');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `Lezioni`
--
ALTER TABLE `Lezioni`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `percorso_file` (`percorso_file`);

--
-- Indici per le tabelle `Utenti`
--
ALTER TABLE `Utenti`
  ADD PRIMARY KEY (`Email`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `API_key` (`API_key`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `Lezioni`
--
ALTER TABLE `Lezioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
