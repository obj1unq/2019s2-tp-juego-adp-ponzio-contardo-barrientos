import wollok.game.*

class NPC {
	const property image
	const property position
	const property dialogo 
	
	method cargarDialogo() {
		game.addVisual(dialogo)
	}
}

class Dialogo { 
	const property image
	const property position
}