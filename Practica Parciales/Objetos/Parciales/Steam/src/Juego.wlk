import src.Descuento.*

class Juego {
  const precio
  var descuento
  const caracteristicas
  const criticas


  method precio() = descuento.precio(self)

  method mitadDePrecio() = precio / 2

  method cambiarDescuento(unDescuento) {
    descuento = unDescuento
  }

  method caracteristicas() = caracteristicas

  method agregarCritica(unaCritica) {
    criticas.add(unaCritica)
  }
}