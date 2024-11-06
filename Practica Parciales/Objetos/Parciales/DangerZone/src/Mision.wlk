import src.Empleados.*

class Mision {
    const habilidadesNecesarias = []
    const peligrosidad

    method habilidadesNecesarias() = habilidadesNecesarias

    method esCumplidaPor(unIntegrante) {
        self.validarHabilidades(unIntegrante)
        unIntegrante.recibirDanio(peligrosidad)
        unIntegrante.finalizarMision()
    }

    method validarHabilidades(unIntegrante) {
        const habilidadesUnIntegrante = unIntegrante.habilidades()
        if (!habilidadesUnIntegrante.contains(habilidadesNecesarias)) {
            throw new DomainException(message = "No se puede hacer la mision")
        }
    }


}