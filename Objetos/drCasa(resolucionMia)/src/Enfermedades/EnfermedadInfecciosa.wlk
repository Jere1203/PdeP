import src.Enfermedades.Enfermedad.*
class EnfermedadInfecciosa inherits Enfermedad {
  
  method aumentarTemperatura(unaPersona) {
    unaPersona.aumentarTemperatura(celulasAmenazadas/1000)
  }

  method celulasAmenazadas() = celulasAmenazadas 

  override method sufrirEnfermedad(unaPersona) {
    self.aumentarTemperatura(unaPersona)
  }
  method reproducirse() = 2*celulasAmenazadas

  method esEnfermedadAgresiva(unaPersona){
    celulasAmenazadas > unaPersona.celulas()
  }
}