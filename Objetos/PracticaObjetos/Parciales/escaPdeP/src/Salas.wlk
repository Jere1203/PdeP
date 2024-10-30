class Sala {
  const dificultad
  const nombre
  
  method precio() = 10000

  method esSalaDificil() = dificultad > 7

  method nombre() = nombre
}

class Anime {
  method precio() = 7000
}

class Historia inherits Sala{
  const basadaEnHechosReales

  override method precio() = super() + dificultad * 1.314

  override method esSalaDificil() = super() and !basadaEnHechosReales
}

class Terror inherits Sala{
  const cantidadSustos
  override method precio() = super() + self.aumentoSegunSustos()

  method aumentoSegunSustos() {
    if (cantidadSustos > 5){
      return cantidadSustos * 0.2
    } else {
      return 0
    }
  }

  override method esSalaDificil() = super() or cantidadSustos > 5
}