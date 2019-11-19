import wollok.game.*

class Visual {
	var property image
	var property position
	
	method cambiarPosicion(posicion){
		position = posicion
	}
	
	method cambiarImagen(imagen, objeto){
		if (game.colliders(self).contains(objeto)){
			image = imagen
		}
		else {
			image = "espacioErroneo.png"
		}
	}
	
	method caerHastaElFinal(personaje){
		if (position.y() > 0){
			// personaje.objetoActual().clear()
			game.removeVisual(self)
			position = position.down(1)
			game.addVisual(self)
		}
		else if (game.colliders(self).size() > 1) {
			game.removeVisual(self)
			position = position.up(1)
			game.addVisual(self)
			game.removeTickEvent("objetoEnCaida")
		}
		else {
			game.removeTickEvent("objetoEnCaida")
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
const inventarioVisual = new Visual(image = "Inventario.png", position = game.at(0,6))

// Elementos nivel logica

const banana = new Visual(image = "Potasio.png",position = game.at(5,5))
const litio = new Visual(image = "Litio.png", position = game.at (10,4))
const litio2 = new Visual(image = "Litio2.png", position = game.at (2,3))
const oxigeno = new Visual(image = "Oxigeno.png", position = game.at (7,4))
const oxigeno2 = new Visual(image = "Oxigeno2.png", position = game.at (2,1))
const uranio = new Visual(image = "Uranio.png", position = game.at (10,5))
const calavera = new Visual(image = "Calavera.png", position = game.at (3,4))
const moneda = new Visual(image = "Moneda.png", position = game.at (11,5))
const oro = new Visual(image = "Oro.png", position = game.at (6,2))
const oxido = new Visual(image = "Oxido.png", position = game.at (7,5))
const pirata = new Visual(image = "Pirata.png", position = game.at (9,3))

const barraTiempo = new Visual(image="barraTiempo.png", position = game.at(0,0))
const sesenta = new Visual(image="60.png", position = game.at(0,5))
const cincuentaYNueve = new Visual(image = "59.png", position = game.at(0,5))
const cincuentaYOcho = new Visual(image = "58.png", position = game.at(0,5))
const cincuentaYSiete = new Visual(image = "57.png", position = game.at(0,5))
const cincuentaYSeis = new Visual(image = "56.png", position = game.at(0,5))
const cincuentaYCinco = new Visual(image = "55.png", position = game.at(0,5))
const cincuentaYCuatro = new Visual(image = "54.png", position = game.at(0,5))
const cincuentaYTres = new Visual(image = "53.png", position = game.at(0,5))
const cincuentaYDos = new Visual(image = "52.png", position = game.at(0,5))