import Visual.*
import Numeros.*
import wollok.game.*


class Medidor {
 	method buscarUnValor(valor)
 	method estaElValorEnElMedidor(valor)
}

object signoVida inherits Medidor {
	var property image = "IconoSalud.png"
	var property position = game.at(13,6)
	var property valorActual = cienVida
	const property valoresDelMedidor = [ceroVida,unoVida, dosVida, tresVida, cuatroVida, cincoVida, seisVida, sieteVida, ochoVida, nueveVida, diezVida,
							   onceVida, doceVida, treceVida, catorceVida, quinceVida, dieciseisVida, diecisieteVida, dieciochoVida, diecinueveVida, veinteVida,
							   veintiunoVida, veintidosVida, veintitresVida, veinticuatroVida, veinticincoVida, veintiseisVida, veintisieteVida, veintiochoVida, veintinueveVida, treintaVida,
							   treintaunoVida, treintadosVida, treintatresVida, treintacuatroVida, treintacincoVida, treintaseisVida, treintasieteVida, treintaochoVida, treintanueveVida, cuarentaVida,
							   cuarentaunoVida, cuarentadosVida, cuarentatresVida, cuarentacuatroVida, cuarentacincoVida, cuarentaseisVida, cuarentasieteVida, cuarentaochoVida, cuarentanueveVida, cincuentaVida,
							   cincuentaunoVida, cincuentadosVida, cincuentatresVida, cincuentacuatroVida, cincuentacincoVida, cincuentaseisVida, cincuentasieteVida, cincuentaochoVida, cincuentanueveVida, sesentaVida,
							   sesentaunoVida, sesentadosVida, sesentatresVida, sesentacuatroVida, sesentacincoVida, sesentaseisVida, sesentasieteVida, sesentaochoVida, sesentanueveVida, setentaVida,
							   setentaunoVida, setentadosVida, setentatresVida, setentacuatroVida, setentacincoVida, setentaseisVida, setentasieteVida, setentaochoVida, setentanueveVida, ochentaVida,
							   ochentaunoVida, ochentadosVida, ochentatresVida, ochentacuatroVida, ochentacincoVida, ochentaseisVida, ochentasieteVida, ochentaochoVida, ochentanueveVida, noventaVida,
							   noventaunoVida, noventadosVida, noventatresVida, noventacuatroVida, noventacincoVida, noventaseisVida, noventasieteVida, noventaochoVida, noventanueveVida, cienVida]
	
	override method estaElValorEnElMedidor(valor) = valoresDelMedidor.any({numero => numero.valor() == valor})
	
	override method buscarUnValor(valor) = 
	if(not self.estaElValorEnElMedidor(valor)) {
		self.error("No esta el valor buscado")
	} else {valoresDelMedidor.find({numero => numero.valor() == valor})}
	
	method actualizarValorActual(valor) {
		valorActual = self.buscarUnValor(valor) 
	}
}

object signoEnergia inherits Medidor {
	var property image = "IconoEnergia.png"
	var property position = game.at(13,4)
	var property valorActual = cienEnergia
	const property valoresDelMedidor = [ceroEnergia,unoEnergia, dosEnergia, tresEnergia, cuatroEnergia, cincoEnergia, seisEnergia, sieteEnergia, ochoEnergia, nueveEnergia, diezEnergia,
							   onceEnergia, doceEnergia, treceEnergia, catorceEnergia, quinceEnergia, dieciseisEnergia, diecisieteEnergia, dieciochoEnergia, diecinueveEnergia, veinteEnergia,
							   veintiunoEnergia, veintidosEnergia, veintitresEnergia, veinticuatroEnergia, veinticincoEnergia, veintiseisEnergia, veintisieteEnergia, veintiochoEnergia, veintinueveEnergia, treintaEnergia,
							   treintaunoEnergia, treintadosEnergia, treintatresEnergia, treintacuatroEnergia, treintacincoEnergia, treintaseisEnergia, treintasieteEnergia, treintaochoEnergia, treintanueveEnergia, cuarentaEnergia,
							   cuarentaunoEnergia, cuarentadosEnergia, cuarentatresEnergia, cuarentacuatroEnergia, cuarentacincoEnergia, cuarentaseisEnergia, cuarentasieteEnergia, cuarentaochoEnergia, cuarentanueveEnergia, cincuentaEnergia,
							   cincuentaunoEnergia, cincuentadosEnergia, cincuentatresEnergia, cincuentacuatroEnergia, cincuentacincoEnergia, cincuentaseisEnergia, cincuentasieteEnergia, cincuentaochoEnergia, cincuentanueveEnergia, sesentaEnergia,
							   sesentaunoEnergia, sesentadosEnergia, sesentatresEnergia, sesentacuatroEnergia, sesentacincoEnergia, sesentaseisEnergia, sesentasieteEnergia, sesentaochoEnergia, sesentanueveEnergia, setentaEnergia,
							   setentaunoEnergia, setentadosEnergia, setentatresEnergia, setentacuatroEnergia, setentacincoEnergia, setentaseisEnergia, setentasieteEnergia, setentaochoEnergia, setentanueveEnergia, ochentaEnergia,
							   ochentaunoEnergia, ochentadosEnergia, ochentatresEnergia, ochentacuatroEnergia, ochentacincoEnergia, ochentaseisEnergia, ochentasieteEnergia, ochentaochoEnergia, ochentanueveEnergia, noventaEnergia,
							   noventaunoEnergia, noventadosEnergia, noventatresEnergia, noventacuatroEnergia, noventacincoEnergia, noventaseisEnergia, noventasieteEnergia, noventaochoEnergia, noventanueveEnergia, cienEnergia]
	
	override method estaElValorEnElMedidor(valor) = valoresDelMedidor.any({numero => numero.valor() == valor})
	
	override method buscarUnValor(valor) = 
	if(not self.estaElValorEnElMedidor(valor)) {
		self.error("No esta el valor buscado")
	} else {valoresDelMedidor.find({numero => numero.valor() == valor})}
	
	method actualizarValorActual(valor) {
		valorActual = self.buscarUnValor(valor) 
	}
}


