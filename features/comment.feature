# language: it

Funzionalità: Utente crea ed elimina un commento
  Come utente registrato
  Voglio poter creare/eliminare commenti a un evento
  In modo da dare/eliminare un feedback

  Scenario: Crea/Elimina un commento
    Dato un utente registrato
    Quando visita la pagina degli Eventi
    E visita la pagina del primo evento
    E scrive un commento
    E clicca il bottone commenta
    E legge il proprio commento
    E clicca il pulsante elimina
    Allora non legge più il commento
