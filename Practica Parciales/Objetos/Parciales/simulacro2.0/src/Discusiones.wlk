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

    method filosofo() = filosofo

    method mitadDeArgumentosEnriquecedores() = self.argumentosEnriquecedores() >= argumentos.size()

    method argumentosEnriquecedores() = argumentos.filter { argumento => argumento.esEnriquecedor() }.size()

    method filosofoEstaEnLoCorrecto() = filosofo.estaEnLoCorrecto()
}

class Discusion {
    method esBuenaDiscusionCon(unPartido, otroPartido) = self.mitadDeArgumentosEnriquecedores(unPartido, otroPartido) and self.ambosFilosofosCorrectos(unPartido, otroPartido)

    method mitadDeArgumentosEnriquecedores(unPartido, otroPartido) = unPartido.mitadDeArgumentosEnriquecedores() and otroPartido.mitadDeArgumentosEnriquecedores()

    method ambosFilosofosCorrectos(unPartido, otroPartido) = unPartido.filosofoEnLoCorrecto() and otroPartido.filosofoEnLoCorrecto()
}