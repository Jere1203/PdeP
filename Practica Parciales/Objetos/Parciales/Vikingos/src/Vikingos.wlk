class Vikingo {
    var casta
    var botin

    method puedeSubirA(unaExpedicion) = casta.puedeSubir(self) and self.esProductivo()

    method aumentarBotin(unaCantidad) {
        botin += unaCantidad
    }

    method botin() = botin

    method esProductivo()
    
    method agregarDerrota(unaDerrota) {}

    method ascender() = casta.ascender(self)

    method perteneceA(unaCasta) = casta == unaCasta

    method casta() = casta

    method casta(unaCasta) {
        casta = unaCasta
    }

}

object jarl {
    method puedeSubir(unVikingo) = not self.tieneArmas(unVikingo)

    method tieneArmas(unVikingo) = not unVikingo.armas().isEmpty()

    method ascender(unVikingo) {
        unVikingo.casta(karl)
        unVikingo.conseguirPorAscenso()
    } 
}

object karl{
    method puedeSubir(_unVikingo) = true

    method ascender(unVikingo) {
        unVikingo.casta(thrall)
    }
}

object thrall{
    method puedeSubir(_unVikingo) = true

    method ascender(unVikingo) {}
}

class Soldado inherits Vikingo {
    var asesinatos
    var armas

    override method agregarDerrota(unaDerrota) {
        asesinatos += unaDerrota
    }

    method armas() = armas

    override method esProductivo() = asesinatos > 20 and self.tieneArmas()

    method tieneArmas() = not armas.isEmpty()

    method conseguirPorAscenso() {
        self.ganarArmas(10)
    }

    method ganarArmas(unasArmas) {
        armas += unasArmas
    }
}

class Granjero inherits Vikingo {
    var hectareas
    var cantidadHijos

    method obtenerPorAscenso() {
        self.tenerHijos(2)
        self.conseguirHectareas(2)
    }

    method armas() = []

    method tenerHijos(unaCantidad) {
        cantidadHijos += unaCantidad
    }

    method conseguirHectareas(unasHectareas) {
        hectareas += unasHectareas
    }

    override method esProductivo() = hectareas == 2*cantidadHijos
}