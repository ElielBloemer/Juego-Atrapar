import wollok.game.*
import hijitus.*
import juegoHijitus.*

class Randoms {

	var property position

	method image()

	method vidasASumar()

	method queVoyADecir()

	method puntosQueOtorga()

	method choqueAHijitus()

	method perderAltura() {
		position = position.down(1)
		self.corregirPosicion()
	}

	method corregirPosicion() {
		if (self.salioDelTablero()) {
			hijitus.restarVida(1)
			hijitusUI.chequearEstadoDeJuego()
			self.restaurarPosition()
		}
	}

	method restaurarPosition() {
		position = new Position(x = 0.randomUpTo(16).roundUp(), y = 9)
	}

	method salioDelTablero() = self.position().y() == -1

}

object profeNeurus inherits Randoms(position = new Position(x = 0.randomUpTo(17).roundUp(), y = 9)) { // o game.at(1.randomUpTo(10).roundUp(), 5)))

	override method image() = "profNeurusOK.png"

	override method choqueAHijitus() {
		game.sound("chan.mp3").play()
	}

	override method vidasASumar() = 0

	override method queVoyADecir() = "NO SUMA VIDA"

	override method puntosQueOtorga() = 0

}

object cienPesos inherits Randoms(position = new Position(x = 0.randomUpTo(17).roundUp(), y = 9)) { // o game.at(1.randomUpTo(10).roundUp(), 5)))

	override method image() = "100Pesos.png"

	override method choqueAHijitus() {
	}

	override method vidasASumar() = 0

	override method queVoyADecir() = "NO SUMA VIDA"

	override method puntosQueOtorga() = 100

}

object pichichu inherits Randoms(position = new Position(x = 0.randomUpTo(17).roundUp(), y = 9)) { // o game.at(1.randomUpTo(10).roundUp(), 5)))

	override method image() = "pichichu.png"

	override method choqueAHijitus() {
		game.sound("vamoniubel.mp3").play()
	}

	override method vidasASumar() = 3

	override method queVoyADecir() = "2 VIDAS"

	override method puntosQueOtorga() = 400

}

object oaky inherits Randoms(position = new Position(x = 0.randomUpTo(17).roundUp(), y = 9)) { // o game.at(1.randomUpTo(10).roundUp(), 5)))

	override method image() = "Oaky.png"

	override method choqueAHijitus() {
	}

	override method vidasASumar() = 1

	override method queVoyADecir() = "1 VIDA"

	override method puntosQueOtorga() = 200

}

/*class Caritas {

 * 	var property position // = new Position(x = 0.randomUpTo(16).roundUp(), y = 9)
 * 	var property image
 * 	var property incrementarVida

 * 	method perderAltura(nuevaPosicion) {
 * 		// const y = nuevaPosicion.y()
 * 		// if (nuevaPosicion == game.at(0, y)) self.position(game.at(16, y)) else self.position(nuevaPosicion)
 * 		if (self.salioDelTablero(nuevaPosicion)) {
 * 			hijitus.restarVida(1)
 * 				// hijitus.restarPontos()
 * 				// hijitusUI.modificarVida(0)
 * 				// hijitusUI.chequearEstadoDeJuego()
 * 			self.resetearPosicion()
 * 		}
 * 	}

 * 	method salioDelTablero(nuevaPosicion) = nuevaPosicion.y() == -1

 * 	method resetearPosicion() {
 * 		position = (game.at(0.randomUpTo(16).roundUp(), 9))
 * 	}

 * 	method pontosAIncrementar() = 0.randomUpTo(100).roundUp()

 * 	method choqueAHijitus() {
 * 	}

 }*/
//const profeNeurus = new Caritas(position = game.at(valor.valorDeX(), 9), image = "profNeurusOK.png", incrementarVida = 0)
//const oaky = new Caritas(position = game.at(valor.valorDeX(), 9), image = "Oaky.png", incrementarVida = 0)
//const cienPesos = new Caritas(position = game.at(valor.valorDeX(), 9), image = "100Pesos.png", incrementarVida = 0)
//const pichichu = new Caritas(position = game.at(valor.valorDeX(), 9), image = "pichichu.png", incrementarVida = 1)
/*object configurarCaida {

 * 	method movimientosDelRostros() {
 * 		// game.onTick( 600, "caeProfeNeurus", { profeNeurus.perderAltura(profeNeurus.position().down(1))})
 * 		// game.onTick(450, "caePichichu", { pichichu.perderAltura(pichichu.position().down(1))})
 * 		// game.onTick(550, "caeOaky", { oaky.perderAltura()})
 * 		game.onTick(700, "caePesos", { cienPesos.perderAltura()})
 * 		game.onTick(600, "caeProfeNeurus", { profeNeurus.perderAltura()})
 * 		game.onTick(450, "caePichichu", { pichichu.perderAltura()})
 * 	}

 }*/
// }
//}
//const auto0 = new Vehiculo(position = game.at(10, 1), image = "policia.png")
// instancia de los personajes
/*class ObjetosAleatorios {

 * 	var property position = new Position(x = 0.randomUpTo(16).roundUp(), y = 9)
 * 	var property foiAtrapado = false
 * 	var property valor = self.valorAlAzar()

 * 	method esPichichu() = false

 * 	method valorAlAzar() = 0.randomUpTo(6).roundUp()// aca genera los numeros que saldran para los rostros

 * 	// aca defino la foto a ser elegida al azar
 * 	method definirLaFoto() = if (valor == 1) return "profNeurusOK.png" else if (valor == 2) return "Oaky.png" else if (valor == 3) return "100Pesos.png" else if (valor == 4) return "pucho.png" else if (valor == 5) return "cachavacha.png" else if (valor == 6) return "roca.png"

 * 	method image() = self.definirLaFoto()

 * 	method perderAltura() {
 * 		position = position.down(1)
 * 	}

 * 	method incrementarVida() = 0

 * }

 * class Pichichu {

 * 	var property position = new Position(x = 0.randomUpTo(16).roundUp(), y = 9)
 * 	var property foiAtrapado = true

 * 	method esPichichu() = true

 * 	method image() = "pichichu.png"

 * 	method perderAltura() {
 * 		position = position.down(1)
 * 	}

 * 	method incrementarVida() = 2

 }*/
