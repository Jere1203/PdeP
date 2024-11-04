import Platos.*
class Cocinero{
    var especialidad

    method cocinar() = especialidad.cocinar(self)

    method catar(unPlato) = especialidad.calificar(unPlato)

    method especialidad(unaEspecialidad) {
        especialidad = unaEspecialidad
    }

    method especialidad() = especialidad

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

    method cocinar(unCocinero) = new Postre(cocinero = unCocinero, cantidadColores = dulzorDeseado / 50)
}

class Chef {
    const caloriasMaximas

    method calificar(unPlato) {
        if (self.esPlatoDiez(unPlato)) {
            return 10
        } else {
            self.malaCalificacion(unPlato)
        }
    }

    method esPlatoDiez(unPlato) = unPlato.esBonito() and unPlato.calorias() < caloriasMaximas
    method malaCalificacion(_unPlato) = 0
    method cocinar(unCocinero) = new Principal(cocinero = unCocinero, esBonito = true, cantidadAzucar = caloriasMaximas)
}

class SousChef inherits Chef {
    override method malaCalificacion(unPlato) = 6.max(unPlato.calorias() / 100)

    override method cocinar(unCocinero) = new Entrada(cocinero = unCocinero)
}