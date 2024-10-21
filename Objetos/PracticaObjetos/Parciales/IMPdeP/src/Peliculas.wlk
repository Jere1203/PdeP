class Pelicula {
    var genero
    var elenco = #{}
    var cantidadVidriosRotos
    var cantidadDeCuchos
    var nombre

    method nombre() = nombre

    method genero() = genero

    method cantidadVidriosRotos() = cantidadVidriosRotos

    method cantidadDeCuchos() = cantidadDeCuchos

    method elenco() = elenco

    method presupuesto (){
        if (genero == "accion"){
            return self.sumatoriaDeSueldos() + (self.sumatoriaDeSueldos() * 0.7) + (1000 * cantidadVidriosRotos)
        }
        else{
            return self.sumatoriaDeSueldos() + (self.sumatoriaDeSueldos() * 0.7)
        }
    }

    method ganancias(){
        return self.recaudacion() - self.presupuesto()
    }

    method recaudacion(){
        if(genero == "drama") {
            return 1000000 + (100000 * nombre.length())
        } 
        else if(genero == "accion") {
                return 1000000 + (50000 * elenco.length())
            } 
        else if (genero == "terror") {
                    return 1000000 + (20000 * cantidadDeCuchos) 
                }
        else {
            return 1000000
        }
    }

    method sumatoriaDeSueldos() {
        return elenco.forEach {actor => actor.sueldo()}
    }
}