import src.Personas.Persona.*
class Medico inherits Persona{
  const dosis
  method darMedicamento(unaPersona) {
    unaPersona.recibirMedicamento(dosis*15)
  }

  override method contraerEnfermedad(unaEnfermedad) {
    super(unaEnfermedad)
    self.darMedicamento(self)
  }
}