class Plato {
    const cantidadAzucar
    const cocinero

    method calorias() = (3 * cantidadAzucar) + 100

    method cocinero() = cocinero

    method cantidadAzucar() = cantidadAzucar
}

class Entrada inherits Plato (cantidadAzucar = 0) {
    method esBonito() = true
}

class Principal inherits Plato {
    const esBonito

    method esBonito() = esBonito
}

class Postre inherits Plato (cantidadAzucar = 120) {
    const cantidadColores

    method esBonito() = cantidadColores > 3
}
