import src.Jugadores.*

object nave {
  var tripulantes = 0
  var impostores = 0
  var oxigeno = 100
  const jugadores = []

  method tareaRealizada() {
    if (self.tripulantesRealizaronSusTareas()) {
      throw new DomainException(message = "Ganaron los tripulantes")
    }
  }

  method tripulantesRealizaronSusTareas() = tripulantes.all { unTripulante => unTripulante.completoSusTareas() }

  method aumentarOxigeno(unaCantidad) {
    oxigeno += unaCantidad
  }

  method reducirOxigeno(unaCantidad) {
    oxigeno -= unaCantidad
    if (oxigeno <= 0) {
      throw new DomainException (message = "Ganan los impostores")
    }
  }

  method hayTuboDeOxigeno() = tripulantes.tiene("Tubo de oxigeno")

  method tripulantes() = tripulantes

  method jugadorNoSospechoso() = jugadores.findOrDefault ({ unJugador => not unJugador.esSospechoso() }, votoEnBlanco)

  method jugadorMasSospechoso() = jugadores.findOrDefault ({ unJugador => unJugador.nivelSospecha() }, votoEnBlanco)

  method jugadorConMochilaVacia() = jugadores.findOrDefault ({ unJugador => unJugador.mochilaVacia() }, votoEnBlanco)

  method llamarAVotacion() {
    const listaVotos = self.jugadoresVivos().map { unJugador => unJugador.votar() }
    const masVotado = listaVotos.max { unVoto => listaVotos.occurenciesOf(unVoto) }
    masVotado.expulsar()
  }

  method jugadores() = jugadores

  method quitarImpostor() {
    impostores -= 1
    if(impostores == 0) {
      throw new DomainException(message = "Ganan los tripulantes")
    }
  }

  method quitarTripulante() {
    tripulantes -= 1
    if (tripulantes == 0) {
      throw new DomainException (message = "Ganan los impostores")
    }
  }

  method jugadoresVivos() = jugadores.filter { unJugador => unJugador.estaVivo() }

  method cualquierJugadorVivo() = self.jugadoresVivos().anyOne()

}