class Empleado {
  const lenguajes = #{}
  var mesa
  method aprender(unLenguaje) {
    lenguajes.add(unLenguaje)
  }

  method estaInvitadoA(unaFiesta) {
    unaFiesta.estaInvitado(self)
  }

  method asignarMesa() {
    mesa = self.lenguajesModernos().size()
  }

  method asistirA(unaFiesta) {
    unaFiesta.registrarAsistencia(self)
    unaFiesta.agregarRegalo(1000 * self.lenguajesModernos())
  }

  method lenguajesModernos() = lenguajes.filter { lenguaje => lenguaje.esModerno() }
  method sabeLenguajeAntiguo() = lenguajes.any({ unLenguaje => unLenguaje.esAntiguo() })
  method sabeLenguajeModerno() = lenguajes.any({ unLenguaje => unLenguaje.esModerno() })

  method numeroMesa() = mesa

}

class Jefe inherits Empleado {
  const empleados = #{}

  method tomarACargo(unEmpleado) {
    empleados.add(unEmpleado)
  }

  override method asignarMesa() {
    mesa = 99
  }

  method puedeSerInvitado() = self.sabeLenguajeAntiguo() and self.soloTieneGenteCopada()

  method soloTieneGenteCopada() = empleados.all { unEmpleado => unEmpleado.esCopado() }  

  override method asistirA(unaFiesta) {
    super(self)
    unaFiesta.agregarRegalo(1000 * self.cantidadEmpleados())
  }

  method cantidadEmpleados() = empleados.size()
}

class Desarrollador inherits Empleado {
  method puedeSerInvitado() = lenguajes.contains("wollok") or self.sabeLenguajeAntiguo()
  method esCopado() = self.sabeLenguajeAntiguo() and self.sabeLenguajeModerno()
}

class Infraestructura inherits Empleado {
  const anios

  method puedeSerInvitado() = lenguajes.size() >= 5
  method esCopado() = self.tieneMuchaExperiencia()

  method tieneMuchaExperiencia() = anios >= 10
}