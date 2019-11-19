import wollok.game.*

object laGrietaDelInvocador {
	
	method iniciar() {
		zonaPrincipal.confg()
		teclado.confgPersonajePrincipal()
		teclado.confgLaGrietaDelInvocador()
		game.start()
	}
	
	method irSiguienteZona(zona) {
		game.clear()
		zona.confg()
	}
	
}

object teclado {
	
	method confgPersonajePrincipal() {
		keyboard.up().onPressDo{ darius.image("dariusDeEspalda.png") }
		keyboard.down().onPressDo{ darius.image("dariusDeFrente.png") }
		keyboard.right().onPressDo{ darius.image("dariusDer.png") }
		keyboard.left().onPressDo{ darius.image("dariusIzq.png") }
	}
	
	method confgDeZonas() {
		keyboard.c().onPressDo{ laGrietaDelInvocador.irSiguienteZona(carrilSuperior) }
		keyboard.d().onPressDo{ laGrietaDelInvocador.irSiguienteZona(carrilMedio) }
		keyboard.e().onPressDo{ laGrietaDelInvocador.irSiguienteZona(carrilInferior) }
	}
	
	method confgDeCarriles() {
		keyboard.a().onPressDo{
			laGrietaDelInvocador.irSiguienteZona(zonaPrincipal)
			portalSuperior.position( game.at(0,5) )
			portalMedio.position( game.at(6,5) )
			portalInferior.position( game.at(12,5) )
		}
		keyboard.b().onPressDo{ 
			laGrietaDelInvocador.irSiguienteZona(zonaFinal)
			darius.position( game.center() )
			portalSuperior.position( game.at(0,0) )
			portalMedio.position( game.at(6,0) )
			portalInferior.position( game.at(12,0) )
		}
	}
	
	method confgLaGrietaDelInvocador() {
		keyboard.f().onPressDo{ game.schedule(3000, {game.stop()}) }
	}
}

class Zona {
	
//	var property fondo
	var property ancho
	var property alto
	var property personajePrincipal
	var property portales = []
	var property enemigos = [] 
	
	method confg() {
		game.title("la grieta del invocador")
//		game.boardGround(fondo)
		game.ground("celda.png") // imagen de celda
		game.width(ancho)
		game.height(alto)
		self.agregarPersonajes()
		self.irSiguienteZona()
		self.confgDeEnemigos()
		self.confgDePersonajePrincipal()
//		self.confgDePortales()
	}
	
	method agregarPersonajes() {
		if( not portales.isEmpty() )
			portales.forEach({ portal => game.addVisual(portal) })
	}
	
	method irSiguienteZona() {
		teclado.confgDeZonas()
	}
	
	method confgDePersonajePrincipal() {
		game.addVisualCharacter(personajePrincipal)
//		enemigos.forEach({ enemigo => personajePrincipal.atacar(enemigo) })
	}
	
	method confgDeEnemigos() {
		if( not enemigos.isEmpty() ) {
			enemigos.forEach({ enemigo => game.addVisual(enemigo) })
			enemigos.forEach({ enemigo => enemigo.moverseCada(2000) })
//			enemigos.forEach({ enemigo => enemigo.atacar(personajePrincipal) })
		}
	}
	
//	method confgDePortales() {
//		if( not portales.isEmpty() )
//			portales.forEach({ portal => portal.colisionasteCon(personajePrincipal) })
//	}
}

// ZONAS

const zonaPrincipal = new Zona( ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalSuperior, portalMedio, portalInferior])
const zonaFinal = new Carril( ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalSuperior, portalMedio, portalInferior], enemigos = [chogath10, chogath11, chogath12])

class Carril inherits Zona {
	
	override method irSiguienteZona() {
		teclado.confgDeCarriles()
	}
}

// CARRILES
const carrilSuperior = new Carril( ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalPrincipal, portalFinal], enemigos = [chogath1, chogath2, chogath3])
const carrilMedio = new Carril( ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalPrincipal, portalFinal], enemigos = [chogath4, chogath5, chogath6])
const carrilInferior = new Carril( ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalPrincipal, portalFinal], enemigos = [chogath7, chogath8, chogath9])

class Portal {
	
