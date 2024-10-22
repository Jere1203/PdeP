import Suscripcion.*
class Cliente {
  var suscripcion
  var saldo
  var humor

  method suscripcion() = suscripcion

  method suscripcion(nuevoPlan) {
    suscripcion = nuevoPlan
  }

  method pagarSuscripcion() {
    if(saldo < suscripcion.precio()){
      self.suscripcion(prueba)
    }
  }

  method reducirHumor(cantidadHumor) {
    humor -= cantidadHumor
  }

  method aumentarHumor(cantidadHumor) {
    humor += cantidadHumor
  }
  
  method gastarDinero(cantidadDinero) {
    saldo -= cantidadDinero
  }
}