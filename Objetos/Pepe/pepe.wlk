object pepe {
  var property faltas = 1           //Property sirve para que Wollok me cree el setter y getter (Únicamente sirve para crear ambos)
  var property aniosAntiguedad = 1
  var puesto = desarrollador
  var bonoPresentismo = bonoPresentismoNulo
  var bonoResultado = bonoResultadoFijo

  method sueldo() = self.sueldoNeto() + self.bonoPresentismo() + self.bonoResultado()

  method sueldoNeto() = puesto.sueldoNeto(aniosAntiguedad)
  
  method bonoPresentismo() = bonoPresentismo.sueldo(self)

  method bonoResultado() = bonoResultado.sueldo() // TODO

  method faltas() = faltas

  method aniosAntiguedad() = aniosAntiguedad

  method puesto(unPuesto) {
    puesto = unPuesto
  }

  method bonoPresentismo(unBonoPresentismo) {
    bonoPresentismo = unBonoPresentismo
  }

  method bonoResultado(unBonoResultado) {
    bonoResultado = unBonoResultado
  }

}

object desarrollador {
  method sueldoNeto(aniosAntiguedad) = 1000 + 25 * aniosAntiguedad
}

object manager {
  method sueldoNeto(aniosAntiguedad) = 1500 + 50 * aniosAntiguedad
}

object gerente {
  method sueldoNeto(aniosAntiguedad) = 2500 + 100 * aniosAntiguedad
}

object bonoPresentismoNulo {
  method sueldo(unEmpleado) = 0
}

object bonoPresentismoFaltas {
  method sueldo(unEmpleado) {
    if (unEmpleado.faltas() == 0) {
      return 100
    } else if (unEmpleado.faltas() == 1) {
      return 50 - unEmpleado.aniosAntiguedad()
    } else {
      return 0
    }
  }
}

object bonoPresentismoNioqui {
  method sueldo(unEmpleado) {
    return 2 ** unEmpleado.faltas()
  }
}

object bonoResultadoFijo {
  method sueldo(unEmpleado){
    return 15 + unEmpleado.aniosAntiguedad()
  }
}

object bonoResultadoSTI {
  method sueldo(unEmpleado){
    return unEmpleado.sueldoNeto() * 0.25
  }
}

object bonoResultadoNulo {
  method sueldo(unEmpleado) {
    return 0
  }
}

//PINGA