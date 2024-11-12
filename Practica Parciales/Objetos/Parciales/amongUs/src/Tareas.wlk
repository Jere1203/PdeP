import src.Nave.*

class Tarea {
  const itemsNecesarios = []

  method esRealizadaPor(unJugador) {
    unJugador.tiene(itemsNecesarios)
    self.afectarA(unJugador)
  }

  method afectarA(unJugador)
}
class ArreglarTablero inherits Tarea (itemsNecesarios = ["Llave inglesa"]) {
  override method afectarA(unJugador) {
    unJugador.aumentarSospecha(10)
  }
}

class SacarLaBasura inherits Tarea (itemsNecesarios = ["Escoba", "Bolsa de consorcio"]) {
  override method afectarA(unJugador) {
    unJugador.disminuirSospecha(4)
  }
}

class VentilarNave inherits Tarea {
  method serRealizadaPor(unTripulante) {
    nave.aumentarOxigeno(5)
  }
}