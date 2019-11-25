import wollok.game.*
import Teclado.*
import MenuDeSelecionDeModo.*



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
		if( zona.eliminaronATodosLosEnemigos() ) {
			if( zona != zonaFinal ) {
			personaje.recibirBonificacion()
			self.derrotaronALosEnemigosDeTodosLosCarriles()
			}
		}
	}
	
	method confgZonaFinal() {
		if( zonaFinal.eliminaronATodosLosEnemigos() ) {
			game.schedule(1500, { game.say(personaje, "nivel superado") })
			game.schedule(3000, { game.clear() menuDeSelccionDeModo.confg() })
		}
	}
	
	method derrotaronALosEnemigosDeTodosLosCarriles() {
		if( carrilSuperior.eliminaronATodosLosEnemigos() and carrilMedio.eliminaronATodosLosEnemigos() and carrilInferior.eliminaronATodosLosEnemigos())
			personaje.evolucionar()
	}
	
	method reiniciarNivel() {
		personaje.reiniciarPersonaje()
		[enemigoCS1, enemigoCS2, enemigoCS3].forEach({ enemigo => carrilSuperior.agregarEnemigo(enemigo) })
		[enemigoCM1, enemigoCM2, enemigoCM3].forEach({ enemigo => carrilMedio.agregarEnemigo(enemigo) })
		[enemigoCI1, enemigoCI2, enemigoCI3].forEach({ enemigo => carrilInferior.agregarEnemigo(enemigo) })
		[enemigoZF1, enemigoZF2, enemigoZF3, enemigoZF4, enemigoZF5, enemigoZF6, enemigoZF7, enemigoZF8, enemigoZF9].forEach({ enemigo => zonaFinal.agregarEnemigo(enemigo) })
	}
	
}

class Zona {
	
	var property image
	var property position = game.origin()
	var property nombre
	var property portales = []
	var property enemigos = [] 
	
	method confg(personajePrincipal) {
		game.addVisual(self)
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
		if( not self.eliminaronATodosLosEnemigos() ) {
			enemigos.forEach({
				enemigo => game.addVisual(enemigo)
				enemigo.moverseCada(1000)
				enemigo.atacar(personajePrincipal, self)
			})
		}
	}
	
	method confgDePortales(personajePrincipal) {
		if( self.eliminaronATodosLosEnemigos() ) {
			portales.forEach({ 
			portal => game.addVisual(portal) 
			portal.colisionasteCon_En_(personajePrincipal, self)
			})
		}
	}
	
	method eliminarEnemigo(enemigo) {
		enemigos.remove(enemigo)
	}
	
	method eliminaronATodosLosEnemigos() = enemigos.isEmpty()
	
	method agregarEnemigo(enemigo) {
		enemigos.add(enemigo)
	}
}

class Carril inherits Zona {
	
	override method irSiguienteZona() {
		teclado.confgDeCarriles()
	}
}

