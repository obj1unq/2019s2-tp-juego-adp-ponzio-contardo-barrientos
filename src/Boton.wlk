import wollok.game.*
import Nivel.*
import Personaje.*
import Ataques.*
import Portal.*

class Boton {
	method cargarSiguienteParte(){
		organizador.pasarAlSiguienteNivel()
	}
}
object botonAssenso inherits Boton {
	const property image =  "botonAssenso.png"
	var   property position = game.at(-1,-1)		
	
	override method cargarSiguienteParte(){
		atrox.cambiarAspecto()
		atrox.mejorarHabilidadEspecial(furiaDarking)
		atrox.actualizarPersonajeEnNivel()
		game.sound("Assenso.mp3")
		game.addVisual(portalDorado)
	}
	
	method fijarNuevaPosicion(posicion){
		position = posicion
	}
} 

object botonSeleccionAatrox inherits Boton {
	const property image =  "AatroxIcono.png"
	const property position = game.at(8,5)		
}

object botonSeleccionJax inherits Boton {
	const property image =  "JaxIcono.png"
	const property position = game.at(8,4)
}

object botonSeleccionChogath inherits Boton {
	const property image =  "ChogathIcono.png"
	const property position = game.at(8,2)
}


object botonIniciarMedio inherits Boton {
	const property image =  "CeldaVacia.png"
	const property position = game.at(5,1)
}

object botonIniciarIzquierda inherits Boton {
	const property image =  "BotonIniciar.png"
	const property position = game.at(4,1)
}

object botonIniciarDerecha inherits Boton {
	const property image =  "CeldaVacia.png"
	const property position = game.at(6,1)
}

object botonSalirIzquierda inherits Boton {
	const property image =  "BotonSalir.png"
	const property position = game.at(8,1)
	
	override method cargarSiguienteParte(){
		game.stop()
	}
}

object botonSalirMedio inherits Boton {
	const property image =  "CeldaVacia.png"
	const property position = game.at(9,1)
	
	override method cargarSiguienteParte(){
		game.stop()
	}
}

object botonSalirDerecha inherits Boton {
	const property image =  "CeldaVacia.png"
	const property position = game.at(10,1)
	
	override method cargarSiguienteParte(){
		game.stop()
	}
}

object celdaConeccion {
	const property image = "CeldaVacia.png"
	const property position = game.at(7,1)
}

object celdaInvisible {
	const property image = "CeldaVacia.png"
	const property position = game.at(8,3)
}
