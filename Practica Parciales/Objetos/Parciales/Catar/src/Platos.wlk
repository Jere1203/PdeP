class Plato {
    const cantidadAzucar
    const cocinero

    method calorias() = (3 * cantidadAzucar) + 100
    method esBonito()
    method cocinero() = cocinero

    method cantidadAzucar() = cantidadAzucar
}

class Entrada inherits Plato (cantidadAzucar = 0) {
    override method esBonito() = true
}

class Principal inherits Plato {
    const esBonito

    override method esBonito() = esBonito
}

class Postre inherits Plato (cantidadAzucar = 120) {
    const cantidadColores

    override method esBonito() = cantidadColores > 3
}
