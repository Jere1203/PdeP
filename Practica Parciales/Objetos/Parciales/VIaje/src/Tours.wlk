class Tour {
    const espacio
    const personasAnotadas
    const ciudadesARecorrer
    const monto

    method monto() = monto

    method montoTotalPorPersona() = monto * personasAnotadas.size()

    method agregarAlTour(unaPersona) {
        if (not self.validarEspacio()) {
            throw new DomainException(message = "No hay mas espacio en el tour")
        }
        unaPersona.validarPresupuesto(monto)
        if (not self.validarCiudades(unaPersona)) {
            throw new DomainException(message="Hay un lugar no adecuado para la persona")
        }
        personasAnotadas.add(unaPersona)
    }

    method bajarDelTour(unaPersona) {
        personasAnotadas.remove(unaPersona)
    }

    method validarCiudades(unaPersona) = ciudadesARecorrer.forEach({ unLugar => unaPersona.puedeIrA(unLugar) })

    method validarEspacio() = personasAnotadas.size() <= espacio
 
    method esTourPendiente() = personasAnotadas < espacio
}