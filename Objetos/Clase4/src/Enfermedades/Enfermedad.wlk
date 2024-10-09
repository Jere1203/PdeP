class Enfermedad{
  var cantidadCelulasAmenazadas

  method atenuarse(cantidadCelulas) {
    cantidadCelulasAmenazadas -= cantidadCelulas
  }

  method estaCurada() {
    cantidadCelulasAmenazadas <= 0
  }
  method afectar(unaPersona) //Clase abstracta
}

object laMuerte {
  method afectar(unaPersona) {
    unaPersona.disminuirTemperatura(unaPersona.temperatura())
  }
}
//Como hubo comportamiento repetido (en este caso con el método "atenuarse") entre enfermedadAutoinmune y enfermedadInfecciosa
//entonces necesito "cosificar" a esta interfaz conocida como "Enfermedad"

//Como quiero que no se instancie esta clase defino una clase abstracta, que es una clase que no se puede instanciar y para esto defino un método abstracto
//Por ej:
// method unMetodo() (Va sin llaves y sin = )