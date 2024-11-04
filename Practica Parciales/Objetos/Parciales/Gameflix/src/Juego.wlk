import Suscripcion.*
class Juego {
  const categoria
  const precio
  const nombre

  method jugar(unCliente, cantidadHoras)

  method categoria() = categoria

  method precio() = precio

  method nombre() = nombre
}

class JuegoViolento inherits Juego {
  override method jugar(unCliente, cantidadHoras) {
    unCliente.reducirHumor(10 * cantidadHoras)
  }
}

class Moba inherits Juego {
  override method jugar(unCliente, _cantidadHoras) {
    unCliente.gastarDinero(30)
  }
}

class JuegoTerror inherits Juego {
  override method jugar(unCliente, _cantidadHoras) {
    unCliente.suscripcion(infantil)
  }
}

class JuegoEstrategia inherits Juego {
  override method jugar(unCliente, cantidadHoras) {
    unCliente.aumentarHumor(5 * cantidadHoras)
  }
}