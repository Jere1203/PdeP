object francoColapinto{
  var auto = williams
  var peso = 70
  method chamuyar() {
    return "Me contaron que sos muy divertida"
  }

  method correr(kilometros) {
    self.perderPeso(kilometros)
    auto.correr(kilometros)
  }
  
  method perderPeso(kilometros) {
    peso = peso - kilometros / 50
  }

  //Getter
  method peso() {
    return peso
  
  }
  //Setter
  method cambiarAuto(nuevoAuto) { //No usar cambiarAuto -> convención: método se llama igual que el atributo
    auto = nuevoAuto
  }
}

object williams {
  var nafta = 100
  method correr(kilometros){
    self.gastarNafta(kilometros)
  }

  method gastarNafta(kilometros) {
    nafta = nafta - kilometros / 7
  }
}

object ferrari {
  var nafta = 10
  var bateria = 80

  method correr(kilometros) {
    self.gastarNafta(kilometros)
    self.gastarBateria(kilometros)
  }

  method gastarNafta(kilometros) {
    nafta = nafta - kilometros / 7
  }

  method gastarBateria(kilometros) {
    if (kilometros >= 100) {
      bateria = bateria - (kilometros - 100) / 100
    }
  }
}