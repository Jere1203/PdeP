import src.Juego.*
class Gratis {
    method precio(unJuego) = 0
}

class Directo {
    const descuento
    method precio(unJuego) = unJuego.precio() - self.descuentoPorcentual(unJuego)

    method descuentoPorcentual(unJuego) =  (unJuego.precio() * descuento) / 100
}

class Fijo {
    const descuento

    method precio(unJuego) = unJuego.mitadDePrecio().max(unJuego.precio() - descuento)

    
}

class Descuento {
    const juegos = []

    method precio() = juegos.forEach { unJuego => unJuego.precio() }

    method juegoDeMayorPrecio() = juegos.max { unJuego => unJuego.precio() }

    method aplicarDescuento(unosJuegos) = self.juegosCaros().forEach { unJuego => unJuego.cambiarDescuento(new Directo(descuento = 50)) }
      

    method juegosCaros() = juegos.filter{ unJuego => unJuego.precio() > (self.juegoDeMayorPrecio() * 3/4) }
}

class NuevoDescuento inherits Descuento {
    override method aplicarDescuento (unosJuegos) = 
      super(unosJuegos).forEach{ unJuego => unJuego.cambiarDescuento(new Fijo(descuento = 40)) }
}