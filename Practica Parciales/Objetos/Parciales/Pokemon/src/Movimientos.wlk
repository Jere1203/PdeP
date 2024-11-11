import Pokemon.*
class Movimiento {
    const tipoMovimiento
    var usosDisponibles

    method decrementarUsosDisponibles() {
        usosDisponibles -= 1
    }

    method usarMovimientoEntre(unPokemon, otroPokemon) {
        self.decrementarUsosDisponibles()
        tipoMovimiento.afectarA(unPokemon, otroPokemon)
    }

    method leQuedanUsos() = usosDisponibles > 0
}

class Curativo inherits Movimiento {
    const puntosDeCuracion

    method afectarA(unPokemon, _otroPokemon) {
        unPokemon.aumentarVida(puntosDeCuracion)
    }
    method poder() = puntosDeCuracion
}

class Danino inherits Movimiento {
    const danio

    method afectarA(_unPokemon, otroPokemon) {
        otroPokemon.recibirDanio(danio)
    }
    method poder() = 2 * danio
}

class Especial inherits Movimiento {
    const tipo

    method afectarA(_unPokemon, otroPokemon) = tipo.afectarA(otroPokemon)
    method poder() = tipo.poder()
}

class Suenio {
    method poder() =  50
    method afectarA(otroPokemon) {
        otroPokemon.condicion(dormido)
    }
}

class Paralisis {
    method poder() = 30
    method afectarA(otroPokemon) {
        otroPokemon.condicion(paralizado)
    }
}

class Confusion {
    const duracionConfusion
    
    method poder() = 40 * duracionConfusion
    method afectarA(otroPokemon) {
      otroPokemon.turnosConfundido(duracionConfusion)
      otroPokemon.condicion(new Confundido(turnosConfundido = duracionConfusion))
    }
}