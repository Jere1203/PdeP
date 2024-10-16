import src.Enfermedades.Enfermedad.*
class EnfermedadAutoinmune inherits Enfermedad{
  var vecesQueAfecto = 0

  method destruirCelulas(unaPersona) {
    unaPersona.destruirCelulas(celulasAmenazadas)
  }

  method celulasAmenazadas() = celulasAmenazadas

  override method sufrirEnfermedad(unaPersona){
    unaPersona.destruirCelulas(celulasAmenazadas)
    self.aumentarVecesQueAfecto()
  }

  method aumentarVecesQueAfecto(){
    vecesQueAfecto += 1
  }
  method esEnfermedadAgresiva(unaPersona){
    vecesQueAfecto > 30
  }
}