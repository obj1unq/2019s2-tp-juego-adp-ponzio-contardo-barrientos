import Ataques.*
import NPCs.*
import wollok.game.*

class Puntero {
	var property image
	var property position
	
	method interacturaCon_(boton){
		boton.ejecutarAccion()
	}
}

class Personaje inherits Puntero {
	var property puntosDeSalud
	var ataqueEspecial
	const ataqueBasico
	var energia
	var modoActual = modoDefensa
	
	method cambiarASiguienteModo(){
		if(self.estaEnModoDefensivo()){
			modoActual = modoAtaque
		}
		else {modoActual = modoDefensa}
	}
	
	method estaEnModoDefensivo() = (modoActual == modoDefensa)
	
	method usarAtaqueBasicoContra_(personaje) {
		if(not self.estaEnModoDefensivo()) {
			personaje.recibirDanio(ataqueBasico)
			self.eliminarEnemigo(personaje)
		} else { game.say(self, "Necesito estar en modo ataque") }

	}
	
	method tieneSuficienteEnergia() = true

	method usarHabilidadEspecialContra_(personaje) {
		if(not self.estaEnModoDefensivo() and self.tieneSuficienteEnergia()) {
			energia = energia - ataqueEspecial.energiaConsumida()
			personaje.recibirDanio(ataqueEspecial)
			self.eliminarEnemigo(personaje)
		} 
		else if(not self.tieneSuficienteEnergia()){
			  game.say(self, "No tengo suficiente energia")
		} 
		else {game.say(self, "Necesito estar en modo ataque")}
}
	
	method recibirDanio(ataque) {
		puntosDeSalud = puntosDeSalud - ataque.danioCausado()
	}

	method mejorarHabilidadEspecial(nuevaHabilidad) {
		ataqueEspecial = nuevaHabilidad
	}
	
	override method interacturaCon_(npc){
		npc.cargarDialogo()
	}
	
	method pasarAlSiguienteDialogo_(npc){
		npc.pasarAlSiguienteDialogo_()
	}
	
	method eliminarEnemigo(personaje){
		if(self.estaMuerto(personaje)){
			game.removeVisual(personaje)
		}
	}
	
	method estaMuerto(personaje) = personaje.puntosDeSalud() <= 0
	
	
}

object modoDefensa {
	
	method regeneracionDeEnergia(){
		
	}
	
	method regeneracionDeVida(){
		
	}
}

object modoAtaque {
	
	method regeneracionDeEnergia(){
		
	}
	
	method regeneracionDeVida(){
		
	}
}


// Personajes
const atrox = new Personaje (image = "atroxUno.png", position = game.at(1,0), puntosDeSalud = 100, energia = 120, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const nautilus = new Personaje (image = "nautilus.png", position = game.at(2,0), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)

const portal =  new  Personaje (image = "Portal-violeta.png", position = game.at(6,3),puntosDeSalud = 120, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)

const punteroMenu = new Puntero(image = "Puntero.png", position = game.at(6,1))






