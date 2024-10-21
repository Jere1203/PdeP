class FactorSanguineo {
    var factoresCompatibles = #{}

    method puedeDonar(unFactor) {
        return factoresCompatibles.contains(unFactor)
    }
}