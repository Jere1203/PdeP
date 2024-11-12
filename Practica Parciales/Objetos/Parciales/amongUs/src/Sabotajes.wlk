import src.Nave.*
class ReducirOxigeno {
  method serRealizadoPor(unJugador) {
    if(not nave.hayTuboDeOxigeno()) {
      nave.reducirOxigeno(10)
      unJugador.aumentarSospecha(5)
    }
  }
}

class ImpugnarJugador {
  const jugadorImpugnado

  method serRealizadoPor(unJugador) {
    jugadorImpugnado.votaEnBlanco()
  }
}