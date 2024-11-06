import src.Mision.*
class Empleado {
    var salud
    const habilidades = []
    var puesto

    method habilidades() = habilidades

    method estaIncapacitado() = salud < puesto.saludCritica()

    method puedeUsar(unaHabilidad) = !self.estaIncapacitado() and self.tieneHabilidad(unaHabilidad)

    method tieneHabilidad(unaHabilidad) = habilidades.contains(unaHabilidad)

    method cumplir(unaMision) = puesto.cumplir(unaMision, self)

    method recibirDanio(unDanio) {
        salud -= unDanio
    }    

    method finalizarMision(unaMision) = puesto.terminar(unaMision)

    method sobrevivio() = salud > 0

    method cambiarPuesto(unPuesto) {
        puesto = unPuesto
    }
}

class Equipo {
    const integrantes = []
    method cumplir(unaMision) = integrantes.forEach { unPuesto => unPuesto.cumplir(unaMision, self) }

    method recibirDanio(unDanio) {
        integrantes.forEach { unIntegrante => unIntegrante.recibirDanio(unDanio/3) }
    }

    method finalizarMision(unaMision) {
        integrantes.forEach { empleado => empleado.finalizarMision(unaMision) }
    }
}

object espia {
    const habilidades = []

    method saludCritica() = 15
    method cumplir(unaMision, unaPersona) = unaMision.esCumplidaPor(unaPersona)

    method terminar(unaMision) = self.aprenderHabilidades(unaMision.hablidadesNecesarias())

    method aprenderHabilidades(unasHabilidades) = habilidades.concat(unasHabilidades)
}

class Oficinista inherits Empleado {
    var estrellas = 0
    method saludCritica() = 40 - 5*estrellas
    method cumplir(unaMision, unaPersona) = unaMision.esCumplidaPor(unaPersona)

    method terminar(unaMision) {
        self.agregarEstrellas(1)
        self.verificarEstrellas()
    } 

    method verificarEstrellas() {
        if (estrellas >= 3) {
            self.cambiarPuesto(espia)
        }
    }

    method agregarEstrellas(cantidadEstrellas) {
        estrellas += cantidadEstrellas
    }
}

class Jefe inherits Empleado {
    const subordinados = #{}

    override method puedeUsar(unaHabilidad) = super(unaHabilidad) and self.habilidadesDeSubordinados().contains(unaHabilidad)

    method habilidadesDeSubordinados() = subordinados.map { unSubordinado => unSubordinado.habilidades() }
    
}   