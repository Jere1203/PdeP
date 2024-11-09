class Ciudad inherits Lugar {
    const atracciones
    const habitantes
    const decibeles

    method habitantes() = habitantes

    override method esDivertido() = super() and self.esCiudadDivertida()

    method esCiudadDivertida() = atracciones.size() > 3 and self.habitantes() > 100000

    method tieneMenosDe20Decibeles() = decibeles < 20
}

class Pueblo inherits Lugar {
    const provincia 
    const anioFundacion

    method provincia() = provincia

    override method esDivertido() = super() and self.esAntiguo() or self.esDelLitoral()

    method esAntiguo() = anioFundacion < 1800

    method esDelLitoral() = self.estaEn(entreRios) or self.estaEn(corrientes) or self.estaEn(misiones)

    method estaEn(unaProvincia) = provincia == unaProvincia
}

class Balneario inherits Lugar {
    const metrosDePlaya
    const marPeligroso
    const tienePeatonal

    override method esDivertido() = super() and self.esBalnearioDivertido()

    method esBalnearioDivertido() = metrosDePlaya > 300 and marPeligroso

    method noTienePeatonal() = not tienePeatonal
}

class Lugar {
    const nombre

    method longitudNombre() = nombre.length()

    method esDivertido() = self.longitudNombre().even()

    method tieneNombreRaro() = self.longitudNombre() > 10
}

object entreRios {}

object corrientes {}

object misiones {}

object laPampa {}