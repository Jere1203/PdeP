class Pared {
    const anchoPared
    const tipo

    method resistencia() = tipo.durabilidad() * anchoPared
}

class Tipo {
    const durabilidad
    method durabilidad() = durabilidad
}

const vidrio = new Tipo (durabilidad = 10)
const madera = new Tipo (durabilidad = 25)
const piedra = new Tipo (durabilidad = 50)
 
class CerditoArmado {
    const armadura
    method resistencia() = armadura.resistencia() * 10 
}

class Armadura {
    const resistencia
    method resistencia() = resistencia
}
