import wollok.game.*
import teclado.*

object laGrieta {
	
	var property personaje 
	
	method iniciar() {
		game.clear()
		zonaPrincipal.confg(personaje)
		teclado.confgDePersonajePrincipal()
	}
	
	method irSiguienteZona(zona) {
		game.clear()
		zona.confg(personaje)
	}
	
	method confgDeZonas(zona) {
		if( zona.enemigos().isEmpty() ) {
//			personaje.restablecerVida()
			personaje.recibirBonificacion()
		}
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
//		self.confgDeZonaFinal()
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
		if( enemigos.isEmpty() ) {
			portales.forEach({ 
			portal => game.addVisual(portal) 
			portal.colisionasteCon_En_(personajePrincipal, self)
//			self.bonificacionPara(personajePrincipal)
			})
		}
	}
	
//	method bonificacionPara(personaje) {
//		personaje.restablecerVida()
//		personaje.recibirBonificacion()
//	}
	
	method eliminarEnemigo(enemigo) {
		enemigos.remove(enemigo)
	}
	
//	method confgDeZonaFinal() {
//		laGrieta.confgDeZonaFinal()
//	}

}

class Carril inherits Zona {
	
	override method irSiguienteZona() {
		teclado.confgDeCarriles()
	}
}

//	ZONAS DE LA GRIETA
	const zonaPrincipal = new Zona(fondo = "zonaPrincipal.png", portales = [portalSuperior, portalMedio, portalInferior], enemigos = [])
	const zonaFinal = new Zona(fondo = "zonaFinal.png", portales = [], enemigos = [enemigoZF1, enemigoZF2, enemigoZF3, enemigoZF4, enemigoZF5, enemigoZF6, enemigoZF7, enemigoZF8, enemigoZF9])
	const carrilSuperior = new Carril(fondo = "carrilSuperior.png", portales = [portalPrincipal, portalFinal], enemigos = [enemigoCS1, enemigoCS2, enemigoCS3])
	const carrilMedio = new Carril(fondo = "carrilMedio.png", portales = [portalPrincipal, portalFinal], enemigos = [enemigoCM1, enemigoCM2, enemigoCM3])
	const carrilInferior = new Carril(fondo = "carrilInferior.png", portales = [portalPrincipal, portalFinal], enemigos = [enemigoCI1, enemigoCI2, enemigoCI3])

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
		game.onCollideDo(self, { 
			parametro => personaje.recibirDanio(self, zona)
		})	
	}
	
}

class Principal inherits Personaje{
	
	var property imagenEnPosAtaque
	var property direccionDeImagenes

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
	
	method recibirBonificacion() {
		vida = vida + 100
		danioDeAtaque = danioDeAtaque + 30
		game.say(self, " bonificacion recibida, vida + 100 y ataque + 30 ")
	}
	
}

class DireccionDeImagenes {
	var property arriba
	var property abajo
	var property derecha
	var property izquierda
}

// DIRECCION DE IMAGENES

const imagenesDeZac = new DireccionDeImagenes(arriba = "zacDeEspalda.png", abajo = "zacDeFrente.png", derecha = "zacDerecha.png", izquierda = "zacIzquierda.png")
const imagenesDeDrMundo = new DireccionDeImagenes(arriba = "drMundoDeEspalda.png", abajo = "drMundoDeFrente.png", derecha = "drMundoDerecha.png", izquierda = "drMundoIzquierda.png")
const imagenesDeMaokai = new DireccionDeImagenes(arriba = "maokaiDeEspalda.png", abajo = "maokaiDeFrente.png", derecha = "maokaiDerecha.png", izquierda = "maokaiIzquierda.png")

// PERSONAJES

const zac = new Principal(image = "zacDeFrente.png", position = game.at(2,1), vida = 100, danioDeAtaque = 30, imagenEnPosAtaque = "zacAtacando.png", direccionDeImagenes = imagenesDeZac)

const drMundo = new Principal(image = "drMundoDeFrente.png", position = game.origin(), vida = 100, danioDeAtaque = 30, imagenEnPosAtaque = "drMundoAtacando.png", direccionDeImagenes = imagenesDeDrMundo)

const maokai = new Principal(image = "maokaiDeFrente.png", position = game.origin(), vida = 100, danioDeAtaque = 30, imagenEnPosAtaque = "maokaiAtacando.png", direccionDeImagenes = imagenesDeMaokai)

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
  
  method recibirDanio(personajePrincipal, zona) {
		if(position == personajePrincipal.position()) {
			vida = vida - personajePrincipal.danioDeAtaque()
			 if(vida <= 0) {
			 	self.morirse(personajePrincipal, zona)
			 }
		} 
	}
  
  method morirse(personajePrincipal, zona) {
  	zona.eliminarEnemigo(self)
  	zona.confgDePortales(personajePrincipal)
  	laGrieta.confgDeZonas(zona)
  	game.removeVisual(self)
  }
  
  method estasColicionandoCon_En_(portal, zona) {
  	if( position == portal.position())
  		position = game.center() 
  }
	
}

// ENEMIGOS 

const enemigoCS1 = new Enemigo( image = "enemigo1.png", position = game.at(0,5), vida = 30, danioDeAtaque = 5)
const enemigoCS2 = new Enemigo( image = "enemigo1.png", position = game.at(5,5), vida = 30, danioDeAtaque = 5)
const enemigoCS3 = new Enemigo( image = "enemigo1.png", position = game.at(12,5), vida = 30, danioDeAtaque = 5)

const enemigoCM1 = new Enemigo( image = "enemigo2.png", position = game.at(0,5), vida = 70, danioDeAtaque = 10)
const enemigoCM2 = new Enemigo( image = "enemigo2.png", position = game.at(5,5), vida = 70, danioDeAtaque = 10)
const enemigoCM3 = new Enemigo( image = "enemigo2.png", position = game.at(12,5), vida = 70, danioDeAtaque = 10)

const enemigoCI1 = new Enemigo( image = "enemigo3.png", position = game.at(0,5), vida = 100, danioDeAtaque = 15)
const enemigoCI2 = new Enemigo( image = "enemigo3.png", position = game.at(5,5), vida = 100, danioDeAtaque = 15)
const enemigoCI3 = new Enemigo( image = "enemigo3.png", position = game.at(12,5), vida = 100, danioDeAtaque = 15)

const enemigoZF1 = new Enemigo( image = "enemigo1.png", position = game.at(0,2), vida = 30, danioDeAtaque = 15)
const enemigoZF2 = new Enemigo( image = "enemigo1.png", position = game.at(5,2), vida = 30, danioDeAtaque = 15)
const enemigoZF3 = new Enemigo( image = "enemigo1.png", position = game.at(12,2), vida = 30, danioDeAtaque = 15)
const enemigoZF4 = new Enemigo( image = "enemigo2.png", position = game.at(0,4), vida = 30, danioDeAtaque = 15)
const enemigoZF5 = new Enemigo( image = "enemigo2.png", position = game.at(5,4), vida = 30, danioDeAtaque = 15)
const enemigoZF6 = new Enemigo( image = "enemigo2.png", position = game.at(12,4), vida = 30, danioDeAtaque = 15)
const enemigoZF7 = new Enemigo( image = "enemigo3.png", position = game.at(0,6), vida = 30, danioDeAtaque = 15)
const enemigoZF8 = new Enemigo( image = "enemigo3.png", position = game.at(5,6), vida = 30, danioDeAtaque = 15)
const enemigoZF9 = new Enemigo( image = "enemigo3.png", position = game.at(12,6), vida = 30, danioDeAtaque = 15)