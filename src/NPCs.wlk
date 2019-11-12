import wollok.game.*
import Nivel.*

class NPC {
	const property image
	const property position
	const property dialogo 
	
	method cargarDialogo() {
		organizador.pasarAlSiguienteNivel()
	}
	
	method pasarAlSiguienteDialogo_() {
		game.removeVisual(dialogo.first())
		dialogo.remove(dialogo.first())
		self.cargarDialogo()
	}
}

class Dialogo { 
	const property image
	const property position
}


// NPCs Categoria.
const galio = new NPC (image = "Galio-NPC.png", position = game.at(2,2), dialogo = [])
const galioDiag = new NPC (image = "CeldaVacia.png", position = galio.position().down(2), dialogo = [dialogoGalioUno, dialogoGalioDos, dialogoGalioTres])


// Dialogos
const dialogoGalioUno = new Dialogo (image = "GalioDialogoUno.png", position = game.at(0,0))
const dialogoGalioDos = new Dialogo (image = "GalioDialogoDos.png", position = game.at(0,0))
const dialogoGalioTres = new Dialogo (image = "GalioDialogoTres.png", position = game.at(0,0))
