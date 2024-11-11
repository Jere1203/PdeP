class Pokemon {
  const saludMaxima
  var salud
  const movimientos
  var condicion

  method grositud() = saludMaxima * self.sumaPoderMovimientos()

  method sumaPoderMovimientos() = movimientos.sum { unMovimiento => unMovimiento.poder() }

  method lucharCon(otroPokemon) {
    const movimientosDisponibles = movimientos.filter { unMovimiento => unMovimiento.leQuedanUsos() }
    if (self.puedeAtacar()) {
      movimientosDisponibles.anyOne().usarMovimientoEntre(self, otroPokemon)
    } else {
      condicion.afectarA(self)
    }
  }

  method puedeAtacar() = self.estaVivo() and self.puedeMoverse()

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

  method esta(unaCondicion) = condicion == unaCondicion

  method estaVivo() = salud > 0

  method puedeMoverse() = 0.randomUpTo(2).roundUp().even()

}



object dormido {
  method afectarA(unPokemon) {
    if (unPokemon.intentarAtacar()) {
      unPokemon.condicion(normal)
    }
  }
}

object paralizado {
  method afectarA(unPokemon) {}
}

class Confundido {
  var turnosConfundido

  method afectarA(unPokemon) {
    if(!unPokemon.intentarAtacar()) {
      unPokemon.recibirDanio(20)
      0.max(turnosConfundido - 1)
    }
  }
}

object normal {}