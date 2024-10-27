class ArbolNatural {
    const vejez
    const tamanioTronco
    const regalos = []

    method capacidad() = vejez * tamanioTronco

    method agregarRegalo(unRegalo) {
        if(self.hayCapacidad()) {
            regalos.add(unRegalo)
        } else{
            throw new DomainException(message = "El arbol no tiene capacidad para agregar un regalo")
        }
    }

    method hayCapacidad() = self.capacidad() > 0
}