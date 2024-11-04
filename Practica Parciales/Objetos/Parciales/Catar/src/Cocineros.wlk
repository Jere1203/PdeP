import Platos.*
class Cocinero{
    var especialidad

    method cocinar() = especialidad.cocinar()

    method catar(unPlato) = especialidad.calificar(unPlato)

    method especialidad(unaEspecialidad) {
        especialidad = unaEspecialidad
    }

    method especialidad() = especialidad

    method es(unaEspecialidad) = self.especialidad() == unaEspecialidad

    method participarEn(unTorneo) {
        const plato = self.cocinar()
        unTorneo.participantes(plato)
    }
}

class Pastelero  {
    const dulzorDeseado

    method calificar(unPlato) = 10.min(self.calculoCalificacionPara(unPlato))

    method calculoCalificacionPara(unPlato) = 5 * unPlato.cantidadAzucar() / dulzorDeseado
 
    method dulzorDeseado() = dulzorDeseado

    method cocinar() = new Postre(cocinero = self, cantidadColores = dulzorDeseado / 50)
}

class Chef {
    const caloriasMaximas

    method calificar(unPlato) {
        if (self.esPlatoDiez(unPlato)) {
            return 10
        } else {
            return 0
        }
    }

    method esPlatoDiez(unPlato) = unPlato.esBonito() and unPlato.calorias() < caloriasMaximas

    method cocinar() = new Principal(cocinero = self, esBonito = true, cantidadAzucar = caloriasMaximas)
}

class SousChef inherits Chef {
    override method calificar(unPlato) {
        if (self.esPlatoDiez(unPlato)) {
            return 10
        } else {
            return 6.max(unPlato.calorias() / 100)
        }
    }

    override method cocinar() = new Entrada(cocinero = self)
}