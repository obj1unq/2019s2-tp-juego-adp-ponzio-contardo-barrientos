import wollok.game.*

class MundosDelJuego {
	const property listaDeMundos
	
	method pasarAlSiguienteMundo(){
		self.listaDeMundos().remove(self.listaDeMundos().first())
	}
}


class Mundo {
	const  elementosDelMundo
	const  titulo
	const  fondo
	const  dimensiones
	const  property personajePrincipal
	
	method asignarPersonajesEnJuego(){
		if(not elementosDelMundo.isEmpty()){
			elementosDelMundo.forEach({personajeDelNivel => game.addVisual(personajeDelNivel)})
		}
	}
	
	method cargarTitulo() {
		game.title(titulo) 
	}
	
	method cargarFondo() {
		game.boardGround(fondo) 
	}
	
	method cargarDimensiones() {
		game.width(dimensiones.x()) 
		game.height(dimensiones.y())
	}
	
	method comandosDelNivel(){
		keyboard.e().onPressDo {personajePrincipal.hablarConElNPC(game.uniqueCollider(personajePrincipal))}
    	keyboard.alt().onPressDo {game.removeVisual(game.uniqueCollider(personajePrincipal).dialogo())}
    	game.addVisualCharacter(personajePrincipal) 
	}
}

