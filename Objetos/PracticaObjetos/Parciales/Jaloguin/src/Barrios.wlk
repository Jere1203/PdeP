import src.Personas.*

class Barrio {
    const ninios = #{}

    method niniosConMasCaramelos() = ninios.sortBy { unNinio => unNinio.caramelos()}

    method primerosTresNiniosConMasCaramelos() = self.niniosConMasCaramelos().take(3)

    method elementosDeNiniosConMasDeDiezCaramelos() = 
        self.niniosConMasDeDiezCaramelos()
        .map { unNinio => unNinio.elementos() }
        .asSet()

    method niniosConMasDeDiezCaramelos() = ninios.filter { unNinio => unNinio.caramelos() > 10 }
}