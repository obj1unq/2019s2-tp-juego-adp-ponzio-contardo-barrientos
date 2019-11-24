import wollok.game.*
import teclado.*

object laGrieta {
	
	var property personaje 
	
	method iniciar() {
		game.clear()
		zonaPrincipal.confg(personaje)
	}
	
	method irSiguienteZona(zona) {
		game.clear()
		zona.confg(personaje)
	}
	
}

class Zona {
	
	var property fondo
	var property portales = []
	var property enemigos = [] 
	
	method confg(personajePrincipal) {
		game.boardGround(fondo)
		self.confgDeEnemigos(personajePrincipal)
		self.confgDePortales(personajePrincipal)
		self.confgDePersonajePrincipal(personajePrincipal)
	}
	
	method irSiguienteZona() {
		teclado.confgDeZonas()
	}
	
	method confgDePersonajePrincipal(personajePrincipal) {
		game.addVisualCharacter(personajePrincipal)
		enemigos.forEach({ enemigo => personajePrincipal.atacar(enemigo, self) })
	}
	
	method confgDeEnemigos(personajePrincipal) {
		if( not enemigos.isEmpty() ) {
			enemigos.forEach({
				enemigo => game.addVisual(enemigo)
				enemigo.moverseCada(3000)
				enemigo.atacar(personajePrincipal, self)
			})
		}
	}
	
	method confgDePortales(personajePrincipal) {
		portales.forEach({ 
			portal => game.addVisual(portal) 
			portal.colisionasteCon_En_(personajePrincipal, self)
		})
	}
	
	method eliminarEnemigo(enemigo) {
		enemigos.remove(enemigo)
	}

}

class Carril inherits Zona {
	
	override method irSiguienteZona() {
		teclado.confgDeCarriles()
	}
}

//	ZONAS DE LA GRIETA
	const zonaPrincipal = new Zona(fondo = "zonaPrincipal.png", portales = [portalSuperior, portalMedio, portalInferior], enemigos = [])
	const zonaFinal = new Zona(fondo = "zonaFinal.png", portales = [], enemigos = [torre1, torre2, torre3, torre4])
	const carrilSuperior = new Carril(fondo = "carrilSuperior.png", portales = [portalPrincipal, portalFinal], enemigos = [enemigoCS])
	const carrilMedio = new Carril(fondo = "carrilMedio.png", portales = [portalPrincipal, portalFinal], enemigos = [enemigoCM])
	const carrilInferior = new Carril(fondo = "carrilInferior.png", portales = [portalPrincipal, portalFinal], enemigos = [enemigoCI])

class Portal {
	
	var property image
	var property position
	var property dialogo
	
	method colisionasteCon_En_(personajePrincipal, zona) {
		game.onCollideDo(self, { parametro => personajePrincipal.estasColicionandoCon_En_(self, zona) })
	}
	
}

// PORTALES

const portalPrincipal = new Portal (image = "portal.png" , position = game.at(6,0), dialogo = "presione la tecla Z para ir a la zona principal" )
const portalSuperior = new Portal (image = "portal.png", position = game.at(2,5), dialogo = "presione la tecla C para ir al carril superior")
const portalMedio = new Portal (image = "portal.png", position = game.at(10,5), dialogo = "presione la tecla V para ir al carril medio")
const portalInferior = new Portal (image = "portal.png", position = game.at(12,1), dialogo = "presione la tecla B para ir al carril inferior")
const portalFinal = new Portal (image = "portal.png", position = game.at(6,5), dialogo = "presione la tecla X para ir a la zona final")

class Personaje {
	
	var property image
	var property position
	var property vida
	var property danioDeAtaque

	method atacar(personaje, zona) {
		game.onCollideDo(self, { parametro => personaje.recibirDanio(self, zona) })
	}
	
	method recibirDanio(enemigo, zona) {
		if(position == enemigo.position()) {
			 vida = vida - enemigo.danioDeAtaque()
			 if(vida <= 0) self.morirse()
		} 
	}
	
	method morirse() {
		game.removeVisual(self)
		game.schedule(1500, { game.stop() })
	}
	
	method estasColicionandoCon_En_(portal, zona) {
		if( position == portal.position() ){
			zona.irSiguienteZona()
			game.say(self, portal.dialogo())
		}
	}
	
}

// PERSONAJES

const darius = new Personaje(image = "dariusDeFrente.png", position = game.at(2,1), vida = 100, danioDeAtaque = 30)
const brand = new Personaje(image = "brandDeFrente.png", position = game.origin(), vida = 100, danioDeAtaque = 30)
const drMundo = new Personaje(image = "drMundoDeFrente.png", position = game.origin(), vida = 100, danioDeAtaque = 30)
const maokai = new Personaje(image = "maokaiDeFrente.png", position = game.origin(), vida = 100, danioDeAtaque = 30)

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
  
  override method recibirDanio(enemigo, zona) {
		if(position == enemigo.position()) {
			 vida = vida - enemigo.danioDeAtaque()
			 if(vida <= 0) {
			 	zona.eliminarEnemigo(self)
			 	self.morirse()
			 }
		} 
	}
  
  override method morirse() {
  	game.removeVisual(self)
  }
  
  override method estasColicionandoCon_En_(portal, zona) {
  	if( position == portal.position())
  		position = game.center() 
  }
	
}

// ENEMIGOS 

const enemigoCS = new Enemigo( image = "enemigo1.png", position = game.at(0,5), vida = 30, danioDeAtaque = 10 )
const enemigoCM = new Enemigo( image = "enemigo2.png", position = game.at(6,5), vida = 30, danioDeAtaque = 10 )
const enemigoCI = new Enemigo( image = "enemigo3.png", position = game.at(12,5), vida = 100, danioDeAtaque = 100 )

class Torre inherits Enemigo {
	 override method atacar(personaje, zona) {
//	 	no atacan
	 }
	 
	 override method moverseCada(tiempo) {
//	 	no se mueven
	 }
}

// TORRES

const torre1 = new Torre(image = "torre1.png", position = game.at(11,1), vida = 50, danioDeAtaque = 0)
const torre2 = new Torre(image = "torre2.png", position = game.at(4,5), vida = 100, danioDeAtaque = 0)
const torre3 = new Torre(image = "nexo1.png", position = game.at(5,2), vida = 150, danioDeAtaque = 0)
const torre4 = new Torre(image = "nexo2.png", position = game.at(11,5), vida = 200, danioDeAtaque = 0)

