import src.Artistas.*
import src.Peliculas.*

class IMPdeP {
    const elenco = #{}
    const peliculas = #{}

    method artistaConMejorPaga(unaPelicula){
        return elenco.max{ actor => actor.sueldo() }
    }

    method peliculasEconomicas() {
        return peliculas.filter{ pelicula => pelicula.esPeliculaEconomica()}
    }

    method gananciasPeliculasEconomicas() {
        return peliculas.filter{ pelicula => pelicula.esPeliculaEconomica() }.sum{ pelicula => pelicula.ganancias() }   
    }

    method recategorizar(unArtista) {
        unArtista.recategorizarExperiencia()
    }
}