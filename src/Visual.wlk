import wollok.game.*

class Visual {
	const property image
	var property position
	
	method cambiarPosicion(posicion){
		position = posicion
	}
	
	method caerHastaElFinal(personaje){ 
		if (position.y() > 0){
			game.removeVisual(self)
			position = position.down(1)
			game.addVisual(self)
		}
		else {
			game.removeTickEvent("objetoEnCaida")
			personaje.objetoActual().clear()
		}
	}
}

const fondoMenu = new Visual(image = "FondoMenuPrincipal.png" , position = game.at(0,0))
const fondoMenuSeleccion = new Visual(image = "FondoMenuSeleccion1.png" , position = game.at(0,0))
const fondoLobbyUno = new Visual(image = "FondoLobbyUno.png" , position = game.at(0,0))
const fondoAguasEstancadas = new Visual(image = "FondoAguasEstancadas.png" , position = game.at(0,0))

const fondoNivelLogica = new Visual(image = "nivelMatFondo.png", position = game.at(0,0))

// Celdas Nivel Logica 

const espacioALlenar = new Visual(image = "espacioErroneo.png", position = game.at(2,0) )
const espacioALlenar2 = new Visual(image = "espacioErroneo.png", position = game.at(4,0) )
const espacioALlenar3 = new Visual(image = "espacioErroneo.png", position = game.at(6,0) )
const espacioALlenar4 = new Visual(image = "espacioErroneo.png", position = game.at(8,0) )
const espacioALlenar5 = new Visual(image = "espacioErroneo.png", position = game.at(10,0) )
const espacioALlenar6 = new Visual(image = "espacioErroneo.png", position = game.at(12,0) )
const inventario = new Visual(image = "Inventario.png", position = game.at(0,6))

// Elementos nivel logica

const banana = new Visual(image = "banana.png",position = game.at(5,5))
const litio = new Visual(image = "Litio.png", position = game.at (10,4))
const oxigeno = new Visual(image = "Oxigeno.png", position = game.at (7,4))
const uranio = new Visual(image = "Uranio.png", position = game.at (12,6))