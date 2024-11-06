import src.Filosofo.*
import src.Deportes.*

class TomarVino {
    method actividadRealizadaPor(unFilosofo) {
        unFilosofo.nivelIluminacion(-10)
        unFilosofo.agregarHonorifico("El borracho")
    }
}

class JuntarseEnElAgora {
    const otroFilosofo

    method actividadRealizadaPor(unFilosofo) {
        unFilosofo.iluminacion(otroFilosofo.iluminacion()/10)
    }
}

class AdmirarUnPaisaje {}

class MeditarBajoCascada {
    const metrosCascada

    method actividadRealizadaPor(unFilosofo) {
        unFilosofo.iluminacion(10*metrosCascada)
    }
}

class PracticarDeporte {
    const deporte

    method actividadRealizadaPor(unFilosofo) {
        unFilosofo.rejuvenecer(deporte.rejuvenecer())
    }
}