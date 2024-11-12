class TomarVino {
    method serRealizadaPor(unFilosofo) {
        unFilosofo.disminuirIluminacion(10)
        unFilosofo.agregarHonorifico("El borracho")
    }
}

class JuntarseEnElAgora {
    const otroFilosofo
    method serRealizadaPor(unFilosofo) {
        unFilosofo.aumentarIluminacion(otroFilosofo.nivelIluminacion() / 10)
    }
}

class AdmirarPaisaje {
    method serRealizadaPor(unFilosofo) {}
}

class MeditarBajoCascada {
    const longitudCascada

    method serRealizadaPor(unFilosofo) {
        unFilosofo.aumentarIluminacion(10 * longitudCascada)
    }
}

class PracticarDeporte {
    const deporte

    method serRealizadaPor(unFilosofo) = deporte.afectarA(unFilosofo)
}

object futbol {
    method afectarA(unFilosofo) {
        unFilosofo.rejuvenecerDias(1)
    }
}

class Polo {
    method afectarA(unFilosofo) {
        unFilosofo.rejuvenecerDias(2)
    }
}

class Waterpolo inherits Polo {
    override method afectarA(unFilosofo) {
        super(unFilosofo).times(2)
    }
}