class Persona {
  const enfermedades = []
  var property celulas
  var temperatura

  method estaEnComa(){
    temperatura >= 45
  }

  method contraerEnfermedad(unaEnfermedad) {
    enfermedades.add(unaEnfermedad)
  }

  method tieneEnfermedad(unaEnfermedad) = enfermedades.contains(unaEnfermedad)

  method aumentarTemperatura(unosGrados) {
    temperatura = 45.min(temperatura + unosGrados)
  }

  method destruirCelulas(unasCelulas){
    celulas = celulas - unasCelulas
  }

  method vivirUnDia() {
    enfermedades.forEach{enfermedad => enfermedad.sufrirEnfermedad(self)}
  }

  method recibirMedicamento(unaCantidad) {
    enfermedades.forEach{ enfermedad => enfermedad.atuenuarse(unaCantidad) }
    enfermedades.removeAllSuchThat { enfermedad => enfermedad.estaCurada() }
  }

}