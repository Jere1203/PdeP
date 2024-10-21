class GrupoSanguineo {
    const gruposCompatibles = #{}

    method agregarGrupo(unGrupo) {
        gruposCompatibles.add(unGrupo)
    }

    method esCompatibleCon(otroGrupo) {
        return gruposCompatibles.contains(otroGrupo)
    }
}