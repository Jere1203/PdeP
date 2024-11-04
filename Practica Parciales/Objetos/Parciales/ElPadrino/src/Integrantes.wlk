import Rangos.*
import Armas.*
class Integrantes {
    var estaMuerto
    var estaHerido
    const armas = #{}
    var rango
    var lealtad

    method estaVivo() = !estaMuerto

    method morir() {
        estaMuerto = true
    }

    method despachaElegante() {
        rango.sabeDespacharElegantemente(self)
    }

    method tieneArmaSutil() {
        armas.any { unArma => unArma.esSutil() }
    }

    method herir() {
        if (estaHerido) {
            self.morir()
        } else {
            estaHerido = true
        }
    }

    method armarse() {
        self.agregarArma(new Revolver(cantidadBalas = 6))
    }

    method agregarArma(unArma) {
        armas.add(unArma)
    }

    method cantidadArmas() = armas.size()

    method estaDurmiendoConLosPeces() = estaMuerto

    method atacarFamilia(unaFamilia) {
        const atacado = unaFamilia.integranteMasPeligroso()
        if (atacado.estaVivo()) {
            self.atacarA(atacado)
        }
    }

    method atacarA(unaPersona) {
        rango.atacarA(unaPersona)
    }

    method promoverASubJefe(unIntegrante) {
       rango = new SubJefe()
    }

    method rango() = rango

    method ascenderADon() {
        rango = new Don(subordinados = self.subordinados())
    }

    method subordinados() = rango.subordinados()

    method aumentarLealtadPorLuto() {
        lealtad *= 1.1
    }

}

class Familia {
    const integrantes = []
    var don

    method integranteMasPeligroso() {
        self.integrantesVivos().max { unIntegrante => unIntegrante.cantidadArmas() }

    }

    method armarALaFamilia() {
        self.integrantesVivos().forEach { unIntegrante => unIntegrante.armarse() }
    }

    method integrantesVivos() = integrantes.filter { unIntegrante => unIntegrante.estaVivo() }

    method atacarFamilia(unaFamilia) {
        self.integrantesVivos().forEach { integrante => integrante.atacarFamilia(unaFamilia) }
    }

    method reorganizarse() {
        self.integrantesSoldados().filter { integrante => integrante.cantidadArmas() > 5 }.all { integrante => integrante.promoverASubJefe() }
        self.elegirNuevoDon()
        self.aumentarLealtadDeIntegrantes()
    }

    method integrantesSoldados() = self.integrantesVivos().filter { integrante => integrante.rango() == Soldado }

    method elegirNuevoDon() {
        const nuevoDon = don.subordinadoMasLeal()
        self.don(nuevoDon)
        nuevoDon.ascenderADon()
    }

    method don(unDon) {
        don = unDon
    }

    method aumentarLealtadDeIntegrantes() {
        integrantes.forEach { integrante => integrante.aumentarLealtad() }
    }

    method lealtadPromedio() = integrantes.sum { integrante => integrante.lealtad() } / integrantes.size()
}

class Traicion {
    const traidor
    const victimas = #{}
    const traiciones = []

    method traicionarA(unaFamilia) {
        if(unaFamilia.lealtadPromedio() > traidor.lealtad() * 2) {
            self.ajusticiar(traidor)
        } else {
            self.concretarTraicion()
        }
    }
    method ajusticiar(unTraidor) {
        unTraidor.morir()
    }
    method concretarTraicion() {
        victimas.forEach { victima => victima.herir() }
        traiciones.add(traidor)
        traidor.cambiarDeFamilia() //No entendí como hacerlo
        
    }
}