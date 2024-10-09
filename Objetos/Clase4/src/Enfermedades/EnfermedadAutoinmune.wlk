import src.Enfermedades.Enfermedad.*
class EnfermedadAutoinmune inherits Enfermedad{
  var cantidadDeVecesQueAfecto = 0

  method cantidadCelulasAmenazadas() = cantidadCelulasAmenazadas

  override method afectar(unaPersona) {
    unaPersona.destruirCelulas(cantidadCelulasAmenazadas)
    self.aumentarVecesQueAfecto()
  }

  method esAgresivaPara(_unaPersona) = cantidadDeVecesQueAfecto > 30

  method aumentarVecesQueAfecto() {
    cantidadDeVecesQueAfecto += 1
  }
}