class Pais {
    const juegos = []

    const prohibiciones = []

    method esAptoParaMenores(unJuego) = not prohibiciones.forEach { unaProhibicion => unJuego.caracteristicas().contains(unaProhibicion) }

    method convertirAMonedaLocal(unPrecio) = unPrecio * 1500

    method promedioPrecioFinal() = 
        juegos.filter({ unJuego => unJuego.esAptoParaMenores(unJuego) }).precio() / juegos.size()
        .convertirAMonedaLocal()
}