class Futbol {
  method rejuvenecer() = 1
}

class Polo {
  method rejuvenecer() = 1
}

class WaterPolo inherits Polo {
  override method rejuvenecer() = super() * 2
}