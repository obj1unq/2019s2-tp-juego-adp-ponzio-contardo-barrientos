import wollok.game.*

class Visual {
	var property image
	var property position
	
	method cambiarPosicion(posicion){
		position = posicion
	}
	
	method cambiarImagen(imagen, objeto){
		if (game.colliders(self).contains(objeto)){image = imagen}
		else {image = "espacioErroneo.png"}
	}
	
	method caerHastaElFinal(personaje){
		if (position.y() > 0){
			// personaje.objetoActual().clear()
			game.removeVisual(self)
			position = position.down(1)
			game.addVisual(self)
		}
		else if (game.colliders(self).size() > 1) {
			game.removeVisual(self)
			position = position.up(1)
			game.addVisual(self)
			game.removeTickEvent("objetoEnCaida")
		}
		else {
			game.removeTickEvent("objetoEnCaida")
		}
	}
} 


const fondoMenu = new Visual(image = "FondoMenuPrincipal.png" , position = game.at(0,0))
const fondoMenuSeleccion = new Visual(image = "FondoMenuSeleccion1.png" , position = game.at(0,0))
const fondoLobbyUno = new Visual(image = "FondoLobbyUno.png" , position = game.at(0,0))
const fondoAguasEstancadas = new Visual(image = "FondoAguasEstancadas.png" , position = game.at(0,0))
const fondoAguasEstancadasDialogo = new Visual(image = "AguasEstancadasFondo.png" , position = game.at(0,0))
const fondoNivelLogica = new Visual(image = "nivelMatFondo.png", position = game.at(0,0))
const fondoFinal = new Visual(image = "fondoFinal.png", position = game.at(0,0))

// Celdas Nivel Logica 

const espacioALlenar = new Visual(image = "espacioErroneo.png", position = game.at(2,0) )
const espacioALlenar2 = new Visual(image = "espacioErroneo.png", position = game.at(4,0) )
const espacioALlenar3 = new Visual(image = "espacioErroneo.png", position = game.at(6,0) )
const espacioALlenar4 = new Visual(image = "espacioErroneo.png", position = game.at(8,0) )
const espacioALlenar5 = new Visual(image = "espacioErroneo.png", position = game.at(10,0) )
const espacioALlenar6 = new Visual(image = "espacioErroneo.png", position = game.at(12,0) )
const inventarioVisual = new Visual(image = "Inventario.png", position = game.at(0,6))

// Elementos nivel logica

const banana = new Visual(image = "Potasio.png",position = game.at(5,5))
const litio = new Visual(image = "Litio.png", position = game.at (10,4))
const litio2 = new Visual(image = "Litio2.png", position = game.at (2,3))
const oxigeno = new Visual(image = "Oxigeno.png", position = game.at (7,4))
const oxigeno2 = new Visual(image = "Oxigeno2.png", position = game.at (2,1))
const uranio = new Visual(image = "Uranio.png", position = game.at (10,5))
const calavera = new Visual(image = "Calavera.png", position = game.at (3,4))
const moneda = new Visual(image = "Moneda.png", position = game.at (11,5))
const oro = new Visual(image = "Oro.png", position = game.at (6,2))
const oxido = new Visual(image = "Oxido.png", position = game.at (7,5))
const pirata = new Visual(image = "Pirata.png", position = game.at (9,3))

