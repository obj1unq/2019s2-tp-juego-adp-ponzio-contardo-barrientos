import wollok.game.*
import Nivel.*

class Portal {
	method cruzarElPortal(){
		organizador.pasarAlSiguienteNivel()	
	}
}

object portalVioleta inherits Portal {
	const property image =  "Portal-Violeta.png"
	const property position = game.at(5,3)	
}