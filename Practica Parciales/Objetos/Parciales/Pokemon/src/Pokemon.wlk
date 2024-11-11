class Pokemon {
  const saludMaxima
  var salud
  const movimientos
  var condicion
  var turnosConfundido

  method grositud() = saludMaxima * self.sumaPoderMovimientos()

  method sumaPoderMovimientos() = movimientos.sum { unMovimiento => unMovimiento.poder() }

  method lucharCon(otroPokemon) {
    const movimientosDisponibles = movimientos.filter { unMovimiento => unMovimiento.leQuedanUsos() }
    if (!self.estaVivo()) {
      throw new DomainException (message = "El pokemon no puede realizar el ataque")
    }
    condicion.afectarA(self)
    movimientosDisponibles.anyOne().usarMovimientoEntre(self, otroPokemon)
  }

  method condicion(unaCondicion) {
    condicion = unaCondicion
  }

  method recibirDanio(unDanio) {
    salud -= unDanio
  }

  method aumentarVida(cantidadVida) {
    salud += cantidadVida
    saludMaxima.min(salud)
  }

  method validarSuenio() = self.esta(dormido)

  method esta(unaCondicion) = condicion == unaCondicion

  method lograMoverse() = 0.randomUpTo(2).roundUp().even()

  method estaVivo() = salud > 0

  method afectadoPorCondicion() = self.validarSuenio() and self.validarParalisis() and self.validarConfusion()

  method validarParalisis() = self.esta(paralizado)

  method validarConfusion() = self.esta(confundido)

  method intentarAtacar() = 0.randomUpTo(2).roundUp().even()

  method reducirTurnosConfundido() {
    turnosConfundido -= 1
    if(turnosConfundido == 0) {
      self.condicion(normal)
    }
  }
}



object dormido {
  method afectarA(unPokemon) {
    if (unPokemon.intentarAtacar()) {
      unPokemon.condicion(normal)
    }
  }
}

object paralizado {
  method afectarA(unPokemon) {
    if (!unPokemon.intentarAtacar()) {
      throw new DomainException(message = "El pokemon sigue paralizado")
    }
  }
}

object confundido {
  method afectarA(unPokemon) {
    if(!unPokemon.intentarAtacar()) {
      unPokemon.recibirDanio(20)
      unPokemon.reducirTurnosConfundido()
    }
  }
}

object normal {}