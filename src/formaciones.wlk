import vagones.*

class Formacion {
	var vagones = []
	var locomotoras = []
	
	method agregarVagon(vagon) { vagones.add(vagon) }
	method vagones() { return vagones }
	method agregarLocomotora(loco) { locomotoras.add(loco) }
	method locomotoras() { return locomotoras }
	
	method cantidadPasajeros() = vagones.sum({ vagon => vagon.cantidadPasajeros() })	
	method cantidadVagonesPopulares() {
		return vagones.count({ vagon => vagon.cantidadPasajeros() > 50 })
	}
	method esFormacionCarguera() {
		return vagones.all({ vagon => vagon.cargaMaxima() >= 1000 })
	}
	// lo saco a un método aparte porque lo usa el depósito 
	method vagonMasPesado() = vagones.max({ vagon => vagon.pesoMaximo() })
	
	method dispersionDePesos() {
		const vagonMasLiviano = vagones.min({ vagon => vagon.pesoMaximo() })
		return self.vagonMasPesado().pesoMaximo() - vagonMasLiviano.pesoMaximo()
	}
	method cantidadBanios() {
		return vagones.count({ vagon => vagon.tieneBanios() })
	}
	method hacerMantenimiento() {
		vagones.forEach({ vagon => vagon.hacerMantenimiento() })
	}
	method pesoMaximo() {
		return vagones.sum({ vagon => vagon.pesoMaximo()}) 
			+ locomotoras.sum({ loc => loc.peso() })
	}
	method arrastreTotalLocomotoras() = locomotoras.sum({ loco => loco.arrastre() })
	method puedeMoverse() {
		return self.arrastreTotalLocomotoras() >= self.pesoMaximo()
	}
	method empujeFaltante() {
		return (self.pesoMaximo() - self.arrastreTotalLocomotoras()).max(0)
	}
	
	method esEficiente() = locomotoras.all({ loco => loco.esEficiente() })
	
	method estaEquilibradaEnPasajeros() {
		const vagonesConPasajeros = vagones.filter({ vagon => vagon.cantidadPasajeros() > 0 })
		// caso frontera: no hay ningún vagon con pasajeros.
		// Digamos que en este caso, la formación sí se considera equilibrada en pasajeros
		if (vagonesConPasajeros.isEmpty()) {
			return true
		}
		const maximo = vagones.max({ vagon => vagon.cantidadPasajeros() }).cantidadPasajeros()
		const minimo = vagonesConPasajeros.min({ vagon => vagon.cantidadPasajeros() }).cantidadPasajeros()
		return maximo - minimo <= 20
	}
	
	method estaOrganizada() {
		const calculo = new CalculoOrganizacion()
		vagones.forEach({ vagon => calculo.procesarVagon(vagon) })
		return calculo.hayOrden()
	}

	method estaOrganizada_con_indices() {
		return (1..vagones.size()).all({ ix => 
			not (vagones.get(ix-1).cantidadPasajeros() == 0 and vagones.get(ix).cantidadPasajeros() > 0) 
		})
	}
	
	// usado en etapa 3
	method esCompleja() {
		return self.cantidadUnidades() > 8 or self.pesoMaximo() > 80000
	}
	
	method cantidadUnidades() = vagones.size() + locomotoras.size()
}


class CalculoOrganizacion {
	var property hayOrden = true
	var property todosConPasajeros = true
	
	method procesarVagon(vagon) {
		if (vagon.cantidadPasajeros() > 0) {
			if (not todosConPasajeros) { hayOrden = false }
		} else {
			todosConPasajeros = false
		}
	}
}






















