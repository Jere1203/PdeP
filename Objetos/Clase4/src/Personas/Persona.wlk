class Persona {
  const enfermedades = []
  
  var temperatura
  var cantidadCelulas

  method contraerEnfermedad(unaEnfermedad) {
    enfermedades.add(unaEnfermedad)
  }

  method tiene(unaEnfermedad) = enfermedades.contains(unaEnfermedad)

  method vivirUnDia() {
    enfermedades.forEach { enfermedad => enfermedad.afectar(self) }
  }

  method aumentarTemperatura(unosGrados) {
    temperatura = 45.min(temperatura + unosGrados)
  }

  method destruirCelulas(unaCantidad) {
    cantidadCelulas -= unaCantidad
  }

  method cantidadCelulasAfectadasPorEnfermedadesAgresivas() =
    enfermedades
      .filter { enfermedad => enfermedad.esAgresivaPara(self) }
      .sum { enfermedad => enfermedad.cantidadCelulasAmenazadas() }

  method cantidadCelulas() = cantidadCelulas

  method enfermedadQueMasCelulasAfecta() = enfermedades.max { enfermedad => enfermedad.cantidadCelulasAmenazadas() }

  method estaEnComa() = self.estaDelirando() || self.tienePocasCelulas()

  method estaDelirando() = temperatura == 45

  method tienePocasCelulas() = cantidadCelulas < 1000000

  method vivir(unosDias) {
    unosDias.times { _ => self.vivirUnDia() }
  }

  method atenuarEnfermedades(unaDosis){
    enfermedades.filter{}
  }

  method recibirMedicamento(unaDosis) {
    self.aplicarDosis(unaDosis)
    //self.removerCuradas()
    self.removerEnfermedadesCuradas()
  }

  method aplicarDosis(unaDosis) {
    enfermedades.forEach { enfermedad => enfermedad.atenuarse(unaDosis * 15) }
  }

  // method removerCuradas() {
  //   enfermedades.removeAllSuchThat{enfermedad => enfermedad.estaCurada()}
  // }

  // method curar (unaEnfermedad) {
  //   enfermedades.remove(unaEnfermedad)
  // }
  
  method removerEnfermedadesCuradas() {
    enfermedades.removeAllSuchThat { enfermedad => enfermedad.estaCurada() }
  }

  method disminuirTemperatura(unaCantidad){
    temperatura = 0.max(temperatura - unaCantidad)
  }
}