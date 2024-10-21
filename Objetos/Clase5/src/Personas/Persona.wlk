import GrupoSanguineo.*
import FactorSanguineo.*

class Persona {
  const enfermedades = []
  const grupoSanguineo
  const factorSanguineo

  var temperatura
  var cantidadCelulas

  method hacerTransfusion(otraPersona, unaCantidad) {
    if(self.esCompatibleCon(otraPersona) and self.puedeDonar(self)){
      otraPersona.aumentarCelulas(unaCantidad)
      self.reducirCelulas(unaCantidad)
    }
    else {
      throw new DomainException(message = "No se puede hacer la transfusion")
    }
  }

  method puedeDonar(unaPersona) {
    return cantidadCelulas.between(500, cantidadCelulas / 4)
  }

  method aumentarCelulas(unaCantidad) {
    cantidadCelulas += unaCantidad
  }

  method esCompatibleCon(otraPersona) {
    return grupoSanguineo.esCompatible(otraPersona.grupoSanguineo()) && factorSanguineo.puedeDonar(otraPersona.factorSanguineo())
  }

  method reducirCelulas(unaCantidad) {
    cantidadCelulas -= unaCantidad
  }

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