import wollok.game.*
import Nivel.*
import NPCs.*
import Personaje.*

//En cada lista se ingresan las coordenadas que no se pueden ocupar por el personaje

const limitesGenerales = [game.at(-1,0),game.at(-1,1),game.at(-1,2),game.at(-1,3),game.at(-1,4),game.at(-1,5),
					game.at(12,0),game.at(12,1),game.at(12,2),game.at(12,3),game.at(12,4),game.at(12,5),
						
					game.at(0,-1),game.at(1,-1),game.at(2,-1),game.at(3,-1),game.at(4,-1),game.at(5,-1),
					game.at(6,-1),game.at(6,-1),game.at(7,-1),game.at(8,-1),game.at(9,-1),game.at(10,-1),game.at(11,-1),
						
					game.at(0,6),game.at(1,6),game.at(2,6),game.at(3,6),game.at(4,6),game.at(5,6),
					game.at(6,6),game.at(6,6),game.at(7,6),game.at(8,6),game.at(9,6),game.at(10,6),game.at(11,6)]
					
const limitesMenuInicial = [game.at(5,1),game.at(4,1),game.at(6,1),game.at(8,1),game.at(7,1),game.at(9,1),game.at(10,1)]

const limitesSeleccionPersonajes = [game.at(8,5),game.at(8,4),game.at(8,2),game.at(8,3),game.at(8,1),
									game.at(9,2),game.at(9,3),game.at(9,1),game.at(9,4),game.at(9,5)]
									
