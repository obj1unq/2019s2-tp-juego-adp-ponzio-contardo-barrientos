import wollok.game.*
import LaGrietaDelInvocador.*
import MenuDeSelecionDeModo.*
import Nivel.*
import Personaje.*

object teclado {
	
	var property personaje
	
	method confgDeSeleccionDeModo() {
		//  dialogoNPC1, lobbyUno, dialogoInicioAguasEstancadas, aguasEstancadas,  nivelLogica, dialogoNPC3,
		keyboard.w().onPressDo{ organizador.cargarListaDeNiveles([menuPrincipal, menuDeSeleccionDePersonaje,nivelLogica, nivelLogicaBIS,finalBueno]) organizador.personajeSeleccionado(punteroMenu) organizador.actualizar()} 
		keyboard.e().onPressDo{ menuDeSeleccionDeLaGrieta.confg() } 
	}
	
	method confgDeMenuSP() {
		keyboard.a().onPressDo{
			self.personaje(zac)
			laGrieta.personaje(zac)
			laGrieta.iniciar()
		}
		keyboard.s().onPressDo{
			self.personaje(drMundo)
			laGrieta.personaje(drMundo) 
			laGrieta.iniciar()
		}
		keyboard.d().onPressDo{
			self.personaje(maokai)
			laGrieta.personaje(maokai)
			laGrieta.iniciar()
		}
	}
	
	method confgDePersonajePrincipal() {
		keyboard.up().onPressDo{ personaje.image( personaje.direccionDeImagenes().arriba() ) }
		keyboard.down().onPressDo{ personaje.image( personaje.direccionDeImagenes().abajo() ) }
		keyboard.right().onPressDo{ personaje.image( personaje.direccionDeImagenes().derecha() ) }
		keyboard.left().onPressDo{ personaje.image( personaje.direccionDeImagenes().izquierda() ) }
	}
	
	method confgDeCarriles() {
		keyboard.z().onPressDo{ 
			laGrieta.irSiguienteZona(zonaPrincipal)
			personaje.position( game.at(1,1) )
			self.confgDePersonajePrincipal()
		}
		keyboard.x().onPressDo{ 
			laGrieta.irSiguienteZona(zonaFinal)
			personaje.position( game.origin() )
			self.confgDePersonajePrincipal()
		}
	}
	
	method confgDeZonas() {
		keyboard.c().onPressDo{ 
			laGrieta.irSiguienteZona(carrilSuperior)
			personaje.position( game.origin() )
			self.confgDePersonajePrincipal()
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(10,5) )
		}
		keyboard.v().onPressDo{ 
			laGrieta.irSiguienteZona(carrilMedio)
			personaje.position( game.origin() )
			self.confgDePersonajePrincipal()
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(12,5) )
		}
		keyboard.b().onPressDo{ 
			laGrieta.irSiguienteZona(carrilInferior)
			personaje.position( game.origin() )
			self.confgDePersonajePrincipal()
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(12,5) )
		}
	}
}
