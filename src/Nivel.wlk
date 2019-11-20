import Personaje.*
import NPCs.*
import wollok.game.*
import Visual.*
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
	
	const property limites = limitesGenerales // El personaje no va a poder exceder estas coord. ya que son las de borde 
	const property limitesEspecificos = [] // El personaje solamente se va a poder mover en las coord de esta lista
	var property objetosParaAgarrar = [banana, litio, oxigeno, uranio,oxigeno2, litio2,calavera,moneda,oro ,oxido,pirata] // Objetos a utilizar en el nivel de Logica
	
	method asignarElementos_EnElNivel(elementosDelNivel){
		if(not elementosDelNivel.isEmpty()){
			elementosDelNivel.forEach({personajeDelNivel => game.addVisual(personajeDelNivel)})
		}
	}
	
	method asignarPersonajePrincipal_AlNivel(personajePrincipal) {
		game.addVisual(personajePrincipal)
		
	}
	
	method comandosDelNivel(personajePrincipal){
    	keyboard.e().onPressDo {personajePrincipal.usarAtaqueBasicoContra_(game.uniqueCollider(personajePrincipal))}
    	keyboard.r().onPressDo {personajePrincipal.usarHabilidadEspecialContra_(game.uniqueCollider(personajePrincipal))}
    	keyboard.c().onPressDo {personajePrincipal.cambiarASiguienteModo()}
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
	
	method comandosConObjetos(personaje){
    	keyboard.p().onPressDo{self.reiniciarPuzzle()}	
    	keyboard.z().onPressDo{personaje.agarrar(game.colliders(personaje).anyOne(), self)}	
		keyboard.a().onPressDo{personaje.soltar(personaje.inventario().first())}  //personaje.inventario().first()
    }
	
	method reiniciarPuzzle(){
		self.objetosParaAgarrar().forEach({objeto => game.removeVisual(objeto)})
		objetosParaAgarrar.forEach({objeto => objeto.cambiarPosicion(posicionesOriginales.anyOne())})
		self.asignarElementos_EnElNivel(objetosParaAgarrar)
	}
}

class NivelDialogo inherits Nivel{
	var property dialogos 
	
	override method comandosDeDialogo(atrox){
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
	
	method asignarDialogos(diags){
		dialogos = diags
	}
}


object menuPrincipal inherits Nivel {
	
	method comandosDeMenu(puntero, boton){	
		keyboard.enter().onPressDo {puntero.interacturaCon_(game.uniqueCollider(puntero))}
    	keyboard.left().onPressDo{puntero.moverseEnDir(boton.position(), self.limites(), self.limitesEspecificos())}
    	keyboard.right().onPressDo{puntero.moverseEnDir(boton.position().right(4), self.limites(), self.limitesEspecificos())}
	}
	
	method cargarTodo(){
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
		self.asignarDialogos([dialogoGalioUno,dialogoGalioDos,dialogoGalioTres])
		self.comandosDeDialogo(atrox)
		game.addVisual(dialogos.first())
	}
}



object aguasEstancadas inherits Nivel { 
	const listaDeEnemigos = [nautilus,gankplank]
	override method limites() = limitesAguasEstancadas
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoAguasEstancadas, nautilus, gankplank])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
		self.comandosDeMovimiento(atrox)
		listaDeEnemigos.forEach({enemigo => enemigo.mover_Veces(4)})
	}
}

object nivelLogica inherits Nivel{
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoNivelLogica, brand, brandDiag])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
		self.comandosDeMovimiento(atrox)
		self.comandosDeDialogo(atrox)
	}
}

object dialogoNPC3 inherits NivelDialogo{
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoNivelLogica, brand, brandDiag])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.asignarDialogos([brandDialogoUno,brandDialogoDos, brandDialogoTres, brandDialogoCuatro])
		self.comandosDeDialogo(atrox)
		game.addVisual(dialogos.first())
	}
}

object nivelLogicaBIS inherits Nivel{
	
	var property numerosTiempo = [sesenta,cincuentaYNueve,cincuentaYOcho,cincuentaYSiete,cincuentaYSeis,cincuentaYCinco,cincuentaYCuatro,cincuentaYTres,cincuentaYDos]
	
	override method limites(){
		return limitesLogica
	}
	
	method restarTiempo(personaje){
		if (numerosTiempo.size() > 1){
			game.removeVisual(numerosTiempo.first())
			numerosTiempo.remove(numerosTiempo.first())
			game.addVisual(numerosTiempo.first())	
		}
		else{
			game.removeVisual(numerosTiempo.first())
			game.removeTickEvent("countDown")
			game.say(personaje, "Se termino el tiempo")
		}
	}
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoNivelLogica, espacioALlenar, inventarioVisual, espacioALlenar2, espacioALlenar3,espacioALlenar4,espacioALlenar5,
		espacioALlenar6, banana, litio, oxigeno, uranio, oxigeno2, litio2, barraTiempo, sesenta, calavera,moneda,oro ,oxido,pirata])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDeMovimiento(atrox)
		self.comandosDeDialogo(atrox)
		self.comandosConObjetos(atrox)
		game.onCollideDo(uranio, {urn => espacioALlenar.cambiarImagen("espacioCorrecto.png", uranio)})
		game.onCollideDo(oxigeno, {urn => espacioALlenar2.cambiarImagen("espacioCorrecto.png", oxigeno)})
		game.onCollideDo(litio, {urn => espacioALlenar3.cambiarImagen("espacioCorrecto.png", litio)})
		game.onCollideDo(litio2, {urn => espacioALlenar4.cambiarImagen("espacioCorrecto.png", litio2)})
		game.onCollideDo(oxigeno2, {urn => espacioALlenar5.cambiarImagen("espacioCorrecto.png", oxigeno2)})
		game.onCollideDo(banana, {urn => espacioALlenar6.cambiarImagen("espacioCorrecto.png", banana)})
		game.onTick(1200, "countDown", {=> self.restarTiempo(atrox)})
	}
}






object grietaDelInvocador inherits Nivel{
	
	
}


// Objeto informador de errores (Invisible)
object informadorDeErrores {
	const property image = "CeldaVacia.png"
	const property position = game.at(20,0)

}


