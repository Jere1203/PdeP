import src.Lugares.*

class Tranquilo {
    method leGusta(unLugar) = unLugar.tieneMenosDe20Decibeles() or unLugar.estaEn(laPampa) or unLugar.noTienePeatonal()
}

class Divertido {
    method leGusta(unLugar) = unLugar.esDivertido()
}

class Raro {
    method leGusta(unLugar) = unLugar.tieneNombreRaro()
}

class Combinado {
    const criterios

    method leGusta(unLugar) = criterios.any { unCriterio => unCriterio.leGusta(unLugar) }
}