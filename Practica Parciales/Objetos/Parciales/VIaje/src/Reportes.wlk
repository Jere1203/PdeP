import src.Tours.*

class Reporte {
    const tours

    method tourPendientesDeConfirmacion() = tours.filter { unTour => unTour.esTourPendiente() }

    method montoTotal() = tours.sum { unTour => unTour.montoTotalPorPersona() }
}