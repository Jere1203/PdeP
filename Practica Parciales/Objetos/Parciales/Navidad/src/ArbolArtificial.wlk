class ArbolArtificial {
    const cantidadDeVaras
    const regalos = []

    method capacidad() = cantidadDeVaras

    method agregarRegalo(unRegalo) {
        if(self.hayCapacidad()) {
            regalos.add(unRegalo)
        } else {
            throw new DomainException(message = "No hay capacidad para agregar un regalo")
        }
    }
    method hayCapacidad() = self.capacidad() > 0
}