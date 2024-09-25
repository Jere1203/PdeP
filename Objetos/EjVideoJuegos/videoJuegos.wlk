object delfina {
  var consola = play
  var diversion = 0
  method diversion() = diversion
  method jugar(videoJuego){
    diversion = diversion + videoJuego.diversion(consola)
    consola.usar()
  } 
  method agarrar(unaConsola) {
    consola = unaConsola
  }
}

object play {
  method jugabilidad() {
    return 10
  }
  method usar() {}
}

object portatil {
  var bateriaBaja = false
  method jugabilidad() {
    if(bateriaBaja) return 1
    else{
      return 8
    }
  }
  method usar() {
    bateriaBaja = true
  }
}

object arkanoid {
  method diversion(unaConsola) {
    return 50
  }
}

object mario {
  method diversion(unaConsola) {
    if(unaConsola.jugabilidad() > 5){
      return 100
    }
    else{
      return 15
    }
  }
}

object pokemon {
  method diversion(unaConsola) {
    return 10 * unaConsola.jugabilidad()
  }
}