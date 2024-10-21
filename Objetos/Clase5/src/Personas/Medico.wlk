import src.Personas.Persona.*

class Medico inherits Persona {
    const dosis

    override method contraerEnfermedad(unaEnfermedad) {
        super(unaEnfermedad) // Super no sigue el method lookup, super busca desde la instancia "padre", sirve pura y exclusivamente para evitar recursividad infinita.
        self.atenderA(self)
    }
    method atenderA(unaPersona){
        unaPersona.recibirMedicamento(dosis)
    }
}