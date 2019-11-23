import wollok.game.*
import Nivel.*
import NPCs.*
import Personaje.*
import Visual.*

//En cada lista se ingresan las coordenadas que no se pueden ocupar por el personaje

const limitesGenerales = [game.at(-1,0),game.at(-1,1),game.at(-1,2),game.at(-1,3),game.at(-1,4),game.at(-1,5), game.at(-1,6),game.at(-1,7),
					game.at(14,0),game.at(14,1),game.at(14,2),game.at(14,3),game.at(14,4),game.at(14,5), game.at(14,6),game.at(14,7),
						
					game.at(0,-1),game.at(1,-1),game.at(2,-1),game.at(3,-1),game.at(4,-1),game.at(5,-1),
					game.at(6,-1),game.at(7,-1),game.at(8,-1),game.at(9,-1),game.at(10,-1),game.at(11,-1),game.at(12,-1),game.at(13,-1),game.at(14,-1),
						
					game.at(0,7),game.at(1,7),game.at(2,7),game.at(3,7),game.at(4,7),game.at(5,7),
					game.at(6,7),game.at(6,7),game.at(7,7),game.at(8,7),game.at(9,7),game.at(10,7),game.at(11,7),game.at(12,7),game.at(13,7)]
					
const limitesMenuInicial = [game.at(5,1),game.at(4,1),game.at(6,1),game.at(8,1),game.at(7,1),game.at(9,1),game.at(10,1)]

const limitesSeleccionPersonajes = [game.at(8,5),game.at(8,4),game.at(8,2),game.at(8,3),game.at(8,1),
									game.at(9,2),game.at(9,3),game.at(9,1),game.at(9,4),game.at(9,5)]
									
const posicionesOriginales = [
	game.at(1,2),game.at(2,2), game.at(3,2),game.at(4,2), game.at(5,2), game.at(6,2), game.at(7,2), game.at(8,2), game.at(9,2), game.at(10,2), game.at(11,2), game.at(12,2), game.at(13,2),
	game.at(1,3),game.at(2,3), game.at(3,3),game.at(4,3), game.at(5,3), game.at(6,3), game.at(7,3), game.at(8,3), game.at(9,3), game.at(10,3), game.at(11,3), game.at(12,3), game.at(13,3), 
	game.at(1,4),game.at(2,4), game.at(3,4),game.at(4,4), game.at(5,4), game.at(6,4), game.at(7,4), game.at(8,4), game.at(9,4), game.at(10,4), game.at(11,4), game.at(12,4), game.at(13,4), 
	game.at(1,5),game.at(2,5), game.at(3,5),game.at(4,5), game.at(5,5), game.at(6,5), game.at(7,5), game.at(8,5), game.at(9,5), game.at(10,5), game.at(11,5), game.at(12,5), game.at(13,5), 
	game.at(1,6),game.at(2,6), game.at(3,6),game.at(4,1), game.at(5,6), game.at(6,6), game.at(7,6), game.at(8,6), game.at(9,6), game.at(10,6), game.at(11,6), game.at(12,6), game.at(13,6)
] // Posiciones del nivel de Logica	
						
const limitesLogica = [game.at(-1,0),game.at(-1,1),game.at(-1,2),game.at(-1,3),game.at(-1,4),game.at(-1,5), game.at(-1,6),game.at(-1,7),
					game.at(14,0),game.at(14,1),game.at(14,2),game.at(14,3),game.at(14,4),game.at(14,5), game.at(14,6),game.at(14,7),
						
					game.at(0,-1),game.at(1,-1),game.at(2,-1),game.at(3,-1),game.at(4,-1),game.at(5,-1),
					game.at(6,-1),game.at(7,-1),game.at(8,-1),game.at(9,-1),game.at(10,-1),game.at(11,-1),game.at(12,-1),game.at(13,-1),game.at(14,-1),
						
					game.at(0,7),game.at(1,7),game.at(2,7),game.at(3,7),game.at(4,7),game.at(5,7),
					game.at(6,7),game.at(6,7),game.at(7,7),game.at(8,7),game.at(9,7),game.at(10,7),game.at(11,7),game.at(12,7),game.at(13,7),
					
					game.at(0,0),game.at(1,0),game.at(2,0),game.at(3,0),game.at(4,0),game.at(5,0),game.at(6,0),game.at(7,0),game.at(8,0),game.at(9,0),game.at(10,0),
					game.at(11,0),game.at(12,0),game.at(13,0),game.at(14,0),
						
					game.at(0,1),game.at(0,2),game.at(0,3),game.at(0,4),game.at(0,5),game.at(0,6),game.at(0,7)]	

const limitesAguasEstancadas = [game.at(-1,0),game.at(-1,1),game.at(-1,2),game.at(-1,3),game.at(-1,4),game.at(-1,5), game.at(-1,6),game.at(-1,7),
					game.at(14,0),game.at(14,1),game.at(14,2),game.at(14,3),game.at(14,4),game.at(14,5), game.at(14,6),game.at(14,7),
					
					game.at(0,-1),game.at(1,-1),game.at(2,-1),game.at(3,-1),game.at(4,-1),game.at(5,-1),
					game.at(6,-1),game.at(7,-1),game.at(8,-1),game.at(9,-1),game.at(10,-1),game.at(11,-1),game.at(12,-1),game.at(13,-1),game.at(14,-1),
						
					game.at(0,5),game.at(1,6),game.at(2,6),game.at(3,6),game.at(4,7),game.at(5,7),
					game.at(6,7),game.at(6,7),game.at(7,7),game.at(8,7),game.at(9,7),game.at(10,7),game.at(11,7),game.at(12,7),game.at(13,7), 
					game.at(4,0), game.at(5,1), game.at(6,2), game.at(7,3), game.at(8,4), game.at(9,5), game.at(10,6)]
					
const countDown60 = [sesenta,cincuentaYNueve,cincuentaYOcho,cincuentaYSiete,cincuentaYSeis,cincuentaYCinco,cincuentaYCuatro,cincuentaYTres,cincuentaYDos,cuarentaYUno,cuarenta,treintaYNueve,treintaYOcho,
treintaYSiete,treintaYSeis,treintaYCinco, treintaYCuatro,treintaYTres ,treintaYDos ,treintaYUno ,treinta ,veintinueve, veintiocho,veintisiete,veintiseis, veinticinco,veinticuatro, 
veintitres,veintidos, veintiuno, veinte, diecinueve, dieciocho, diecisiete, dieciseis,quince, catorce, trece, doce, once, diez, nueve, ocho,siete,seis, cinco,cuatro,tres, dos,uno ]
					
					
					
					