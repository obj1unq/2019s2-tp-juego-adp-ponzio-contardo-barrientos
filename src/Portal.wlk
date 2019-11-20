import wollok.game.*
import Nivel.*

object portalVioleta {
	const property image =  "Portal-Violeta.png"
	const property position = game.at(5,3)
	
	method cargarSiguienteParte() {
		organizador.pasarAlSiguienteNivel()
	}
}