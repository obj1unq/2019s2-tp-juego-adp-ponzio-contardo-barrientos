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


// NPCs Categoria.
const galio = new NPC (image = "Galio-NPC.png", position = game.at(2,2), dialogo = 1)
const galioDiag = new NPC (image = "CeldaVacia.png", position = galio.position().down(2), dialogo = dialogoInicial)

// Dialogos
const dialogoInicial = new Dialogo (image = "Dialogo.png", position = game.at(0,0))
