class Artista {
    var experiencia
    const peliculasDondeActuo = #{}
    var seEstablecio
    var ahorros

    method ahorros() = ahorros

    method experiencia() = experiencia

    method peliculasDondeActuo() = peliculasDondeActuo

    method sueldo() {
        if (experiencia == "amateur") {
            return 10000
        }
       
        else if (experiencia == "estrella") {
            return 30000 * (peliculasDondeActuo.length())
        }
        else if (seEstablecio){
            if (self.nivelDeFama() < 15){
                return 15000
            } else{
            return 5000
            }
        }

    }

    method nivelDeFama(){
        return (peliculasDondeActuo.length() / 2)
    }
    method recategorizarExperiencia() {
        if (experiencia == "amateur") {
            if(peliculasDondeActuo.length() > 10){
                seEstablecio = true
            }
        }
        else if (seEstablecio){
            if (self.nivelDeFama() > 10){
                experiencia = "estrella"
            }
        }
        else if (experiencia == "estrella"){
            throw new Exception(message = "No se puede recategorizar a una estrella")
        }
    }

    method actuar(unaPelicula){
        peliculasDondeActuo.add(unaPelicula)
        ahorros += unaPelicula.sueldo()
    }
}