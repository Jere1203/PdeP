object tom {
    var property posicion = 0
    var property energia = 80
    var property persigueA = jerry
    method esMasVeloz(unRaton) {
      self.velocidad(self) > unRaton.velocidad(unRaton)
    }
    method velocidad(unPersonaje) {
      return 5 + (energia / 10)
    }

    method correrA(unRaton) {
      self.persigueA(unRaton)
      self.correrRaton(unRaton)
    }
    method correrRaton(unRaton) {
      self.gastarEnergia(unRaton)
      self.posicion(unRaton.posicion())
    }

    method persigueA(unRaton) {
      persigueA = unRaton
    }

    method gastarEnergia(unRaton) {
      energia = energia - (0.5 * self.velocidad(self) * (unRaton.posicion() - posicion).abs())
    }
    method posicion(unaPosicion) {
      posicion = unaPosicion
    }
}



object jerry {
    const peso = 3
    const posicion = 10
  method velocidad() {
    return 10 - self.peso()
  }

  method peso() {
    return peso
  }

  method posicion() {
    return posicion
  }
}

object robotRaton {
  const velocidad = 8
  const posicion = 12
  method posicion() {
    return posicion
  }
  method velocidad() {
    return velocidad
  }
}