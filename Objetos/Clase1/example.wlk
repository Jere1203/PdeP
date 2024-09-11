object francoColapinto{
  var auto = williams
  var peso = 70
  method chamuyar() {
    return "Me contaron que sos muy divertida"
  }

  method correr(kilometros) {
    peso = peso - kilometros / 50
    auto.correr(kilometros)
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
    nafta = nafta - kilometros/7
  }
}

object ferrari {
  var nafta = 10
  var bateria = 80

  method correr(kilometros) {
    nafta = nafta - kilometros / 7
    if (kilometros >= 100) {
      bateria = bateria - (kilometros - 100) / 100
    }
  }
}