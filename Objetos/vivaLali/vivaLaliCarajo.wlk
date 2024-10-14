class Funcion{
  const property artista
  const property fecha
  const property asientosPlateaBaja
  const property filasPlateaBaja
  const property asientosPlateaAlta
  const property filasPlateaAlta
  const property asientosPlateaPreferencial
  const property filasPlateaPreferencial

  const asientosLibres = []
  method estaAgotada() {
    asientosLibres.isEmpty()
  }
  method asignarAsiento(unaPersona) {
    asientosLibres.add(unaPersona)
  }
  method reasignarAsiento(unaPersona, otraPersona) {
    /*Busca el asiento de "unaPersona" y lo cambia con el de "otraPersona"*/
  }

  method capacidadPlateaBaja() = asientosPlateaBaja * filasPlateaBaja

  method capacidadPlateaAlta() = asientosPlateaAlta * filasPlateaAlta

  method capacidadPlateaPreferencial () = asientosPlateaPreferencial * filasPlateaPreferencial
}

class Concierto inherits Funcion {
  const capacidadCampo

  const property recinto


  method capacidadConcierto(){
    if (recinto == "estadio"){
      return self.capacidadPlateaBaja() + self.capacidadPlateaAlta() + self.capacidadPlateaPreferencial() + capacidadCampo
    }
    else {
      return  self.capacidadPlateaBaja() + self.capacidadPlateaAlta() + self.capacidadPlateaPreferencial()
    }
  } 

}

class Obra inherits Funcion {
  const property teatro
  const property director
  const property fechaApertura
  const property horaApertura

  method capacidadObra() {
    return self.capacidadPlateaBaja() + self.capacidadPlateaAlta() + self.capacidadPlateaPreferencial()
  }

}