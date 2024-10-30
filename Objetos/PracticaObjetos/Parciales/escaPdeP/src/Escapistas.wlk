import src.Maestrias.*

class Escapista {
    var maestria
    const salasQueSalio = []
    var saldo

    method saldo() = saldo

    method puedeSalirDe(unaSala) = maestria.puedeSalirDe(self, unaSala)

    method subirDeNivel() {
        if (self.es(Profesional)){
            throw new DomainException(message = "No puede subir mas por chad 🗿")
        } else {
            self.maestria(Amateur)
        }
    }

    method es(unaMaestria) = maestria == unaMaestria

    method maestria(unaMaestria) {
        maestria = unaMaestria
    }

    method salasQueSalio() = salasQueSalio.map { unaSala => unaSala.nombre() }.asSet()

    method escaparDe(unaSala) {
        self.puedeSalirDe(unaSala)
        salasQueSalio.add(unaSala)
    }

    method pagar(unPrecio) {
        if (saldo >= unPrecio) {
            saldo -= unPrecio
        } else {
            throw new DomainException(message = "No hay saldo suficiente papu :v")
        }
    }

    method puedePagar(unaSala) = saldo >= unaSala.precio()

    method hizoMuchasSalas() = salasQueSalio.size() >= 6
}