import Personaje.*
import NPCs.*
import wollok.game.*
import Fondo.*
import Boton.*

class OrganizadorDeNiveles {
	const listaDeNiveles
	
	method pasarAlSiguienteNivel(){
		listaDeNiveles.remove(listaDeNiveles.first())
		self.actualizar()
	}
	
	method actualizar(){
		self.cargarNivel()
	}
	
	method cargarNivel(){
		listaDeNiveles.first().cargarTodo()
	}
}

const organizador = new OrganizadorDeNiveles(listaDeNiveles = [menuPrincipal,aguasEstancadas])


class Nivel {
	
	method asignarElementos_EnElNivel(elementosDelNivel){
		if(not elementosDelNivel.isEmpty()){
			elementosDelNivel.forEach({personajeDelNivel => game.addVisual(personajeDelNivel)})
		}
	}
	
	method asignarPersonajePrincipal_AlNivel(personajePrincipal) {
		game.addVisualCharacter(personajePrincipal)
		
	}
	
	method comandosDelNivel(personajePrincipal){
		keyboard.control().onPressDo {personajePrincipal.interacturaCon_(game.uniqueCollider(personajePrincipal))}
    	keyboard.alt().onPressDo {personajePrincipal.pasarAlSiguienteDialogo_(game.uniqueCollider(personajePrincipal))}
    	keyboard.e().onPressDo {personajePrincipal.usarAtaqueBasicoContra_(game.uniqueCollider(personajePrincipal))}
    	keyboard.r().onPressDo {personajePrincipal.usarHabilidadEspecialContra_(game.uniqueCollider(personajePrincipal))}
    	keyboard.c().onPressDo {personajePrincipal.cambiarASiguienteModo()}
	}
}

class Menu inherits Nivel {
	
	override method comandosDelNivel(puntero){	
	keyboard.enter().onPressDo {puntero.interacturaCon_(game.uniqueCollider(puntero))}
	}
	
}

object menuPrincipal inherits Menu {
	

	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoMenu, botonStart])
		self.asignarPersonajePrincipal_AlNivel(punteroMenu)
		self.comandosDelNivel(punteroMenu)
	}
}

object lobbyUno inherits Nivel {
	
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoLobbyUno, galio, galioDiag])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
	}
}

object aguasEstancadas inherits Nivel {
	method cargarTodo(){
		game.clear()
		self.asignarElementos_EnElNivel([fondoAguasEstancadas, nautilus])
		self.asignarPersonajePrincipal_AlNivel(atrox)
		self.comandosDelNivel(atrox)
	}

}





// Objeto informador de errores (Invisible)
object informadorDeErrores {
	const property image = "CeldaVacia.png"
	const property position = game.at(12,0)

}

