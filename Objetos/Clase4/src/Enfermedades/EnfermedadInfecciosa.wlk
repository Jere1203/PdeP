import src.Enfermedades.Enfermedad.*
class EnfermedadInfecciosa inherits Enfermedad{

  method reproducirse() {
    cantidadCelulasAmenazadas *= 2
  }

  method cantidadCelulasAmenazadas() = cantidadCelulasAmenazadas

  override method afectar(unaPersona) {
    unaPersona.aumentarTemperatura(cantidadCelulasAmenazadas / 1000)
  }

  method esAgresivaPara(unaPersona) = 
    cantidadCelulasAmenazadas > unaPersona.cantidadCelulas() * 0.10
}