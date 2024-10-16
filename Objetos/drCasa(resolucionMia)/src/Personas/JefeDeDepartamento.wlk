import src.Personas.Medico.*
class JefeDeDepartamento inherits Medico (dosis = 0){
  const subordinados = #{}

  method agregarSubordinado(unMedico) {
    subordinados.add(unMedico)
  }

  override method darMedicamento(unaPersona) {
    super(unaPersona)
    subordinados.anyOne().darMedicamento(unaPersona)
  }
}