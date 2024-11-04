import src.Personas.*

class Legion {
    const miembros = #{}

    method crearLegion() {
        if (miembros.size() < 2) {
            throw new DomainException(message = "Son menos que en la cancha de velez che")
        }
    }

    method asustarA(unAdulto) {
        miembros.forEach { unaPersona => unaPersona.asustarA(unAdulto) }
    }

    method miembros() = miembros

    method capacidadSusto() = miembros.sum { miembro => miembro.capacidadSusto() }

    method caramelosDeLaLegion() = miembros.sum { miembro => miembro.caramelos() }
    
}