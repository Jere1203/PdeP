class Expedicion {
    const objetivos
    const integrantes

    method integrantes() = integrantes

    method subir(unVikingo) {
        if (not unVikingo.puedeSubirA(self)) {
            throw new DomainException (message = "No se puede subir")
        }
        integrantes.add(unVikingo)
    }

    method valeLaPena() = objetivos.all { unObjetivo => unObjetivo.valeLaPenaPara(integrantes) }

    method realizar() {
        objetivos.forEach({ unObjetivo => unObjetivo.serInvadidaPor(self) })
    }

    method asignarBotin(unBotin) {
        integrantes.forEach({ unIntegrante => unIntegrante.aumentarBotin(unBotin / self.cantidadIntegrantes()) })
    }

    method cantidadIntegrantes() = integrantes.size()
}

class Capital {
    var defensores
    const factorRiqueza

    method valeLaPenaPara(invasores) = self.botin() >= 3*invasores

    method botin() = defensores * factorRiqueza

    method serInvadidaPor(unaExpedicion) {
        self.aumentarDefensoresDerrotados(unaExpedicion.integrantes())
        unaExpedicion.asignarBotin(self.botin())
    }

    method aumentarDefensoresDerrotados(unaCantidad) {
        defensores -= unaCantidad
    }
}

class Aldea {
    var cantidadCrucifijos

    method botin() = cantidadCrucifijos

    method valeLaPena(_vikingosInvasores) = self.botin() > 15

    method serInvadidaPor(unaExpedicion) {
        unaExpedicion.asignarBotin(self.botin())
        self.perderCrucifijos()
    }

    method perderCrucifijos() {
        cantidadCrucifijos = 0
    }
}

class AldeaAmurallada inherits Aldea {
    const cantidadMinima
    override method valeLaPena(vikingosInvasores) = super(vikingosInvasores) and vikingosInvasores >= cantidadMinima
}