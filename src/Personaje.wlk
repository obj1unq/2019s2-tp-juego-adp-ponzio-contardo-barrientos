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
	var property nombreDelPersonaje
	var ataqueEspecial
	const ataqueBasico
	var property energia
	
	method usarAtaqueBasico(personaje) {
		personaje.aplicarAtaque(ataqueBasico)
	}
	
	method usarHabilidadEspecialContra(personaje) {
		if(energia <  ataqueEspecial.energiaConsumida())
			self.error("El ataque no puede ser utilizado actualmente: No hay energia")
			energia = energia - ataqueEspecial.energiaConsumida()
			personaje.aplicarAtaque(ataqueEspecial)
	}
	
	method aplicarAtaque(ataque) {
		puntosDeSalud = puntosDeSalud - ataque.danoCausado()
	}

	method mejorarHabilidadEspecial(nuevaHabilidad) {
		ataqueEspecial = nuevaHabilidad
	}
	
	override method interacturaCon_(npc){
		npc.cargarDialogo()
	}
	
}

// Personajes
const atrox = new Personaje (nombreDelPersonaje = "Atrox",image = "atrox.png", position = game.at(1,0), puntosDeSalud = 100, energia = 120, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const portal =  new  Personaje (nombreDelPersonaje = "PortalVioleta",image = "Portal-violeta.png", position = game.at(6,3),puntosDeSalud = 120, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)

const punteroMenu = new Puntero(image = "Puntero.png", position = game.at(6,1))





