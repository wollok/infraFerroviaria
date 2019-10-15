class Deposito {
	const formaciones = []
	const locomotorasSueltas = []
	
	method vagonesMasPesados() {
		return formaciones.map({ form => form.vagonMasPesado() })
	}	
	
	method necesitaUnConductorExperimentado() {
		return formaciones.any({ form => form.esCompleja() })
	}
	
	method agregarLocomotoraAFormacion(formacion) {
		if (not formacion.puedeMoverse()) {
			const locomotorasCandidatas = locomotorasSueltas.filter({ 
				loco => loco.arrastre() >= formacion.empujeFaltante()
			})
			if (not locomotorasCandidatas.isEmpty()) {
				const locomotoraElegida = locomotorasCandidatas.first()
				formacion.agregarLocomotora(locomotoraElegida)
				locomotorasSueltas.remove(locomotoraElegida)
			}
		}
	}
}