const barraTiempo = new Visual(image="barraTiempo.png", position = game.at(0,0))
const sesenta = new Visual(image="60.png", position = game.at(0,5))
const cincuentaYNueve = new Visual(image = "59.png", position = game.at(0,5))
const cincuentaYOcho = new Visual(image = "58.png", position = game.at(0,5))
const cincuentaYSiete = new Visual(image = "57.png", position = game.at(0,5))
const cincuentaYSeis = new Visual(image = "56.png", position = game.at(0,5))
const cincuentaYCinco = new Visual(image = "55.png", position = game.at(0,5))
const cincuentaYCuatro = new Visual(image = "54.png", position = game.at(0,5))
const cincuentaYTres = new Visual(image = "53.png", position = game.at(0,5))
const cincuentaYDos = new Visual(image = "52.png", position = game.at(0,5))
const cincuentaYUno = new Visual(image = "51.png", position = game.at(0,5))
const cincuenta = new Visual(image = "50.png", position = game.at(0,5))
const cuarentaYNueve = new Visual(image = "49.png", position = game.at(0,5))
const cuarentaYOcho = new Visual(image = "48.png", position = game.at(0,5))
const cuarentaYSiete = new Visual(image = "47.png", position = game.at(0,5))
const cuarentaYSeis = new Visual(image = "46.png", position = game.at(0,5))
const cuarentaYCinco = new Visual(image = "45.png", position = game.at(0,5))
const cuarentaYCuatro = new Visual(image = "44.png", position = game.at(0,5))
const cuarentaYTres = new Visual(image = "43.png", position = game.at(0,5))
const cuarentaYDos = new Visual(image = "42.png", position = game.at(0,5))
const cuarentaYUno = new Visual(image = "41.png", position = game.at(0,5))
const cuarenta = new Visual(image = "40.png", position = game.at(0,5))
const treintaYNueve = new Visual(image = "39.png", position = game.at(0,5))
const treintaYOcho = new Visual(image = "38.png", position = game.at(0,5))
const treintaYSiete = new Visual(image = "37.png", position = game.at(0,5))
const treintaYSeis = new Visual(image = "36.png", position = game.at(0,5))
const treintaYCinco = new Visual(image = "35.png", position = game.at(0,5))
const treintaYCuatro = new Visual(image = "34.png", position = game.at(0,5))
const treintaYTres = new Visual(image = "33.png", position = game.at(0,5))
const treintaYDos = new Visual(image = "32.png", position = game.at(0,5))
const treintaYUno = new Visual(image = "31.png", position = game.at(0,5))
const treinta = new Visual(image = "30.png", position = game.at(0,5))
const veintinueve = new Visual(image = "29.png", position = game.at(0,5))
const veintiocho = new Visual(image = "28.png", position = game.at(0,5))
const veintisiete = new Visual(image = "27.png", position = game.at(0,5))
const veintiseis = new Visual(image = "26.png", position = game.at(0,5))
const veinticinco = new Visual(image = "25.png", position = game.at(0,5))
const veinticuatro = new Visual(image = "24.png", position = game.at(0,5))
const veintitres = new Visual(image = "23.png", position = game.at(0,5))
const veintidos = new Visual(image = "22.png", position = game.at(0,5))
const veintiuno = new Visual(image = "21.png", position = game.at(0,5))
const veinte = new Visual(image = "20.png", position = game.at(0,5))
const diecinueve = new Visual(image = "19.png", position = game.at(0,5))
const dieciocho = new Visual(image = "18.png", position = game.at(0,5))
const diecisiete = new Visual(image = "17.png", position = game.at(0,5))
const dieciseis = new Visual(image = "16.png", position = game.at(0,5))
const quince = new Visual(image = "15.png", position = game.at(0,5))
const catorce = new Visual(image = "14.png", position = game.at(0,5))
const trece = new Visual(image = "13.png", position = game.at(0,5))
const doce = new Visual(image = "12.png", position = game.at(0,5))
const once = new Visual(image = "11.png", position = game.at(0,5))
const diez = new Visual(image = "10.png", position = game.at(0,5))
const nueve = new Visual(image = "9.png", position = game.at(0,5))
const ocho = new Visual(image = "8.png", position = game.at(0,5))
const siete = new Visual(image = "7.png", position = game.at(0,5))
const seis = new Visual(image = "6.png", position = game.at(0,5))
const cinco = new Visual(image = "5.png", position = game.at(0,5))
const cuatro = new Visual(image = "4.png", position = game.at(0,5))
const tres = new Visual(image = "3.png", position = game.at(0,5))
const dos = new Visual(image = "2.png", position = game.at(0,5))
const uno = new Visual(image = "1.png", position = game.at(0,5))





