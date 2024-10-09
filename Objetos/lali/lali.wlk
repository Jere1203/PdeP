// // Objetos/lali/lali.wlk
// // Objetos/lali/lali.wlk
// class Funcion {
//   var predio
//   var asientos = [new Asiento()]
//   method venderEntrada(persona) {
//     predio.asignarAsiento(persona)
//   }
// }

// class Predio {
//   method asignarAsiento(persona) {
    
//   }
// }

// class Asiento{
//   var persona
//   method estaOcupado(persona)
//   method asignar(otraPersona) {
//     persona = otraPersona
//   }
// }

// class Estadio {
//   var capacidadCampo
//   method capacidadCampo(unaCapacidad) {
//     capacidadCampo = unaCapacidad
//   }
//   method capacidadPlateaAlta(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
//   method capacidadPlateaBaja(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
//   method capacidadPlateaPreferencial(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)

//   method cantidadAsientos (cantidadFilas, asientosPorFila) = cantidadFilas * asientosPorFila
// }

// class Teatro{
//   method capacidadPlateaAlta(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
//   method capacidadPlateaBaja(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)
//   method capacidadPlateaPreferencial(cantidadFilas, asientosPorFila) = self.cantidadAsientos(cantidadFilas, asientosPorFila)

//   method cantidadAsientos (cantidadFilas, asientosPorFila) = cantidadFilas * asientosPorFila
// }

// const showDeTaylor = new Estadio()

// const showDeMcCartney = showDeTaylor

// const showDeLali = new Teatro()

// const hamletDeBurzaco = new Teatro()

// const laNuevaDeSuar = new Teatro()