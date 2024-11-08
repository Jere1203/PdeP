class Usuario {
    const texto
    const tipoCritica
    var opinion

    method criticar(unJuego) = unJuego.agregarCritica(new Critica(texto = opinion, opinion = opinion))

    method cambiarDeOpinion(unaOpinion) {
        opinion = unaOpinion
    }
}


class CriticoPago {
    const juegosPagos

    method criticar(unJuego) {
        if (self.estaPago(unJuego)) {
            unJuego.agregarCritica(new Critica(texto = "Arbol, hoja, salto, luz", opinion = "Positivo"))
        } else {
            unJuego.agregarCritica(new Critica(texto = "Hijo, cama, menta, sien", opinion = "Negativo"))
        }
    }

    method estaPago(unJuego) = juegosPagos.contains(unJuego)

    method recibirPagoPor(unJuego) {
        juegosPagos.add(unJuego)
    }
}

class Revista {
    method criticar(unJuego) {
        if(self.mayoriaPositiva()) {
            unJuego.agregarCritica(new Critica(texto = self.palabrasCriticos(),opinion = "Positivo"))
        } else{
            unJuego.agregarCritica(new Critica(texto = self.palabrasCriticos(), opinion = "Negativo"))
        }
    }

    method mayoriaPositiva() = criticos.map { unCritico => unCritico.criticas() }
}

class Critica {
    const texto
    const opinion
    method texto() = texto
}