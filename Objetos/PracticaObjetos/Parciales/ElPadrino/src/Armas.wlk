class Revolver {
    var cantidadBalas

    method utilizarContra(unaPersona) {
        if (self.tieneBalas()) {
            unaPersona.morir()
            cantidadBalas -= 1
        }
    }
    method tieneBalas() = cantidadBalas > 0

    method esSutil() = cantidadBalas == 1
}

class Escopeta {
    method utilizarContra(unaPersona) {
        unaPersona.herir()
    }
}

class CuerdaDePiano {
    const esDeBuenaCalidad
    
    method utilizarContra(unaPersona) {
        if(esDeBuenaCalidad) {
            unaPersona.morir()
        }
    }

    method esSutil() = true
}