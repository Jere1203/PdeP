class Arbol {
    const tarjetas = []
    const regalos = []
    const adornos = []

    method beneficiarios() = self.beneficiariosTarjetas() + self.beneficiariosRegalos()

    method beneficiariosTarjetas() = tarjetas.filter { unaTarjeta => unaTarjeta.destinatario() }

    method beneficiariosRegalos() = regalos.filter { unRegalo  => unRegalo.destinatario() }

    method costoBeneficiariosRegalos() = regalos.sum {unRegalo => unRegalo.precio()}

    method importanciaDelArbol() = adornos.sum { unAdorno => unAdorno.importancia() }

    method esRegaloTeQuierenMucho(unRegalo) = unRegalo.precio() > self.umbralPrecioPromedioRegalos()

    method umbralPrecioPromedioRegalos() = self.costoBeneficiariosRegalos() / regalos.size()

    method potentoso() = regalos.filter {unRegalo => self.esRegaloTeQuierenMucho(unRegalo)} > 5 or tarjetas.any { unaTarjeta => unaTarjeta.valorAdjunto() >= 1000 }

    method adornoMasPesado() = adornos.max { unAdorno => unAdorno.peso() }
}

class Regalos {
    const precio
    const destinatario

    method precio() = precio

    method destinatario() = destinatario
}

class Tarjetas {
    const precio = 2
    const destinatario
    const valorAdjunto

    method valorAdjunto() = valorAdjunto

    method destinatario() = destinatario

    method precio() = precio
}

class Adornos {
    const peso
    const coeficienteSuperioridad

    method importancia() = peso * coeficienteSuperioridad
}

class Luces inherits Adornos{
    const cantidadLamparitas


    method importancia(unCoeficienteDeImportancia) = unCoeficienteDeImportancia * self.luminosidad()

    method luminosidad() = cantidadLamparitas
}

class Figuras inherits Adornos{
    const volumenFigura

    method importancia(unCoeficienteDeImportancia) = unCoeficienteDeImportancia * volumenFigura

    method volumenFigura() = volumenFigura
}

class Guirnalda inherits Adornos {
    const anioCompra

    method peso() = peso - 100 * anioCompra
}