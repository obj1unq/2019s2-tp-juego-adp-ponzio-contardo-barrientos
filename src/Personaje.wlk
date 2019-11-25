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

	method interacturaCon_(ente){
		ente.cargarSiguienteParte(self)
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
	const sonidoAtaqueBasico
	const sonidoHabilidad
	var ataqueEspecial
	const property ataqueBasico
	
	method cambiarASiguienteModo(){
		game.removeVisual(modoActual)
		modoActual = modoActual.siguienteModo()
		game.addVisual(modoActual)
	}
	method estaEnModoDefensivo(){
		return modoActual == modoDefensa
	}
	
	override method interacturaCon_(ente){
		ente.cargarSiguienteParte(self)
	}
	method actualizarPersonajeEnNivel() {
		game.removeVisual(self)
		game.addVisual(self)
	}
	
	method usarAtaqueBasicoContra_(personaje) {
		if(not self.estaEnModoDefensivo()) {
			game.sound(sonidoAtaqueBasico)
			personaje.recibirDanio(ataqueBasico)
			self.recibirDanio(personaje.ataqueBasico())
			self.eliminarEnemigo(personaje)
			self.eliminarPersonajeActual()
		} else { game.say(self, "Necesito estar en modo ataque") }

	}
	
	method eliminarPersonajeActual(){
		if(self.estaMuerto(self)){
			finalMalo.cargarTodo(self)
		}
	}	

	method tieneSuficienteEnergia(ataque) = ataque.energiaConsumida() <= energia

	method usarHabilidadEspecialContra_(personaje) {
		if(not self.estaEnModoDefensivo() and self.tieneSuficienteEnergia(ataqueEspecial)) {
			game.sound(sonidoHabilidad)
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
	
	method cambiarAspecto() {
		image = "AtroxMoviminetoAssendido.png"
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
	const property image = "ModoPeleaOff.png"
	const property position = game.at(13,1)
	
	method regeneracionDeEnergia() = 20
	
	method regeneracionDeVida() = 20
		
}

object modoAtaque {
	const property siguienteModo = modoDefensa
	const property image = "ModoPeleaOn.png"
	const property position = game.at(13,1)
	
	method regeneracionDeEnergia() = 20
	
	
	method regeneracionDeVida() = 10
		
}


// IMPLEMENTACION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// PERSONAJES ///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const atrox = new Personaje (image = "AtroxMovimiento.png", position = game.at(1,0), puntosDeSalud = 100, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking, sonidoHabilidad = "AatroxHabilidad.mp3" ,sonidoAtaqueBasico = "AatroxAtaqueBasico.mp3")
const jax = new Personaje (image = "Jax.png", position = game.at(1,0), puntosDeSalud = 100, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking, sonidoHabilidad = "AatroxHabilidad.mp3" ,sonidoAtaqueBasico = "AatroxAtaqueBasico.mp3")
const nautilus = new Enemigo (image = "nautilus.png", position = game.at(9,6), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking, sonidoHabilidad = "AatroxHabilidad.mp3" ,sonidoAtaqueBasico = "AatroxAtaqueBasico.mp3")
const pyke = new Enemigo (image = "Pyke.png", position = game.at(5,5), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking, sonidoHabilidad = "AatroxHabilidad.mp3" ,sonidoAtaqueBasico = "AatroxAtaqueBasico.mp3")
const graves = new Enemigo (image = "Graves.png", position = game.at(7,8), puntosDeSalud = 200, energia = 100, ataqueBasico = golpeAtrox,ataqueEspecial = golpeteoDarking, sonidoHabilidad = "AatroxHabilidad.mp3" ,sonidoAtaqueBasico = "AatroxAtaqueBasico.mp3")
const punteroMenu = new Puntero(image = "seleccionInicial.png", position = game.at(4,1))
const punteroMenuSeleccion = new Puntero(image = "SeleccionadorPersonaje.png", position = game.at(8,5))





