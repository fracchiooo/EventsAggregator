# README

EventsAggregator è un’applicazione che punta ad aggregare gli eventi riportati su diverse fonti, quali TicketMaster e PredictHQ. L’applicazione inoltre dà la possibilità di cercare eventi per categoria e posizione geografica, permettendo di commentare un evento, di valutarlo e di segnalare il proprio interesse per la partecipazione.

## Configurazione:

* Inserire la master.key in config

### Esecuzione:

* bundle install
* rails db:migrate 
* npm install
* npm run build
* rails server

## User Stories

Things you may want to cover:

Utente non registrato:  
1. Da utente non registrato voglio iscrivermi usando email e password così da diventare un utente  registrato.
2. Da utente non registrato voglio iscrivermi usando il mio account Google così da diventare un  utente registrato.
3. Da utente non registrato voglio iscrivermi usando il mio account Facebook così da diventare un utente registrato.
4. Da utente non registrato voglio poter visualizzare gli eventi presenti sull'applicazione ottenuti dalle API di TicketMaster ed PredictHQ così da poterne scegliere uno che mi suscita interesse.
5. Da utente non registrato voglio poter visualizzare le foto degli eventi in modo da avere una informazione in più sull'evento.
6. Da utente non registrato/registrato voglio poter condividere le pagine degli eventi attraverso l'url tramite piattaforme quali Facebook, Whatsapp e Twitter, così da informare altre persone.
7. Da utente non registrato/registrato voglio poter essere reindirizzato alla pagina di pagamento per acquistare il biglietto per un evento in modo da avere accesso all’evento.
8. Da utente non registrato/registrato voglio poter visualizzare una lista di eventi in modo da scegliere quello di mio interesse.
9. Da utente non registrato/registrato voglio poter cercare eventi tramite la data in modo da scegliere l'evento in base ai miei impegni.
10. Da utente non registrato/registrato voglio poter cercare eventi tramite categoria in modo da scegliere l'evento in base ai miei interessi.
11. Da utente non registrato/registrato voglio poter cercare eventi tramite luogo in modo da visualizzare gli eventi dove vorrei andare.
12. Da utente non registrato/registrato voglio poter cercare eventi consentendo l'accesso alla mia posizione corrente in modo da visualizzare gli eventi a me più vicini.
13. Da utente non registrato/registrato voglio poter cercare eventi tramite parole chiave in modo da effettuare una ricerca più specifica.
14. Da utente non registrato/registrato voglio poter visualizzare le informazioni del sito in modo da conoscere la descrizione sito, le faq, i  contatti, le linee guida.
15. Da utente non registrato/registrato voglio poter visualizzare gli hotel nelle vicinanze di un evento in modo da poter scegliere il più comodo.
16. Da utente non registrato/registrato voglio poter visualizzare la lista di eventi passati organizzati da un promoter in modo da vedere come sono stati valutati.
17. Da utente non registrato/registrato voglio poter visualizzare le edizioni passate di certi eventi (se disponibili) in modo da informarmi.

Utente registrato:  
18. Da utente registrato voglio poter accedere all'applicazione tramite email e password in modo da loggarmi al mio profilo.
19. Da utente registrato voglio poter accedere all'applicazione tramite il mio account Google in modo da loggarmi al mio profilo. 
20. Da utente registrato voglio poter accedere all'applicazione tramite il mio account Facebook in modo da loggarmi al mio profilo. 
21. Da utente registrato voglio poter accedere alla pagina con le mie informazioni personali in modo da visualizzarle.
22. Da utente registrato voglio poter eliminare il mio account in modo da non essere più un utente registrato.
23. Da utente registrato voglio poter modificare il mio indirizzo email in modo da aggiornarlo per motivi personali.
24. Da utente registrato voglio poter modificare la mia password in modo da aggiornarla per motivi di sicurezza.
25. Da utente registrato voglio poter modificare il mio nickname per aumentare la customizzazione del mio account.
26. Da utente registrato voglio poter modificare la mia immagine del profilo per poterla aggiornare con una più recente.
27. Da utente registrato voglio poter recuperare la mia password tramite l'email in modo da recuperare l’account in caso di password dimenticata.
28. Da utente registrato voglio poter commentare un evento  in modo da dare un feedback ad altri utenti.
29. Da utente registrato voglio poter valutare un evento in modo da assegnare al promoter maggiore punteggio riguardante l’affidabilità.
30. Da utente registrato voglio poter eliminare un mio commento in modo da eliminare eventuali errori.
31. Da utente registrato voglio poter modificare un mio commento in modo da correggere eventuali errori.
32. Da utente registrato voglio poter modificare una mia valutazione in caso cambi idea sull’evento.
33. Da utente registrato voglio poter segnalare il mio interesse per la partecipazione ad un evento in modo da indicarlo ad altri utenti.
34. Da utente registrato voglio poter rimuovere il mio interesse per la partecipazione ad un evento in modo da rimuoverlo dalla sezione “eventi a cui partecipo” presente nel profilo.
35. Da utente registrato voglio poter segnalare agli amministratori commenti inopportuni in modo che possano essere visionati e rimossi.
36. Da utente registrato voglio poter valutare i commenti degli altri utenti in modo da modificarne la  visibilità.
37. Da utente registrato voglio poter salvare un evento alla lista dei preferiti in modo da visualizzarlo in un secondo momento. 
38. Da utente registrato voglio poter visualizzare una lista degli eventi salvati nei preferiti in modo da scegliere quello a cui partecipare.
39. Da utente registrato voglio poter visualizzare la lista degli eventi a cui partecipo in modo da valutarli successivamente.
40. Da utente registrato voglio poter aggiungere un evento a cui partecipo al mio Google Calendar in modo da ricevere una notifica il giorno prima.
41. Da utente registrato voglio poter aggiungere, tramite Google Drive, una o più foto/video dell'evento a cui ho partecipato all'interno della pagina dell’evento in modo da mostrarlo agli altri utenti.
42. Da utente registrato voglio poter visualizzare la pagina profilo di un altro utente in modo da vedere a quali eventi parteciperà.

Amministratore:  
43. Da amministratore voglio poter visualizzare la lista dei commenti segnalati in modo da rimuoverli.
44. Da amministratore voglio poter eliminare un commento in modo che non sia più visibile ad altri utenti.
45. Da amministratore voglio poter bloccare l'account di un utente in modo che non possa più  commentare.
46. Da amministratore voglio poter eliminare l'account di un utente in modo che non abbia più accesso al sito.
47. Da amministratore voglio poter visualizzare la lista degli utenti registrati in modo da modificarne i permessi (rendere amministratore o bloccare).
48. Da amministratore voglio poter mettere in evidenza un commento in modo che sia leggibile più facilmente.
49. Da amministratore voglio poter assegnare il ruolo di amministratore ad un utente in modo da aumentargli i permessi.
50. Da amministratore voglio poter revocare il ruolo di amministratore ad un altro amministratore in modo da diminuirne i permessi.
51. Da amministratore voglio poter modificare le informazioni di un account in modo da moderarne i contenuti.
