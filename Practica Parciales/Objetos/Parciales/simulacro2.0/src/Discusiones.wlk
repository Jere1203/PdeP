class Argumento {
    const descripcion
    const naturaleza

    method esEnriquecedor() = naturaleza.esEnriquecedor(self)

    method descripcion() = descripcion
}

object estoica {
    method esEnriquecedor(_unArgumento) = true
}

object moralista {
    method esEnriquecedor(unArgumento) = unArgumento.descripcion().length() >= 10
}

object esceptica {
    method esEnriquecedor(unArgumento) = unArgumento.descripcion().endsWith("?")
}

object cinica {
    method esEnriquecedor(unArgumento) = 1.randomUpTo(100) <= 30
}

class Combinada {
    const naturalezas

    method esEnriquecedor(unArgumento) = naturalezas.all { unaNaturaleza => unaNaturaleza.esEnriquecedor() }
}

class Partido {
    const argumentos
    const filosofo

    method esBueno() = self.tieneBuenosArgumentos() and filosofo.estaEnLoCorrecto()

    method tieneBuenosArgumentos() = self.argumentosEnriquecedores() >= self.cantidadArgumentos() / 2

    method argumentosEnriquecedores() = argumentos.count { argumento => argumento.esEnriquecedor() }

    method cantidadArgumentos() = argumentos.size()
}

class Discusion {
    const partido1
    const partido2

    method esBuenaDiscusion() = partido1.esBueno() and partido2.esBueno()
}