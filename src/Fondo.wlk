import wollok.game.*

class Fondo {
	const property image
	var property position
	
	method cambiarPosicion(posicion){
		position = posicion
	}
}

const fondoMenu = new Fondo(image = "FondoMenuPrincipal.png" , position = game.at(0,0))
const fondoMenuSeleccion = new Fondo(image = "FondoMenuSeleccion1.png" , position = game.at(0,0))
const fondoLobbyUno = new Fondo(image = "FondoLobbyUno.png" , position = game.at(0,0))
const fondoAguasEstancadas = new Fondo(image = "FondoAguasEstancadas.png" , position = game.at(0,0))

const fondoNivelLogica = new Fondo(image = "nivelMatFondo.png", position = game.at(0,0))

// Celdas Nivel Logica 

const espacioALlenar = new Fondo(image = "espacioErroneo.png", position = game.at(2,0) )
const espacioALlenar2 = new Fondo(image = "espacioErroneo.png", position = game.at(4,0) )
const espacioALlenar3 = new Fondo(image = "espacioErroneo.png", position = game.at(6,0) )
const espacioALlenar4 = new Fondo(image = "espacioErroneo.png", position = game.at(8,0) )
const espacioALlenar5 = new Fondo(image = "espacioErroneo.png", position = game.at(10,0) )
const espacioALlenar6 = new Fondo(image = "espacioErroneo.png", position = game.at(12,0) )
const inventario = new Fondo(image = "Inventario.png", position = game.at(0,6))

// Elementos nivel logica

const banana = new Fondo(image = "banana.png",position = game.at(5,5))
const litio = new Fondo(image = "Litio.png", position = game.at (10,4))
const oxigeno = new Fondo(image = "Oxigeno.png", position = game.at (7,4))
const uranio = new Fondo(image = "Uranio.png", position = game.at (12,6))