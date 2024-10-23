class Jugador {
  var nivelSospecha = 40
  var puedoVotar = true
  const mochila = []
  var personalidad
  var estaVivo = true

  method nivelSospecha() = nivelSospecha

  method nivelSospecha(unNivel) {
    nivelSospecha = unNivel
  }

  method aumentarSospecha(unNivel) {
    nivelSospecha += unNivel
  }

  method disminuirSospecha(unNivel) {
    nivelSospecha -= unNivel
  }

  method esSospechoso() = nivelSospecha > 50

  method buscarItem(unItem) = mochila.add(unItem)

  method tiene(unItem) = mochila.contains(unItem)

  method usar(unItem) {
    mochila.remove(unItem)
  } 

  method impugnarVoto() {
    puedoVotar = false
  }

  method llamarAReunionDeEmergencia() {
    nave.llamarAReunionDeEmergencia()
  }

  method voto() = if (puedoVotar) {
    personalidad.voto()
  } else {
    self.votarEnBlanco()
  }

  method tieneItems() = not mochila.isEmpty()

  method estaVivo() = estaVivo

  method votarEnBlanco() {
    puedoVotar = true
    return "Voto en blanco"
  }
}

class Tripulante inherits Jugador {
  const tareas = []

  method completoSusTareas() = tareas.isEmpty()

  method realizarTarea() {
    const tarea = self.tareaPendienteRealizable()
    tarea.realizarse(self)
    nave.terminarTarea()
  }

  method tareaPendienteRealizable() = tareas.find { tarea => tarea.puedeRealizar(self) } //Find devuelve el primer objeto que cumple y no la coleccion
                                                                                         //En una relación 1 a n, la responsablidad suele ser para las n posibilidades
  method expulsar() {
    nave.expulsarTripulante()
    estaVivo = false
  }
}
class Impostor inherits Jugador {
  method completoSusTareas() = true

  method realizarTarea() {}

  method realizarSabotaje(unSabotaje) {
    self.aumentarSospecha(5)
    unSabotaje.realizate()
  }

  override method voto() = nave.cualquierJugadorVivo()

  method expulsar() {
    nave.expulsarImpostor()
    estaVivo = false
  }
}

class Tarea {
  const itemsNecesarios
  method puedeRealizarla(unJugador) = itemsNecesarios.all { item => unJugador.tiene(item) }

  method realizarse(unJugador) {
    self.usarItemsNecesarios(unJugador)
    self.afectarA(unJugador)
  }

  method usarItemsNecesarios(unJugador) {
    itemsNecesarios.forEach { item => unJugador.usar(item) }
  }

  method afectarA(unJugador)
}

class ArreglarTablero inherits Tarea(itemsNecesarios = ["Llave inglesa"]){
  override method afectarA(unJugador) {
    unJugador.aumentarSospecha(10)
  } 
}

class SacarLaBasura inherits Tarea(itemsNecesarios = ["Escoba","Bolsa de consorcio"]) {

  override method afectarA(unJugador) {
    unJugador.disminuirSospecha(4)
  } 
}

class VentilarNave inherits Tarea(itemsNecesarios = []){
  override method afectarA(unJugador) {
    nave.aumentarOxigeno(5)
  }
}

object nave {
  var nivelOxigeno = 100
  const jugadores = []
  var cantidadTripulantes = 0
  var cantidadImpostores  = 0

  method aumentarOxigeno(unNivel) {
    nivelOxigeno += unNivel
  }

  method reducirOxigeno(unNivel) {
    nivelOxigeno -= unNivel
    self.validarGanaronImpostores()
  }

  method validarGanaronImpostores() {
    if (nivelOxigeno <= 0 or cantidadTripulantes == 0) {
      throw new DomainException(message = "Ganaron los impostores ☠️")
    }
  }

  method sabotearOxigeno() {
    if(not self.alguienTieneTuboDeOxigeno()) {
      self.reducirOxigeno(10)
    }
  }

  method alguienTieneTuboDeOxigeno() = jugadores.any { unJugador => unJugador.tiene("Tubo de oxigeno") }

  method terminarTarea() = 
  if(self.seCompletaronTodasLasTareas()) {
    throw new DomainException(message = "Victoria magistral :v")
  }

  method seCompletaronTodasLasTareas() = 
  jugadores.all { jugador => jugador.completoSusTareas() }

  method llamarAReunionDeEmergencia() {
    const losVotitos = self.jugadoresVivos().map { unJugador => unJugador.voto() }
    const elMasVotado = losVotitos.max { alguien => losVotitos.occurrencesOf(alguien) }
    if (elMasVotado == "Voto en blanco") {
      elMasVotado.expulsar()
    }

  }

  method jugadoresVivos() = jugadores.filter { jugador => jugador.estaVivo() }

  method jugadorNoSospechoso() = self.jugadoresVivos().findOrDefault( { jugador => !jugador.esSospechoso() } , "Voto en blanco")

  method jugadorSinItems() = self.jugadoresVivos().find { jugador => !jugador.tieneItems() }

  method jugadorMasSospechoso() = self.jugadoresVivos().max { jugador => jugador.nivelSospecha() }

  method cualquierJugadorVivo() = self.jugadoresVivos().anyOne()

  method expulsarTripulante() {
    cantidadTripulantes -= 1
    self.validarGanaronImpostores()
  }

  method expulsarImpostor() {
    cantidadImpostores -= 1
    if (cantidadImpostores == 0) {
      throw new DomainException (message = "Ganaron los tripulantes 🥳")
    }
  }

}

object reducirOxigeno {
  method realizate() {
    nave.sabotearOxigeno()
  }
}

class ImpugnarJugador {
  const jugadorImpugnado

  method realizate() {
   jugadorImpugnado.impugnarVoto()
  }
}

object troll {
  method voto() = nave.jugadorNoSospechoso()
}

object materialista {
  method voto() = nave.jugadorSinItems()
}

object detective {
  method voto() = nave.jugadorMasSospechoso()
}