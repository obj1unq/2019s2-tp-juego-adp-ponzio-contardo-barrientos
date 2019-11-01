import Ataques.*
import NPCs.*
import wollok.game.*

class Personaje {
	var property puntosDeSalud
	var property position
	var property nombreDelPersonaje
	var property energia
	var property image
	var ataqueEspecial
	const ataqueBasico
	
	
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
	
	method hablarConElNPC(npc){
		if(npc.dialogo().isEmpty()){
			game.say(self, "Parece que el NPC ya nos conto todo.")
		}else{
			game.say(npc, npc.dialogo().first())
			npc.dialogo().remove(npc.dialogo().first())
		}
	}
	
}



