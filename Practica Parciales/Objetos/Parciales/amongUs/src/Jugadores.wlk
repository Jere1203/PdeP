import src.Nave.*

class Jugador {
  var nivelSospecha = 40
  const mochila = []
  const tareas = []
  var estaVivo = true
  var puedeVotar = true

  method votarEnBlanco() {
    puedeVotar = true
    return votoEnBlanco
  }

  method puedeVotar() = puedeVotar

  method nivelSospecha() = nivelSospecha

  method esSospechoso() = self.nivelSospecha() > 50

  method buscarItem(unItem) = mochila.add(unItem)

  method aumentarSospecha(unaCantidad) {
    nivelSospecha += unaCantidad
  }

  method disminuirSospecha(unaCantidad) {
    nivelSospecha -= unaCantidad
  }

  method completoSusTareas() = tareas.isEmpty()

  method realizarTarea()

  method tiene(itemsNecesarios) = mochila.contains(itemsNecesarios)

  method mochilaVacia() = mochila.isEmpty()

  method expulsar() {
    estaVivo = false
  }

  method estaVivo() = estaVivo

  method llamarAReunion() {
    nave.llamarAVotacion()
  }
  method votaEnBlanco() {
    puedeVotar = false
  }
}

class Tripulante inherits Jugador {
  const personalidad
  
  override method realizarTarea() {
    tareas.anyOne().serRealizadaPor(self)
  }
  override method expulsar() {
    super()
    nave.quitarTripulante()
  }

  method votar() {
    if (self.puedeVotar()){
      personalidad.votar()
    } else {
      self.votarEnBlanco()
    }
  } 
}

class Impostor inherits Jugador {
  const sabotajes = []

  override method realizarTarea() {}

  override method completoSusTareas() = true

  method realizarSabotaje() = sabotajes.anyOne().serRealizadoPor(self)

  method votar() = self.votoAleatorio()
  
  method votoAleatorio() = nave.cualquierJugadorVivo()

  override method expulsar() {
    super()
    nave.quitarImpostor()
  }
}

object troll {
  method votar() = nave.jugadorNoSospechoso()
}

object detective {
  method votar() = nave.jugadorMasSospechoso()
}

object materialista {
  method votar() = nave.jugadorConMochilaVacia()
}

object votoEnBlanco {
  method expulsar() {}
}