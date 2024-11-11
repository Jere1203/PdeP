class Fiesta {
    const listaInvitados = #{}
    const listaAsistencia = #{}
    var regalos

    method listaInvitados() = listaInvitados

    method invitarA(unEmpleado) {
        unEmpleado.puedeSerInvitado()
        listaInvitados.add(unEmpleado)
    }

    method estaInvidato(unEmpleado) = listaInvitados.contains(unEmpleado)

    method registrarAsistencia(unEmpleado) {
        self.estaInvidato(unEmpleado)
        listaAsistencia.add(unEmpleado)
        unEmpleado.asignarMesa()
    }

    method balance() = self.regalos() - self.costo()

    method agregarRegalo(unaCantidad) {
        regalos += unaCantidad
    }

    method fueUnExito() = self.balancePositivo() and self.vinieronTodos()

    method balancePositivo() = self.balance() >= 0

    method vinieronTodos() = listaAsistencia == listaInvitados

    method regalos() = regalos

    method costo() = 200000 + self.cantidadAsistencias() * 5000

    method cantidadAsistencias() = listaAsistencia.size()

    method mesaMasAsistida() {
        const listaMesas = listaInvitados.map { unInvitado => unInvitado.numeroMesa() }
        listaMesas.max { unaMesa => listaMesas.maxOcurrenciesOf(unaMesa) }
    }
}