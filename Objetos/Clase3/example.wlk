class Recital {
  var asientos = #{}
  var entradasVendidas = 0
  method ventaEntradas(persona) {
    asientos.add(persona)
  } 
  method entradasVendidas() = asientos.size()

  method asientosAsignadosConInicial(inicial){
    return asientos.filter({ nombre => nombre.startsWith() == inicial }) //{} es una "función lambda"
  } 
}