//	ZONAS DE LA GRIETA
	const zonaPrincipal = new Zona(image = "zonaprincipal1.png", nombre = "zona principal", portales = [portalSuperior, portalMedio, portalInferior], enemigos = [])
	const zonaFinal = new Zona(image = "zonafinal1.png", nombre = "zona final", portales = [], enemigos = [])
	const carrilSuperior = new Carril(image = "carrilsuperior.png", nombre = "carril superior", portales = [portalPrincipal, portalFinal], enemigos = [])
	const carrilMedio = new Carril(image = "carrilmedio.png", nombre = "carril medio", portales = [portalPrincipal, portalFinal], enemigos = [])
	const carrilInferior = new Carril(image = "carrilinferior.png", nombre = "carril inferior", portales = [portalPrincipal, portalFinal], enemigos = [])

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
const portalFinal = new Portal (image = "portal.png", position = game.at(6,5), dialogo = "presione la tecla X para ir a la zona final")
const portalSuperior = new Portal (image = "portal.png", position = game.at(1,5), dialogo = "presione la tecla C para ir al carril superior")
const portalMedio = new Portal (image = "portal.png", position = game.at(8,5), dialogo = "presione la tecla V para ir al carril medio")
const portalInferior = new Portal (image = "portal.png", position = game.at(12,1), dialogo = "presione la tecla B para ir al carril inferior")

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
			image = imagenEnPosAtaque
			vida = vida - enemigo.danioDeAtaque()
			if(vida <= 0) self.morirse(enemigo)
		} 
	}
	
	method morirse(enemigo) {
		game.removeVisual(self)
		game.say(enemigo, "este no es el camino correcto")
		game.schedule(3000, game.stop())
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
	
	method evolucionar() {
		vida = 10000
		danioDeAtaque = 10000
		game.schedule(2000, { game.say(self, "eliminaste a los enemigos de los 3 carriles, recibes la bonificacion: vida = 10000,     ataque = 10000") })
	}
	
	method cambiarImagenAPosAtaque() {
		image = imagenEnPosAtaque
	}
	
	method reiniciarPersonaje() {
		vida = 100
		danioDeAtaque = 30
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

const zac = new Principal(image = "zacDeFrente.png", position = game.at(1,1), vida = 100, danioDeAtaque = 30, imagenEnPosAtaque = "zacAtacando.png", direccionDeImagenes = imagenesDeZac)

const drMundo = new Principal(image = "drMundoDeFrente.png", position = game.at(1,1), vida = 100, danioDeAtaque = 30, imagenEnPosAtaque = "drMundoAtacando.png", direccionDeImagenes = imagenesDeDrMundo)

const maokai = new Principal(image = "maokaiDeFrente.png", position = game.at(1,1), vida = 100, danioDeAtaque = 30, imagenEnPosAtaque = "maokaiAtacando.png", direccionDeImagenes = imagenesDeMaokai)

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
//			personajePrincipal.cambiarImagenAPosAtaque() //
			vida = vida - personajePrincipal.danioDeAtaque()
			 if(vida <= 0) {
			 	self.morirse(personajePrincipal, zona)
			 }
		} 
	}
  
  method morirse(personajePrincipal, zona) {
  	zona.eliminarEnemigo(self)
  	game.removeVisual(self)
  	zona.confgDePortales(personajePrincipal)
  	laGrieta.confgDeZonas(zona)
  	laGrieta.confgZonaFinal()
  }
  
  method estasColicionandoCon_En_(portal, zona) {
  	if( position == portal.position())
  		position = game.center() 
  }
	
}

// ENEMIGOS 

const enemigoCS1 = new Enemigo( image = "enemigo1.png", position = game.at(0,5), vida = 50, danioDeAtaque = 10)
const enemigoCS2 = new Enemigo( image = "enemigo1.png", position = game.at(5,5), vida = 50, danioDeAtaque = 10)
const enemigoCS3 = new Enemigo( image = "enemigo1.png", position = game.at(12,5), vida = 50, danioDeAtaque = 10)

const enemigoCM1 = new Enemigo( image = "enemigo2.png", position = game.at(0,5), vida = 100, danioDeAtaque = 10)
const enemigoCM2 = new Enemigo( image = "enemigo2.png", position = game.at(5,5), vida = 100, danioDeAtaque = 10)
const enemigoCM3 = new Enemigo( image = "enemigo2.png", position = game.at(12,5), vida = 100, danioDeAtaque = 10)

const enemigoCI1 = new Enemigo( image = "enemigo3.png", position = game.at(0,5), vida = 150, danioDeAtaque = 10)
const enemigoCI2 = new Enemigo( image = "enemigo3.png", position = game.at(5,5), vida = 150, danioDeAtaque = 10)
const enemigoCI3 = new Enemigo( image = "enemigo3.png", position = game.at(12,5), vida = 150, danioDeAtaque = 10)

const enemigoZF1 = new Enemigo( image = "enemigo1.png", position = game.at(0,2), vida = 500, danioDeAtaque = 500)
const enemigoZF2 = new Enemigo( image = "enemigo1.png", position = game.at(5,2), vida = 500, danioDeAtaque = 500)
const enemigoZF3 = new Enemigo( image = "enemigo1.png", position = game.at(12,2), vida = 500, danioDeAtaque = 500)
const enemigoZF4 = new Enemigo( image = "enemigo2.png", position = game.at(0,4), vida = 500, danioDeAtaque = 500)
const enemigoZF5 = new Enemigo( image = "enemigo2.png", position = game.at(5,4), vida = 500, danioDeAtaque = 500)
const enemigoZF6 = new Enemigo( image = "enemigo2.png", position = game.at(12,4), vida = 500, danioDeAtaque = 500)
const enemigoZF7 = new Enemigo( image = "enemigo3.png", position = game.at(0,6), vida = 500, danioDeAtaque = 500)
const enemigoZF8 = new Enemigo( image = "enemigo3.png", position = game.at(5,6), vida = 500, danioDeAtaque = 500)
const enemigoZF9 = new Enemigo( image = "enemigo3.png", position = game.at(12,6), vida = 500, danioDeAtaque = 500)