	var property image
	var property position
	var property dialogo
	
//	method colisionasteCon(personaje) {
//		game.onCollideDo(self, { personaje.colisionasteCon(self) })
//	}
}

// PORTALES

const portalPrincipal = new Portal (image = "portal.png" , position = game.at(6,0), dialogo = "presione la tecla A para ir a la zona principal" )
const portalSuperior = new Portal (image = "portal.png", position = game.at(0,5), dialogo = "presione la tecla A para ir al carril superior")
const portalMedio = new Portal (image = "portal.png", position = game.at(6,5), dialogo = "presione la tecla A para ir al carril medio")
const portalInferior = new Portal (image = "portal.png", position = game.at(12,5), dialogo = "presione la tecla A para ir al carril inferior")
const portalFinal = new Portal (image = "portal.png", position = game.at(6,5), dialogo = "presione la tecla A para ir a la zona final")

class Personaje {
	
	var property image
	var property position
	var property vida
	var property danioDeAtaque
	
//	method colisionasteCon(unPortal) {
//		if( position == unPortal.position() )
//			game.say(unPortal, unPortal.dialogo())
//	}
	
//	method atacar(personajePrincipal) {
//  		game.onCollideDo(self, { personaje => personajePrincipal.recibirAtaque(danioDeAtaque) })
//  }
  
//  	method recibirAtaque(danio) {
//		if( vida - danio <= 0 )
//			self.eliminar()
//		vida = vida - danio
//		game.say(self, "me estan atacando")
//	}
	
//	method eliminar() {
//		game.removeVisual(self)
//		game.schedule(3000, { game.stop() })
//	}
}

// PERSONAJES

const darius = new Personaje(image = "dariusDeFrente.png", position = game.origin(), vida = 100, danioDeAtaque = 20)

class Enemigo inherits Personaje {
	

	method moveOn() {
    	const x = 0.randomUpTo(game.width() - 1).truncate(0)
    	const y = 0.randomUpTo(game.height() - 1).truncate(0)
    	self.position(game.at( x, position.y() ))
    	self.position(game.at( position.x(), y ))
  }
  
  method moverseCada(tiempo) {
  	game.onTick(tiempo, "movimiento enemigo", { self.moveOn() })
  }
  
//  override method recibirAtaque(danio) {
//		if( vida - danio <= 0 )
//			self.eliminar()
//		vida = vida - danio
//	}
//  
//  override method eliminar() {
//  	game.removeVisual(self)
//  }
	
}

// ENEMIGOS 

const chogath1 = new Enemigo(image = "chogathDeFrente.png", position = game.at(1,4), vida = 50, danioDeAtaque = 10)
const chogath2 = new Enemigo(image = "chogathDeFrente.png", position = game.at(6,4) , vida = 50, danioDeAtaque = 10)
const chogath3 = new Enemigo(image = "chogathDeFrente.png", position = game.at(12,4), vida = 50, danioDeAtaque = 10)
const chogath4 = new Enemigo(image = "chogathDeFrente.png", position = game.at(1,4), vida = 50, danioDeAtaque = 10)
const chogath5 = new Enemigo(image = "chogathDeFrente.png", position = game.at(6,4), vida = 50, danioDeAtaque = 10)
const chogath6 = new Enemigo(image = "chogathDeFrente.png", position = game.at(12,4), vida = 50, danioDeAtaque = 10)
const chogath7 = new Enemigo(image = "chogathDeFrente.png", position = game.at(1,4), vida = 50, danioDeAtaque = 10)
const chogath8 = new Enemigo(image = "chogathDeFrente.png", position = game.at(6,4), vida = 50, danioDeAtaque = 10)
const chogath9 = new Enemigo(image = "chogathDeFrente.png", position = game.at(12,4), vida = 50, danioDeAtaque = 10)
const chogath10 = new Enemigo(image = "chogathDeFrente.png", position = game.at(1,6), vida = 50, danioDeAtaque = 10)
const chogath11 = new Enemigo(image = "chogathDeFrente.png", position = game.at(6,6), vida = 50, danioDeAtaque = 10)
const chogath12 = new Enemigo(image = "chogathDeFrente.png", position = game.at(12,6), vida = 50, danioDeAtaque = 10)

