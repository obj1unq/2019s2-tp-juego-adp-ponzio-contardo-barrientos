import wollok.game.*

class Fondo {
	const property image
	const property position
}

const fondoMenu = new Fondo(image = "dragon-elder.png" , position = game.at(0,0))
const fondoLobbyUno = new Fondo(image = "FondoLobbyUno.png" , position = game.at(0,0))