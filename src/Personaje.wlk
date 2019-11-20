import Ataques.*
import NPCs.*
import wollok.game.*
import Nivel.*
import Boton.*

class Puntero {
	var property image
	var property position
	
	method interacturaCon_(boton){
		boton.ejecutarAccion()
	}
	
	method moverseEnDir(dir,limitesGenerales,limitesEsp){
		if (not limitesGenerales.contains(dir) and limitesEsp.contains(dir)) {
		position = dir
		}
	}
	
	method moverseEnSeleccion(dir,limitesGenerales,limitesEsp){
		if (not limitesGenerales.contains(dir) and limitesEsp.contains(dir)) {
			position = dir
			game.whenCollideDo(celdaInvisible, {puntero => self.cambiarImagen("CeldaVacia.png")})
			game.whenCollideDo(menuDeSeleccionDePersonaje.botonesVisibles().anyOne(), {puntero => self.cambiarImagen("SeleccionadorPersonaje.png")})
			}
		}
		
	method cambiarImagen(imagen){
		image = imagen
	}
}
	

class Personaje inherits Puntero {
	var property puntosDeSalud
	var ataqueEspecial
	const ataqueBasico
	var property energia
	var modoActual = modoDefensa
	var property inventario = []
	
	method cambiarASiguienteModo(){
		modoActual = modoActual.siguienteModo()
	}
	
	method estaEnModoDefensivo(){
		return modoActual == modoDefensa
	}
	method usarAtaqueBasicoContra_(personaje) {
		if(not self.estaEnModoDefensivo()) {
			personaje.recibirDanio(ataqueBasico)
			self.eliminarEnemigo(personaje)
		} else { game.say(self, "Necesito estar en modo ataque") }

	}
	
	method tieneSuficienteEnergia(ataque) = ataque.energiaConsumida() <= energia

	method usarHabilidadEspecialContra_(personaje) {
		if(not self.estaEnModoDefensivo() and self.tieneSuficienteEnergia(ataqueEspecial)) {
			energia = energia - ataqueEspecial.energiaConsumida()
			personaje.recibirDanio(ataqueEspecial)
			self.eliminarEnemigo(personaje)
		} 
		else if(not self.tieneSuficienteEnergia(ataqueEspecial)){
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
		organizador.pasarAlSiguienteNivel()
	}
	
	method eliminarEnemigo(personaje){
		if(self.estaMuerto(personaje)){
			game.removeVisual(personaje)
		}
	}
	
	method estaMuerto(personaje) = personaje.puntosDeSalud() <= 0
	
	override method moverseEnDir(dir, limites, limitesEspecificos){
		if (not limites.contains(dir) and not limitesEspecificos.contains(dir)) {position = dir}
	}
	
	method escucharAlgo(npc){// Prueba todavia no lo hice andar
		game.onCollideDo(npc, game.say(npc, "Tengo algo para contarte"))
	}
	
	method agarrar(objeto,nivel){
		if (nivel.objetosParaAgarrar().contains(objeto) and inventario.isEmpty()){
			inventario.add(objeto)
			game.removeVisual(objeto)
			objeto.cambiarPosicion(game.at(0,6))
			game.addVisual(objeto)
		}
		else{
			game.say(self, "No puedo agarrar este objeto")
		}
	}
	
	method soltar(objeto){
		if (not inventario.isEmpty()){ // and objetos.size() == 0
			game.removeVisual(inventario.first())
			objeto.cambiarPosicion(self.position())
			game.addVisual(objeto)
			game.onTick(300,"objetoEnCaida", {=> objeto.caerHastaElFinal(self)})
			inventario.clear()
		}
		else {
			game.say(self, "No tengo un objeto para soltar")
		}
	}	
}


class Enemigo inherits Personaje {
	
	method moverseASiguientePosicion(){
    	self.position(game.at( position.x() - 1, position.y() - 1 ))
	}
	
	method mover_Veces(cantidad){
		game.onTick(2000, "Mover Enemigo", {self.moverseASiguientePosicion()})
		game.schedule((cantidad * 2000) - 1, {game.removeTickEvent("Mover Enemigo")})
	}
}








object modoDefensa {
	const siguienteModo = modoAtaque
	
	method regeneracionDeEnergia() = 5
	
	method regeneracionDeVida() = 10
		
}

object modoAtaque {
	const siguienteModo = modoDefensa
	
	method regeneracionDeEnergia() = 15
	
	
	method regeneracionDeVida() = 5
		
}



// Personajes
const atrox = new Personaje (image = "atrox.png", position = game.at(1,0), puntosDeSalud = 100, energia = 120, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const nautilus = new Enemigo (image = "nautilus.png", position = game.at(9,6), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const gankplank = new Enemigo (image = "Gankplank.png", position = game.at(8,5), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const punteroMenu = new Puntero(image = "seleccionInicial.png", position = game.at(4,1))
const punteroMenuSeleccion = new Puntero(image = "SeleccionadorPersonaje.png", position = game.at(8,5))





