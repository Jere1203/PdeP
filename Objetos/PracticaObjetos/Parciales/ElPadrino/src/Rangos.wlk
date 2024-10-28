class Don {
    const subordinados = #{}

    method atacarA(unaPersona) {
        subordinados.filter{ unSubordinado => unSubordinado.esSubjefe() or unSubordinado.esSoldado() }.anyOne().atacarA(unaPersona)
    }

    method sabeDespacharElegantemente(_unIntegrante) = true

    method subordinadoMasLeal() {
        subordinados.max { subordinado => subordinado.lealtad() }
    }
}

object donVito inherits Don{
    override method atacarA(unaPersona) {
        super(unaPersona).times(2)
    }
}

class SubJefe {
    const armas = #{}
    const subordinados = #{}

    method atacarA(unaPersona) {
        armas.anyOne{ unArma => unArma.utilizarContra(unaPersona) }
    }

    method sabeDespacharElegantemente(unIntegrante) = subordinados.any().tieneArmaSutil()
}

class Soldado {
    const armas = #{}

    method atacarA(unaPersona) {
        armas.head{ unArma => unArma.utilizarContra(unaPersona) }
    }

    method obtenerArma(unArma) {
        armas.add(unArma)
    }
    
    method sabeDespacharElegantemente(unIntegrante) = unIntegrante.tieneArmaSutil()
}