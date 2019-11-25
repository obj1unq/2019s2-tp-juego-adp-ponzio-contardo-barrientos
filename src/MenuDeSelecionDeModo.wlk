import wollok.game.*
import LaGrietaDelInvocador.*
import Teclado.*

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

const menuDeSelccionDeModo = new SeleccionDeModo(iconosDelMenu = [fondoSeleccionModoDeJuego, aventuraDePortales,laGrietaDelInvocador])

// MENU DE SELECCION DE PERSONAJES

const menuDeSeleccionDeLaGrieta = new SeleccionDePersonaje(iconosDelMenu = [fondoSeleccionPersoanje,iconoZac, iconoDrMundo, iconoMaokai])

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

class Fondo {
	var property image 
	var property position
	
}
// MODOS DE JUEGO
const fondoSeleccionModoDeJuego = new IconosDelMenu(image = "FondoSeleccionModoDeJuego.png", position = game.at(0,0),dialogo = "")
const fondoSeleccionPersoanje = new IconosDelMenu(image = "FondoSeleccionDePersonajeD.png", position = game.at(0,0),dialogo = "")


const modoDeJuampa = new IconosDelMenu(image = "", position = game.center(), dialogo = "presiona la tecla Q para jugar el modo ...")
const modoDeEric = new IconosDelMenu(image = "", position = game.center(), dialogo = "presiona la tecla W para jugar el modo ...")
const laGrietaDelInvocador = new IconosDelMenu(image = "IconoGrietaDelInvocador.png", position = game.center().left(2), dialogo = "presiona la tecla E para jugar a la grieta del invocador")
const aventuraDePortales = new IconosDelMenu(image = "ADP.png", position = game.center().right(2), dialogo = "presiona la tecla W para jugar a la grieta del invocador")

object puntero {
	var property image = "Puntero.png"
	var property position = game.origin()
	
	method colisionDelPuntero(icono) {
		game.onCollideDo(self, {parametro => icono.colicionasteConElPuntero(self) })
	}
}

// INCONOS PARA EL MENU DE SELECCION DE PERSONAJE
const iconoZac = new IconosDelMenu( image = "zacIcono.png", position = game.at(1,5), dialogo = "presiona la tecla A para jugar con Darius" )
const iconoDrMundo = new IconosDelMenu( image = "drMundoIcono.png", position = game.at(6,5), dialogo = "presiona la tecla S para jugar con DrMundo" )
const iconoMaokai = new IconosDelMenu( image = "maokaiIcono.png", position = game.at(11,5), dialogo = "presiona la tecla D para jugar con Maokai" )