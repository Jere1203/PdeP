class Persona {
  const enfermedades[]

  method contraerEnfermedad(unaEnfermedad) {
    enfermedades.add(unaEnfermedad)
  }

  method aumentarTemperatura(unosGrados) {
    temperatura = temperatura + unosGrados
  }

  method destruirCelulas(unasCelulas){
    celulas = celulas - unasCelulas
  }

}

class EnfermedadInfecciosa {
  var celulasAmenazadas
  method aumentaTemperatura(unaPersona) {
    unaPersona.aumentarTemperatura(celulasAmenazadas/1000)
  }

  method reproducirse() = 2*celulasAmenazadas
}

class EnfermedadAutoinmune {
  var celulasAmenazadas

  method destruirCelulas(unaPersona) {
    unaPersona.destruirCelulas(celulasAmenazadas)
  }

}