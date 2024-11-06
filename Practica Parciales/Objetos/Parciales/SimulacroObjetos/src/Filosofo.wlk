class Filosofo {
  const honorificos = #{}
  const actividades = []
  const nombre
  var iluminacion
  var diasVividos

  method edad() = diasVividos.div(365)

  method presentarse() = self.nombre() + self.honorificosString()

  method nombre() = nombre

  method honorificosString() = honorificos.join(", ")

  method aumentarIluminacion(nivelIluminacion) {
    iluminacion += nivelIluminacion
  }

  method estaEnLoCorrecto() = iluminacion > 1000

  method iluminacion() = iluminacion

  method rejuvenecer(unosDias) {
    diasVividos -= unosDias
  }

  method realizarActividades() = actividades.forEach { actividad => actividad.actividadRealizadaPor(self) }

  method vivirUnDia() {
    self.realizarActividades()
    self.envejecer(1)
    self.verificarCumpleanios()
  }

  method verificarCumpleanios() {
    if (diasVividos % 365 == 0) {
      self.cumplirAnio()
    }
  } 

  method envejecer(unosDias) {
    diasVividos += unosDias
  } 

  method diasVividos() = diasVividos

  method cumplirAnio() {
    self.aumentarIluminacion(10)
    if (self.edad() == 60) {
      honorificos.add("El sabio")
    }
  }
}

