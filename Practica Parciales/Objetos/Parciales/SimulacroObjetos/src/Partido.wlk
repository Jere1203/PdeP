import src.Filosofo.*
import src.Argumentos.*
class Partido {
    const filosofo
    const argumentos = []
    method esBuenaDiscusion(otroPartido) = self.sonBuenosArgumentos() and otroPartido.sonBuenosArgumentos()
     and self.elFilosofoEstaEnLoCorrecto() 
     and otroPartido.elFilosofoEstaEnLoCorrecto()

    method elFilosofoEstaEnLoCorrecto() = filosofo.estaEnLoCorrecto()

    method sonBuenosArgumentos() = self.argumentosEnriquecedores() / argumentos.size() >= 0.5
    
    method argumentosEnriquecedores() = argumentos.filter { unArgumento => unArgumento.esEnriquecedor() }
}