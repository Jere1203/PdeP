class Grupos {
    const integrantes = #{}

    method puedenSalirDe(unaSala) = integrantes.any { unIntegrante => unIntegrante.puedeSalirDe(unaSala) }

    method pagar(unaSala) {
        const cuantoPagan = self.precioPorPersona(unaSala)
        integrantes.forEach { unIntegrante => unIntegrante.pagar(cuantoPagan) }
    } 
    method precioPorPersona(unaSala) = unaSala.precio() / integrantes.size()

    method puedenPagarLaEntradaA(unaSala) = self.puedenPagarCadaEntradaA(unaSala) or self.saldoGrupo() >= unaSala.precio()

    method puedenPagarCadaEntradaA(unaSala) = integrantes.all { integrante => integrante.puedePagar(unaSala) }

    method saldoGrupo() = integrantes.sum { integrante => integrante.saldo() }

    method escaparDe(unaSala) {
        if (!self.puedenPagarCadaEntradaA(unaSala)) {
            throw new DomainException(message = "No pudieron pagar la entrada")
        } else if (!self.puedenSalirDe(unaSala)) {
            throw new DomainException(message = "No pudieron escapar de la sala")
        }
        else {
            self.pagar(unaSala)
            integrantes.forEach { unIntegrante => unIntegrante.escaparDe(unaSala) }
        }
    }

    // method sumatoriaDeSaldosCubreLaEntradaA(unaSala) = 
    // integrantes.filter { unIntegrante => unIntegrante.puedePagar(unaSala) }
    // .sum { unIntegrante => unIntegrante.saldo() } >= unaSala.precio()

}