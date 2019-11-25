import wollok.game.*
import laGrietaDelInvocador2.*
import teclado2.*

class Menu {
	const iconosDelMenu = []
	
	method confg() {
		game.clear()
		self.agregarVisuales()
		self.agregarPuntero()
		self.confgDelPuntero()
		self.confgDeTeclado()
	}
	
	method agregarVisuales() {
		iconosDelMenu.forEach({ icono => game.addVisual(icono) })
	}
	
	method agregarPuntero() {
		game.addVisualCharacter(puntero)
	}
	
	method confgDelPuntero() {
		iconosDelMenu.forEach({ icono => puntero.colisionDelPuntero(icono) })
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

const menuDeSelccionDeModo = new SeleccionDeModo(iconosDelMenu = [laGrietaDelInvocador])

// MENU DE SELECCION DE PERSONAJES

const menuDeSeleccionDeLaGrieta = new SeleccionDePersonaje(iconosDelMenu = [iconoZac, iconoDrMundo, iconoMaokai])

class IconosDelMenu {
	var property image 
	var property position
	const property dialogo
	
	method colicionasteConElPuntero(puntero) {
		if( position == puntero.position() ){
			teclado.confgDeMenuSP()
			game.say(self, dialogo)
		}	
	}
}

// MODOS DE JUEGO

const modoDeJuampa = new IconosDelMenu(image = "", position = game.center(), dialogo = "preciona la tecla Q para jugar el modo ...")
const modoDeEric = new IconosDelMenu(image = "", position = game.center(), dialogo = "preciona la tecla W para jugar el modo ...")
const laGrietaDelInvocador = new IconosDelMenu(image = "laGrietaDelInvocador.png", position = game.center(), dialogo = "preciona la tecla E para jugar a la grieta del invocador")

object puntero {
	var property image = "Puntero.png"
	var property position = game.origin()
	
	method colisionDelPuntero(icono) {
		game.onCollideDo(self, {parametro => icono.colicionasteConElPuntero(self) })
	}
}

// INCONOS PARA EL MENU DE SELECCION DE PERSONAJE
const iconoZac = new IconosDelMenu( image = "zacIcono.png", position = game.at(1,5), dialogo = "preciona la tecla A para jugar con Darius" )
const iconoDrMundo = new IconosDelMenu( image = "drMundoIcono.png", position = game.at(6,5), dialogo = "preciona la tecla S para jugar con DrMundo" )
const iconoMaokai = new IconosDelMenu( image = "maokaiIcono.png", position = game.at(11,5), dialogo = "preciona la tecla D para jugar con Maokai" )