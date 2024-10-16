class Enfermedad{
  var celulasAmenazadas

  method atuenuarse(unaCantidad){
      celulasAmenazadas -= unaCantidad
  }

  method agravarse(unaCantidad){
    celulasAmenazadas += unaCantidad
  }

  method estaCurada() {
    celulasAmenazadas <= 0
  }

  method sufrirEnfermedad(unaPersona)

}