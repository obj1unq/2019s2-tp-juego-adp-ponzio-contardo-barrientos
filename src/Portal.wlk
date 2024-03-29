import wollok.game.*
import Nivel.*

class Portal {
	method cargarSiguienteParte(personaje) {
		organizador.pasarAlSiguienteNivel()
	}
	
	method informarMensaje(personaje){
		game.onCollideDo(self, {psj => personaje.decirMensaje(self)})
	}
}


object portalVioleta inherits Portal {
	const property image =  "Portal-Violeta.png"
	const property position = game.at(5,3)
	
}

object portalDorado inherits Portal {
	const property image =  "Portal-Dorado.png"
	const property position = game.at(7,6)
	
}