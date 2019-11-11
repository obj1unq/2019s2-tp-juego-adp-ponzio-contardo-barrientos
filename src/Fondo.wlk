import wollok.game.*

class Fondo {
	const property image
	const property position
}

const fondoMenu = new Fondo(image = "FondoMenuPrincipal.png" , position = game.at(0,0))
const fondoMenuSeleccion = new Fondo(image = "FondoMenuSeleccion1.png" , position = game.at(0,0))
const fondoLobbyUno = new Fondo(image = "FondoLobbyUno.png" , position = game.at(0,0))
const fondoAguasEstancadas = new Fondo(image = "FondoAguasEstancadas.png" , position = game.at(0,0))