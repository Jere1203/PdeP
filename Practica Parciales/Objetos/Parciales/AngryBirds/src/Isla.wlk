import Pajaros.*
object islaPajaros {
    const pajaros = []

    method pajarosMasFuertes() = pajaros.filter { pajaro => pajaro.fuerza() > 50 }

    method fuerzaDeLaIsla() = pajaros.sum { pajaro => pajaro.fuerza() }

    method ocurreEvento(unEvento) {
        pajaros.forEach { unPajaro => unEvento.afectarA(unPajaro) }
    }

    method atacarIslaCerdito() {
        pajaros.forEach { unPajaro => islaCerditos.sufrirAtaqueDe(unPajaro) }
    }

    method seRecuperaronLosHuevos() = islaCerditos.seQuedoSinObstaculos()

    method incorporarPajaro(nuevoPajaro) = pajaros.add(nuevoPajaro)
    //El nuevoPajaro sería un const "nombrePajaro" = new Pajaros (...)
}

object islaCerditos {
    const obstaculos = []

    method sufrirAtaqueDe(unPajaro) {
        if (!self.seQuedoSinObstaculos() and unPajaro.derriba(self.primerObstaculo())) {
            obstaculos.remove(self.primerObstaculo())
        }
    }

    method primerObstaculo() = obstaculos.first()

    method seQuedoSinObstaculos() = obstaculos.isEmpty()
}