import Persona.*
import src.Personas.Medico.*
class JefeDeDepartamento inherits Persona{
  const subordinados = #{}

  method atenderA(unaPersona) {
    subordinados.anyOne().atenderA(unaPersona)
  }
  method agregarSubordinado(unSubordinado){
    subordinados.add(unSubordinado)
  }
}