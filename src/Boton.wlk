import wollok.game.*
import Nivel.*

class Boton {
	const property image
	const property position
	
	method ejecutarAccion(){
		organizador.pasarAlSiguienteNivel()
	}
}

const botonStart = new Boton(image = "BotonStart.png", position = game.at(6,1))
const botonExit = new Boton(image = "BotonSalir.png", position = game.at(7,1))