class Pajaros {
    var ira
    method fuerza() = 2*ira

    method esPajaroFuerte() = self.fuerza() > 50

    method enojarse() {
        ira *= 2
    } 

    method tranquilizarse(cantidadIra) {
        ira -= cantidadIra
    } 

    method derriba(unObstaculo) = self.fuerza() > unObstaculo.resistencia()

}

class Red inherits Pajaros {
    var cantidadEnojos

    override method fuerza() = 10 * ira * cantidadEnojos

    override method enojarse() {
        super()
        cantidadEnojos += 1
    }
}

class Bomb inherits Pajaros {
    override method fuerza() = 9000.min(2*ira)
}

class Chuck inherits Pajaros {
    var velocidad

    override method fuerza() = self.fuerzaChuck()

    method fuerzaChuck() {
        if (velocidad < 80) {
            return 150
        } else {
            return 5 * (velocidad - 80)
        }
    }

    override method enojarse() {
        velocidad *= 2
    }

    override method tranquilizarse(cantidadIra) {}
}

class Terence inherits Pajaros {
    var cantidadEnojos
    var multiplicadorIra

    override method fuerza() = 10 * ira * cantidadEnojos * multiplicadorIra

    override method enojarse() {
        cantidadEnojos += 1
    }

    method multiplicadorIra(unMultiplicador) {
        multiplicadorIra = unMultiplicador
    } 
}

class Matilda inherits Pajaros {
    const huevos = []

    override method fuerza() = 2 * ira + huevos.sum { huevo => huevo.fuerza() }

    override method enojarse(){
        super()
        huevos.add (new Huevo (peso = 2))
    } 
}

class Huevo {
    const peso

    method fuerza() = peso
}