import src.Actividades.*

class Filosofo {
    const nombre
    const honorificos = #{}
    var nivelIluminacion
    var diasVividos
    const actividades = []

    method presentarse() = self.nombre() + honorificos.join(", ")

    method nombre() = nombre

    method estaEnLoCorrecto() = nivelIluminacion > 1000

    method aumentarIluminacion(unaCantidad) {
        nivelIluminacion += unaCantidad
    }

    method nivelIluminacion() = nivelIluminacion

    method rejuvenecerDias(unosDias) {
        diasVividos -= unosDias
    }

    method vivirUnDia() {
        self.realizarActividades()
        self.aumentarDiasVividos(1)
        self.verificarCumpleanios()
    }

    method verificarCumpleanios() {
        if (self.cumpleAnios()) {
            self.aumentarIluminacion(10)
            if (self.edad() == 60) {
                self.agregarHonorifico("El sabio")
            }
        }
    }

    method cumpleAnios() = diasVividos % 365 == 0

    method edad() = diasVividos.div(365)

    method agregarHonorifico(unHonorifico) {
        honorificos.add(unHonorifico)
    }

    method aumentarDiasVividos(unosDias) {
        diasVividos += unosDias
    }

    method realizarActividades() = actividades.all { unaActividad => unaActividad.serRealizadaPor(self) }
}

class FilosofoContemporaneo inherits Filosofo {
    const actividadFavorita

    override method presentarse() = "Hola"

    override method nivelIluminacion() = self.verificarActividadFavorita()

    method verificarActividadFavorita() {   
        if (self.leGusta(admirarElPaisaje)) {
            return nivelIluminacion * 5
        } else {
            return nivelIluminacion
        }
    }

    method leGusta(unaActividad) = actividadFavorita == unaActividad
}

const admirarElPaisaje = new AdmirarPaisaje()