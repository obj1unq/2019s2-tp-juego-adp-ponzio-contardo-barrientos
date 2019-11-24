import Ataques.*
import NPCs.*
import wollok.game.*
import Nivel.*
import Boton.*

// DEFINICIONES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////// PERSONAJE PUNTERO ///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Puntero {
	var property image
	var property position

	
	method interactuarCon_(boton){
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// PERSONAJE ////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




class Personaje inherits Puntero{
	var property puntosDeSalud
	var property energia
	var property modoActual = modoAtaque
	var property inventario = []
	var ataqueEspecial
	const property ataqueBasico
	
	method cambiarASiguienteModo(){
		modoActual = modoActual.siguienteModo()
	}
		
	method estaEnModoDefensivo(){
		return modoActual == modoDefensa
	}
	
	method usarAtaqueBasicoContra_(personaje) {
		if(not self.estaEnModoDefensivo()) {
			game.sound("AatroxAtaqueBasico.mp3")
			personaje.recibirDanio(ataqueBasico)
			self.recibirDanio(personaje.ataqueBasico())
			self.eliminarEnemigo(personaje)
			self.eliminarPersonajeActual()
		} else { game.say(self, "Necesito estar en modo ataque") }

	}
	
	method eliminarPersonajeActual(){
		if(self.estaMuerto(self)){
			game.stop()
		}
	}	

	method tieneSuficienteEnergia(ataque) = ataque.energiaConsumida() <= energia

	method usarHabilidadEspecialContra_(personaje) {
		if(not self.estaEnModoDefensivo() and self.tieneSuficienteEnergia(ataqueEspecial)) {
			game.sound("AatroxHabilidad.mp3")
			energia = energia - ataqueEspecial.energiaConsumida()
			personaje.recibirDanio(ataqueEspecial)
			self.recibirDanio(personaje.ataqueBasico())
			self.eliminarEnemigo(personaje)
			self.eliminarPersonajeActual()
		} 
		else if(not self.tieneSuficienteEnergia(ataqueEspecial)){
			  game.say(self, "No tengo suficiente energia")
		} 
		else {
			game.say(self, "Necesito estar en modo ataque")	
		}
	}
	
	method recibirDanio(ataque) {
		puntosDeSalud = puntosDeSalud - ataque.danioCausado()
	}

	method mejorarHabilidadEspecial(nuevaHabilidad) {
		ataqueEspecial = nuevaHabilidad
	}
	
	override method interactuarCon_(npc){
		npc.cargarSiguienteParte()
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
	
	method recibirEnergia(cantidad) {
		energia = (energia + cantidad).min(100)
		self.energia()
	}
	
	method recibirCuracion(cantidad) {
		puntosDeSalud = (puntosDeSalud + cantidad).min(100)
		self.puntosDeSalud()
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// ENEMIGO //////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Enemigo inherits Personaje {
	
	method moverseASiguientePosicion(){
    	self.position(game.at( position.x() - 1, position.y() - 1 ))
	}
	
	method mover_Veces(cantidad){
		game.onTick(2000, "Mover Enemigo", {self.moverseASiguientePosicion()})
		game.schedule((cantidad * 2000) - 1, {game.removeTickEvent("Mover Enemigo")})
	}
	
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// MODOS //////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


object modoDefensa {
	const property siguienteModo = modoAtaque
	
	method regeneracionDeEnergia() = 5
	
	method regeneracionDeVida() = 10
		
}

object modoAtaque {
	const property siguienteModo = modoDefensa
	
	method regeneracionDeEnergia() = 15
	
	
	method regeneracionDeVida() = 5
		
}

// IMPLEMENTACION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// PERSONAJES ///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const atrox = new Personaje (image = "AtroxMovimiento.png", position = game.at(1,0), puntosDeSalud = 100, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const nautilus = new Enemigo (image = "nautilus.png", position = game.at(9,6), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const pyke = new Enemigo (image = "Pyke.png", position = game.at(5,5), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const graves = new Enemigo (image = "Graves.png", position = game.at(7,8), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking)
const punteroMenu = new Puntero(image = "seleccionInicial.png", position = game.at(4,1))
const punteroMenuSeleccion = new Puntero(image = "SeleccionadorPersonaje.png", position = game.at(8,5))





