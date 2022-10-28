# language: it

Funzionalità: Location Filter Search Event
  Come utente registrato
  Voglio poter cercare eventi consentendo l'accesso alla mia posizione
  In modo da visualizzare gli eventi a me più vicini

  Scenario: Visualizza Eventi Vicini
    Dato un utente registrato
    Quando visita la pagina degli Eventi
    E clicco la checkbox "current_location"
    E clicco la submit "Find Events"
    Allora vedo gli eventi vicini