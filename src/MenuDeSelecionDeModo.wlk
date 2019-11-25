import wollok.game.*
import LaGrietaDelInvocador.*
import Teclado.*

class Menu {
	const iconosDelMenu = []
	method confg() {
		game.clear()
		self.agregarVisuales()
		self.confgDeTeclado()
	}
	
	method agregarVisuales() {
		iconosDelMenu.forEach({ icono => game.addVisual(icono) })
	}
		
	method confgDeTeclado()
}

class SeleccionDeModo inherits Menu{
	
	method confgDeTeclado() {
		teclado.confgDeSeleccionDeModo()
	}
}

class SeleccionDePersonaje inherits Menu{
	
	method confgDeTeclado() {
		teclado.confgDeMenuSP()
	}
}

// MENU DE SELECCION DE MODO

const menuDeSelccionDeModo = new SeleccionDeModo(iconosDelMenu = [fondoSeleccionModoDeJuego])

// MENU DE SELECCION DE PERSONAJES

const menuDeSeleccionDeLaGrieta = new SeleccionDePersonaje(iconosDelMenu = [fondoSeleccionPersoanje,iconoZac, iconoDrMundo, iconoMaokai])

class IconosDelMenu {
	var property image 
	var property position
}

class Fondo {
	var property image 
	var property position
	
}
//FONDO
const fondoSeleccionModoDeJuego = new Fondo(image = "FondoSeleccionModoDeJuego1.png", position = game.at(0,0))
const fondoSeleccionPersoanje = new Fondo(image = "FondoSeleccionDePersoanjeD.png", position = game.at(0,0))

// INCONOS PARA EL MENU DE SELECCION DE PERSONAJE
const iconoZac = new IconosDelMenu( image = "zacIcono.png", position = game.at(1,3))
const iconoDrMundo = new IconosDelMenu( image = "drMundoIcono.png", position = game.at(6,3))
const iconoMaokai = new IconosDelMenu( image = "maokaiIcono.png", position = game.at(11,3))