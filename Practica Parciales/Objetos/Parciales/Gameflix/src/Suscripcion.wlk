object premium {
  const juegos = #{}
  const precio = 50

  method precio() = precio

  method juegosPermitidos() = juegos

}

object base {
  const juegos = #{}
  const precio = 25

  method precio() = precio

  method juegosPermitidos() {
    return juegos.filter { unJuego => unJuego.precio() < 30}
  }
}

object infantil {
  const juegos = #{}
  const precio = 10

  method precio() = precio

  method juegosPermitidos() {
    return juegos.filter { unJuego => unJuego.categoria() == "Infantil"}
  }
}

object prueba {
  const juegos = #{}
  const precio = 0

  method precio() = precio

  method juegosPermitidos() {
    return juegos.filter {unJuego => unJuego.categoria() == "Demo"}
  }
}