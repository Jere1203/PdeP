class Argumento {
    const naturaleza
    const descripcion

    method esEnriquecedor() = naturaleza.esEnriquecedor()

    method descripcion() = descripcion

}

class Estoica inherits Argumento {
    override method esEnriquecedor() = true
}

class Moralista inherits Argumento {
    override method esEnriquecedor() = descripcion.length() >= 10
}

class Esceptica inherits Argumento {
    override method esEnriquecedor() = descripcion.last() == "?"
}

class Cinica inherits Argumento  {
    override method esEnriquecedor() = self.condicionEnriquecedor()

    method condicionEnriquecedor() = 0.randomUpTo(100) <= 30
}

class Combinada inherits Argumento  {
    const naturalezas
    override method esEnriquecedor() = naturalezas.all { unaNaturaleza => unaNaturaleza.esEnriquecedor() }
}