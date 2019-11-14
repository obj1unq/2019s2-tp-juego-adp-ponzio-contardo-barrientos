import Personaje.*
import NPCs.*
import wollok.game.*
import Fondo.*
import Boton.*
import Portal.*
import Limites.*

class OrganizadorDeNiveles {
	var listaDeNiveles
	
	method pasarAlSiguienteNivel(){
		listaDeNiveles.remove(listaDeNiveles.first())
		self.cargarNivel()
	}
	
	method actualizar(){
		self.cargarNivel()
		
	}
	
	method cargarNivel(){
		listaDeNiveles.first().cargarTodo()
	}
	
		method cargarListaDeNiveles(lista){
		listaDeNiveles = lista
	}
}

object organizador inherits OrganizadorDeNiveles{
		
}



class Nivel {
	
	const property limites = limitesGenerales
	const property limitesEspecificos = []
	
	method asignarElementos_EnElNivel(elementosDelNivel){
		if(not elementosDelNivel.isEmpty()){
			elementosDelNivel.forEach({personajeDelNivel => game.addVisual(personajeDelNivel)})
		}
	}
	
	method asignarPersonajePrincipal_AlNivel(personajePrincipal) {
		game.addVisual(personajePrincipal)
		
	}
	
	// method comandosDeMenu(puntero, boton){	
	//	keyboard.enter().onPressDo {puntero.interacturaCon_(game.uniqueCollider(puntero))}
    //	keyboard.left().onPressDo{puntero.moverseEnDir(boton.position(), self.limites(), self.limitesEspecificos())}
    //	keyboard.right().onPressDo{puntero.moverseEnDir(boton.position().right(4), self.limites(), self.limitesEspecificos())}
	//}
	
	method comandosDelNivel(personajePrincipal){
    	keyboard.e().onPressDo {personajePrincipal.usarAtaqueBasicoContra_(game.uniqueCollider(personajePrincipal))}
    	keyboard.r().onPressDo {personajePrincipal.usarHabilidadEspecialContra_(game.uniqueCollider(personajePrincipal))}
    	keyboard.c().onPressDo {personajePrincipal.cambiarASiguienteModo()}
    	keyboard.control().onPressDo {personajePrincipal.cruzarElPortal(game.uniqueCollider(personajePrincipal))}
	}
    		
    method comandosDeDialogo(personaje){
    	keyboard.control().onPressDo {personaje.interacturaCon_(game.uniqueCollider(personaje))}
    	keyboard.alt().onPressDo {personaje.pasarAlSiguienteDialogo_(game.uniqueCollider(personaje))}
    }
 
    method comandosDeMovimiento(personaje){
    	keyboard.up().onPressDo{personaje.moverseEnDir(personaje.position().up(1), self.limites(), self.limitesEspecificos())}
    	keyboard.down().onPressDo{personaje.moverseEnDir(personaje.position().down(1), self.limites(), self.limitesEspecificos())}
    	keyboard.left().onPressDo{personaje.moverseEnDir(personaje.position().left(1), self.limites(), self.limitesEspecificos())}
    	keyboard.right().onPressDo{personaje.moverseEnDir(personaje.position().right(1), self.limites(), self.limitesEspecificos())}
    	}
    	
    method asignarLimites(botones){
		botones.forEach({boton => limitesEspecificos.add(boton.position())})
	}
}

class NivelDialogo inherits Nivel{
	var property dialogos = [dialogoGalioUno, dialogoGalioDos, dialogoGalioTres]
	
	override method comandosDelNivel(atrox){
		keyboard.alt().onPressDo {self.pasarAlSiguienteDialogo()}
	}
	
	method cargarDialogo() {
		game.addVisual(dialogos.first())
	}
	
	method pasarAlSiguienteDialogo() {
		if (dialogos.size() > 1){
			game.removeVisual(dialogos.first())
			dialogos.remove(dialogos.first())
			self.cargarDialogo()
		}
		else organizador.pasarAlSiguienteNivel()
	}
}


object menuPrincipal inherits Nivel {
	
	method comandosDeMenu(puntero, boton){	
		keyboard.enter().onPressDo {puntero.interacturaCon_(game.uniqueCollider(puntero))}
    	keyboard.left().onPressDo{puntero.moverseEnDir(boton.position(), self.limites(), self.limitesEspecificos())}
    	keyboard.right().onPressDo{puntero.moverseEnDir(boton.position().right(4), self.limites(), self.limitesEspecificos())}
	}
	
	method cargarTodo(){
		
//		game.schedule(3000, {sound.reproducir()})
		self.asignarElementos_EnElNivel([fondoMenu, botonIniciarMedio, botonIniciarDerecha, botonIniciarIzquierda, botonSalirIzquierda, botonSalirMedio, botonSalirDerecha, celdaConeccion, celdaInvisible])
		self.asignarPersonajePrincipal_AlNivel(punteroMenu)
		self.asignarLimites([botonIniciarIzquierda, botonSalirIzquierda,celdaConeccion])
		self.comandosDeMenu(punteroMenu, botonIniciarIzquierda)	
	}
}

object menuDeSeleccionDePersonaje inherits Nivel {
	
	const property botonesVisibles = [botonSeleccionAatrox, botonSeleccionJax, botonSeleccionChogath]
	
	method comandosDeMenu(puntero){
		keyboard.enter().onPressDo {puntero.interacturaCon_(game.uniqueCollider(puntero))}
    	keyboard.up().onPressDo{puntero.moverseEnSeleccion(puntero.position().up(1), self.limites(), self.limitesEspecificos())}
    	keyboard.down().onPressDo{puntero.moverseEnSeleccion(puntero.position().down(1), self.limites(), self.limitesEspecificos())}
	}
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoMenuSeleccion, botonSeleccionAatrox, botonSeleccionJax, botonSeleccionChogath,celdaInvisible])
		self.asignarPersonajePrincipal_AlNivel(punteroMenuSeleccion)
		self.asignarLimites([botonSeleccionAatrox, botonSeleccionJax, botonSeleccionChogath,celdaInvisible])
		self.comandosDeMenu(punteroMenuSeleccion)
	}
}

object lobbyUno inherits Nivel {
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoLobbyUno, galio, galioDiag])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
		self.comandosDeMovimiento(atrox)
		self.comandosDeDialogo(atrox)
	}
}

object lobbyUnoBIS inherits Nivel { 
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoLobbyUno, portalVioleta])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
		self.comandosDeMovimiento(atrox)
		self.comandosDeDialogo(atrox)
	}
}

// "Niveles" que muestran imagenes de dialogo
object dialogoNPC1 inherits NivelDialogo{
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoLobbyUno, galio, galioDiag, portalVioleta])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
		game.addVisual(dialogos.first())
	}
}



object aguasEstancadas inherits Nivel {
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoAguasEstancadas, nautilus])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
		self.comandosDeMovimiento(atrox)
	}

}

// Objeto informador de errores (Invisible)
object informadorDeErrores {
	const property image = "CeldaVacia.png"
	const property position = game.at(20,0)

}


