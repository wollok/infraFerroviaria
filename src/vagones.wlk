class VagonDePasajeros {
	var property ancho
	var property largo
	var property tieneBanios
	var property estaOrdenado	
	
	method cantidadPasajeros() {
		const multiplicador = if (ancho <= 3) {8} else {10}
		var cantidad = largo * multiplicador
		if (estaOrdenado) { cantidad += 15 }
		return cantidad
	}
	method cantidadPasajeros_conciso() {
		return (largo * (if (ancho <= 3) {8} else {10})) 
			- (if (estaOrdenado) {0} else {15})
	}
	method cargaMaxima() { 
		return if (tieneBanios) {300} else {800}
	}
	method pesoMaximo() { 
		return 2000 + 80 * self.cantidadPasajeros() + self.cargaMaxima()
	}
	method hacerMantenimiento() { estaOrdenado = true }
}


class VagonDeCarga {
	var property cargaMaximaIdeal
	var property maderasSueltas

	method cantidadPasajeros() = 0
	method cargaMaxima() = cargaMaximaIdeal - 400 * maderasSueltas
	method pesoMaximo() = 1500 + self.cargaMaxima()
	method tieneBanios() = false	
	method hacerMantenimiento() {
		if (maderasSueltas >= 2) {
			maderasSueltas -= 2
		} else {
			maderasSueltas = 0
		}
	}
	method hacerMantenimiento_conciso() { 
		maderasSueltas -= 2.min(maderasSueltas)
	}
}


class VagonDormitorio {
	var property compartimientos
	var property camasPorCompartimiento

	method cantidadPasajeros() = compartimientos * camasPorCompartimiento
	method cargaMaxima() = 1200
	method pesoMaximo() = 4000 + 80 * self.cantidadPasajeros() + self.cargaMaxima()
	method tieneBanios() = true
	method hacerMantenimiento() { }
}


class Locomotora {
	var property peso
	var property arrastre
	
	method esEficiente() = arrastre >= peso * 5
}















