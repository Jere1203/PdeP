class Persona {
    var preferencia
    const presupuesto
    
    method puedeIrA(unLugar) = preferencia.leGusta(unLugar)
    
    method preferencia(unaPreferencia) {
        preferencia = unaPreferencia
    }

    method validarPresupuesto(unMonto) = presupuesto >= unMonto
}
