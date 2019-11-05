import wollok.game.*

class MundosDelJuego {
	const property listaDeMundos
	
	method pasarAlSiguienteMundo(){
		self.listaDeMundos().remove(self.listaDeMundos().first())
	}
}

class Mundo {
	//const property contenidoDelMundo
	const  elementosDelMundo
	const  titulo
	const  fondo
	method asignarPersonajesEnJuego(){
		if(not elementosDelMundo.isEmpty()){
			elementosDelMundo.forEach({personaje => game.addVisual(personaje)})
		}
	}
	
	method cargarTitulo(){
		game.title(titulo) 
	}
	
	method cargarFondo(){
		game.boardGround(fondo) 
	}
}

