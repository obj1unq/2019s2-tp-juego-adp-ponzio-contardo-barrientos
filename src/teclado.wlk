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
			self.personaje(darius)
			laGrieta.personaje(darius)
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
	
	method confgDeCarriles() {
		keyboard.z().onPressDo{ 
			personaje.position( game.at(2,1) )
			laGrieta.irSiguienteZona(zonaPrincipal)
		}
		keyboard.x().onPressDo{ 
			personaje.position( game.at(0,0) )
			laGrieta.irSiguienteZona(zonaFinal)
		}
	}
	
	method confgDeZonas() {
		keyboard.c().onPressDo{ 
			laGrieta.irSiguienteZona(carrilSuperior)
			personaje.position( game.at(2,0) )
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(10,5) )
		}
		keyboard.v().onPressDo{ 
			laGrieta.irSiguienteZona(carrilMedio)
			personaje.position( game.at(2,0) )
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(12,5) )
		}
		keyboard.b().onPressDo{ 
			laGrieta.irSiguienteZona(carrilInferior)
			personaje.position( game.at(2,0) )
			portalPrincipal.position( game.at(0,0) )
			portalFinal.position( game.at(12,5) )
		}
	}
}
