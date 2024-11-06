import src.Filosofo.*

class NuevosFilosofos inherits Filosofo {
    const esAmanteDeLaBotanica
    
    override method presentarse() = "Hola"

    override method iluminacion() = self.verificarBotanica()

    method verificarBotanica() {
        if (!self.esAmanteDeLaBotanica()){
            return iluminacion
        } else{
            return iluminacion * 5
        }
    }

    method esAmanteDeLaBotanica() = esAmanteDeLaBotanica
}