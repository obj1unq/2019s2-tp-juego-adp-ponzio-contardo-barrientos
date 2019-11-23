import wollok.game.*

object GrietaDelInvocador {
	
	method iniciar() {
		zonaPrincipal.confg()
		teclado.confgLaGrietaDelInvocador()
		game.start()
	}
	
	method irSiguienteZona(zona) {
		game.clear()
		zona.confg()
	}
	
}

object teclado {
	
	method confgDeZonas() {
		keyboard.c().onPressDo{ 
			GrietaDelInvocador.irSiguienteZona(carrilSuperior)
		}
		keyboard.d().onPressDo{ 
			GrietaDelInvocador.irSiguienteZona(carrilMedio)
		}
		keyboard.e().onPressDo{ 
			GrietaDelInvocador.irSiguienteZona(carrilInferior)
		}
	}
	
	method confgDeCarriles() {
		keyboard.a().onPressDo{ 
			GrietaDelInvocador.irSiguienteZona(zonaPrincipal)
		}
		keyboard.b().onPressDo{ 
			GrietaDelInvocador.irSiguienteZona(zonaFinal)
		}
	}
	
	method confgLaGrietaDelInvocador() {
		keyboard.f().onPressDo{ game.schedule(3000, {game.stop()}) }
	}
}

class Zona {
	
	var property fondo
	var property ancho
	var property alto
	var property personajePrincipal
	var property portales = []
	var property enemigos = [] 
	
	method confg() {
		game.title("la grieta del invocador")
		game.boardGround(fondo)
		game.width(ancho)
		game.height(alto)
		self.confgDeEnemigos()
		self.confgDePortales()
		self.confgDePersonajePrincipal()
	}
	
	method irSiguienteZona() {
		teclado.confgDeZonas()
	}
	
	method confgDePersonajePrincipal() {
		game.addVisualCharacter(personajePrincipal)
		enemigos.forEach({ enemigo => personajePrincipal.atacar(enemigo, self) })
	}
	
	method confgDeEnemigos() {
		if( not enemigos.isEmpty() ) {
			enemigos.forEach({ enemigo => game.addVisual(enemigo) })
			enemigos.forEach({ enemigo => enemigo.moverseCada(3000) })
			enemigos.forEach({ enemigo => enemigo.atacar(personajePrincipal, self) })
		}
	}
	
	method confgDePortales() {
		if( enemigos.isEmpty() ) {
			portales.forEach({ 
				portal => game.addVisual(portal)
				portal.colisionasteCon_En_(personajePrincipal, self)
			})
		}
			
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
	var zonaPrincipal = new Zona( fondo = "zonaPrincipal.png" ,ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalSuperior, portalMedio, portalInferior])
	var zonaFinal = new Zona( fondo = "zonaFinal.png" ,ancho = 14, alto = 7, personajePrincipal = brand, portales = [], enemigos = [])
	var carrilSuperior = new Carril( fondo = "carrilSuperior.png" ,ancho = 14, alto = 7, personajePrincipal = drMundo, portales = [portalPrincipal, portalFinal], enemigos = [enemigoCS])
	var carrilMedio = new Carril( fondo = "carrilMedio.png" ,ancho = 14, alto = 7, personajePrincipal = maokai, portales = [portalPrincipal, portalFinal], enemigos = [enemigoCM])
	var carrilInferior = new Carril( fondo = "carrilInferior.png" ,ancho = 14, alto = 7, personajePrincipal = darius, portales = [portalPrincipal, portalFinal], enemigos = [enemigoCI])

class Portal {
	
	var property image
	var property position
	var property dialogo
	
	method colisionasteCon_En_(personajePrincipal, zona) {
		game.onCollideDo(self, { parametro => personajePrincipal.estasColicionandoCon_En_(self, zona) })
	}
	
}

// PORTALES

const portalPrincipal = new Portal (image = "portal.png" , position = game.at(0,5), dialogo = "presione la tecla A para ir a la zona principal" )
const portalSuperior = new Portal (image = "portal.png", position = game.at(2,5), dialogo = "presione la tecla C para ir al carril superior")
const portalMedio = new Portal (image = "portal.png", position = game.at(10,5), dialogo = "presione la tecla D para ir al carril medio")
const portalInferior = new Portal (image = "portal.png", position = game.at(12,1), dialogo = "presione la tecla E para ir al carril inferior")
const portalFinal = new Portal (image = "portal.png", position = game.at(6,5), dialogo = "presione la tecla B para ir a la zona final")

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
	
}

// ENEMIGOS 

const enemigoCS = new Enemigo( image = "enemigo1.png", position = game.center(), vida = 30, danioDeAtaque = 10 )
const enemigoCM = new Enemigo( image = "enemigo2.png", position = game.center(), vida = 30, danioDeAtaque = 10 )
const enemigoCI = new Enemigo( image = "enemigo3.png", position = game.center(), vida = 100, danioDeAtaque = 100 )

