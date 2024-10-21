import src.Artistas.*
import src.Peliculas.*

class IMPdeP {
    method artistaConMejorPaga(unaPelicula){
        return unaPelicula.elenco.max{ actor => actor.sueldo() }
    }

    method peliculasEconomicas(unasPeliculas) {
        return unasPeliculas.filter {unaPelicula => unaPelicula.presupuesto() < 500000}
    }

    method gananciasPeliculasEconomicas(unasPeliculas) {
        return self.peliculasEconomicas(unasPeliculas).ganancias().sum()    
    }

    method recategorizar(unArtista) {
        unArtista.recategorizarExperiencia()
    }
}