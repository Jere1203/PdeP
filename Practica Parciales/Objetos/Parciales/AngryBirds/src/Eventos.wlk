class SesionManejoIra {
    method tranquilizarA(unPajaro) {
        unPajaro.tranquilizarse(5)
    }
}

class InvasionCerditos {
    const cantidadCerditos

    method vecesQueInvaden() = cantidadCerditos / 100

    method afectarA(unPajaro) {
        self.vecesQueInvaden().times { _ => unPajaro.enojarse() }

    }
}

class FiestaSorpresa {
    const pajarosHomenajeados = []

    method afectarA(unPajaro) {
        self.esHomenajeado(unPajaro)
        unPajaro.enojarse()
    }

    method esHomenajeado(unPajaro) = pajarosHomenajeados.contains(unPajaro)
}

class EventosDesafortunados {
    const eventos = []

    method eventosDesafortunados(unPajaro) {
        eventos.anyOne { evento => evento.afectarA(unPajaro) }
    }
}