class Gameflix{
  const juegos = #{}
  const clientes = #{}

  method filtrarPorCategoria(unaCategoria){
      juegos.filter {unJuego => unJuego.categoria() == unaCategoria}
  }

  method buscar(unJuego){
      if (!juegos.contains(unJuego)) {
          throw new DomainException(message = "No se encuentra el juego solicitado")
      } else {
          return true
      }
  }

  method recomendarJuego() = juegos.anyOne()

  method cobrarSuscripcion(unaPersona) {
    clientes.forEach { unCliente => unCliente.pagarSuscripcion()}
  }
}