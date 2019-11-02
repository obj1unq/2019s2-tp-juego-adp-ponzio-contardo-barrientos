class MundosDelJuego {
	const property listaDeMundos
	
	method pasarAlSiguienteMundo(){
		self.listaDeMundos().remove(self.listaDeMundos().first())
	}
}

class Mundo {
	const property contenidoDelMundo
}

