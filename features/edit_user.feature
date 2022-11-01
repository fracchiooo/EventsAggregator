# language: it

Funzionalità: Admin Edit Other User Profile
  Come amministratore
  Voglio poter modificare le informazioni di un account
  In modo da moderarne i contenuti

  Scenario: Visualizza Profilo Utente
    Dato un utente amministratore
    Dato un utente da moderare
    Quando visita la pagina utenti
    E vedo il pulsante "Modera Utente"
    E clicco il pulsante "Modera Utente"
    E vedo la pagina Impostazioni Profilo
    E modifico l'username
    E clicco il pulsante "Salva Modifiche"
    Allora vedo la Home Page