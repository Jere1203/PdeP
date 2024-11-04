class Ninio {
  const elementos = []
  var caramelos
  var actitud

  method capacidadDeAsustar() = self.sumatoriaDeSustos() * actitud

  method sumatoriaDeSustos() = elementos.sum { unElemento => unElemento.susto() }

  method asustarA(unAdulto) {
    if(unAdulto.loAsusta(self)) {
      unAdulto.darCaramelos(self)
      unAdulto.agregarSusto(self)
    }
  }

  method agregarCaramelos(unaCantidad) {
    caramelos += unaCantidad
  }

  method caramelos () = caramelos

  method elementos() = elementos

  method comerCaramelos(cantidadComida) {
    self.verificacionCaramelos(cantidadComida)
    caramelos -= cantidadComida
  }

  method actitud(unaActitud) {
    actitud = unaActitud
  }

  method verificacionCaramelos(cantidadComida) {
    if (caramelos < cantidadComida) {
      throw new DomainException(message = "Para un poco flaco, no ves que no tenes caramelos?")
    }
  }

  method elementos(unElemento) {
    elementos.add(unElemento)
  } 
}


class Adulto {
  const niniosQueIntentaronAsustar = []

  method tolerancia() = 10 * niniosQueIntentaronAsustar.size()

  method loAsusta(unNinio) = self.tolerancia() < unNinio.capacidadDeAsustar()

  method darCaramelos(unNinio) = unNinio.agregarCaramelos(self.tolerancia() / 2)
 
  method agregarSusto(unNinio) {
    if (unNinio.caramelos() > 15) {
      niniosQueIntentaronAsustar.add(unNinio)
    }
  }

  method niniosQueIntentaronAsustar() = niniosQueIntentaronAsustar
}

class Abuelo inherits Adulto {
  override method loAsusta(_unNinio) = true

  override method darCaramelos(unNinio) = super(unNinio) / 2
}

class AdultoNecio inherits Adulto {
  override method loAsusta(_unNinio) = false
}

class Maquillaje {
  method susto() = 3
}

class Traje {
  const tipo
  method susto () = tipo.susto()
}

object tierno {
  const susto = 2

  method susto() = susto
}

object terrorifico {
  const susto = 5
  
  method susto() = susto
}

