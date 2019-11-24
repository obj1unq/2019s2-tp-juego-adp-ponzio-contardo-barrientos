import wollok.game.*
import laGrietaDelInvocador.*
import menusDeSeleccion.*

object teclado {
	
	var property personaje
	
	method confgDeSeleccionDeModo() {
		keyboard.q().onPressDo{} // MENU DE SELECCION DE PERSONAJES DEL MODO DE JUAMPA
		keyboard.w().onPressDo{} // MENU DE SELECCION DE PERSONAJES DEL MODO DE ERIC
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
//			game.boardGround("zonaPrincipal.png")
			personaje.position( game.at(2,1) )
			self.confgDePersonajePrincipal()
		}
		keyboard.x().onPressDo{ 
			laGrieta.irSiguienteZona(zonaFinal)
//			game.boardGround("zonaFinal.png")
			personaje.position( game.at(0,0) )
			self.confgDePersonajePrincipal()
		}
	}
	
	method confgDeZonas() {
		keyboard.c().onPressDo{ 
			laGrieta.irSiguienteZona(carrilSuperior)
//			game.boardGround("carrilSuperior.png")
			personaje.position( game.at(2,0) )
			self.confgDePersonajePrincipal()
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(10,5) )
		}
		keyboard.v().onPressDo{ 
			laGrieta.irSiguienteZona(carrilMedio)
//			game.boardGround("carrilMedio.png")
			personaje.position( game.at(2,0) )
			self.confgDePersonajePrincipal()
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(12,5) )
		}
		keyboard.b().onPressDo{ 
			laGrieta.irSiguienteZona(carrilInferior)
//			game.boardGround("carrillInferior.png")
			personaje.position( game.at(2,0) )
			self.confgDePersonajePrincipal()
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(12,5) )
		}
	}
}
