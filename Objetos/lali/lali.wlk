class Funcion {
  var predio
  var asientos = []
  method venderEntrada(persona) {
    predio.asignarAsiento(persona)
  }
}

class Predio {
  method asignarAsiento(persona) {
    
  }
}

class Asiento{
  var persona
  method estaOcupado(unaPersona)
  method asignar(otraPersona) {
    persona = otraPersona
  }
}

class Estadio {
  var capacidadCampo
  method capacidadCampo(unaCapacidad) {
    capacidadCampo = unaCapacidad
  }
  method capacidadPlateaAlta(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
  method capacidadPlateaBaja(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
  method capacidadPlateaPreferencial(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)

  method cantidadAsientos (cantidadFilas, asientosPorFila) = cantidadFilas * asientosPorFila
}

class Teatro{
  method capacidadPlateaAlta(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
  method capacidadPlateaBaja(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
  method capacidadPlateaPreferencial(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)

  method cantidadAsientos (cantidadFilas, asientosPorFila) = cantidadFilas * asientosPorFila
}