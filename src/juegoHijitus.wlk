import wollok.game.*
import hijitus.*
import objetoParaLasCanasta.*

object hijitusUI {

	var property enJuego = false

	method configurarAcciones() {
		keyboard.left().onPressDo{ hijitus.caminarA(hijitus.position().left(1))}
		keyboard.right().onPressDo{ hijitus.caminarA(hijitus.position().right(1))}
	}

	method chequearEstadoDeJuego() {
		if (hijitus.teQuedasteSinVida()) {
			self.enJuego(false)
			configuracion.perdio()
		}
		if (score.alcanzarMeta()) {
			self.enJuego(false)
			configuracion.gano()
		}
	}

	method configurarPersonajes() {
		game.addVisual(hijitus)
		game.addVisual(vidaUm)
		game.addVisual(vidaDos)
		game.addVisual(vidaTres)
		game.addVisual(profeNeurus)
		game.addVisual(pichichu)
		//game.addVisual(oaky)
		//game.addVisual(cienPesos)
		game.showAttributes(hijitus)
	}

	method configurarEventos() {
		if (self.enJuego()) {
			// game.onTick(8000, "aparecePichichu", { self.agregarPichichu()})
			//game.onTick(800, "caePesos", { cienPesos.perderAltura()})
			game.onTick(600, "caeProfeNeurus", { profeNeurus.perderAltura()})
			game.onTick(500, "caePichichu", { pichichu.perderAltura()})
			//game.onTick(400, "caeOaky", { oaky.perderAltura()})
			//game.onCollideDo(oaky, { algo => self.atraparObjeto(oaky)})
			//game.onCollideDo(cienPesos, { algo => self.atraparObjeto(cienPesos)})
			game.onCollideDo(profeNeurus, { algo => self.atraparObjeto(profeNeurus,"caeProfeNeurus")})
			game.onCollideDo(pichichu, { algo => self.atraparObjeto(pichichu,"caePichichu")})
		}
	}

	// method agregarPichichu() {
	// game.addVisual(pichichu)
	// game.onTick(800, "caePichichu", { pichichu.perderAltura()})
	// game.onCollideDo(pichichu, { algo => self.atraparObjeto(pichichu, "caePichichu")})
	// }
	method atraparObjeto(objeto,evento) {
		hijitus.sumarVida(objeto.vidasASumar())
		score.sumarScore(objeto.puntosQueOtorga())
		game.say(hijitus, objeto.queVoyADecir())
		objeto.choqueAHijitus()
		game.removeTickEvent(evento)
		game.onTick(200.randomUpTo(400).roundUp(), evento, { objeto.perderAltura()})
		objeto.restaurarPosition()
		self.chequearEstadoDeJuego()
	}

}

object configuracion {

	const musicaPrincipal = game.sound("soundtrackUno.mp3")

	method darInicio() {
		game.addVisual(primerFondo)
			// keyboard.enter().onPressDo{ self.fondoJuego()}
		keyboard.enter().onPressDo{ self.elegirComplejidad()}
	}

	method elegirComplejidad() {
		game.addVisual(fondoComplejidad)
		game.removeVisual(primerFondo)
		game.addVisual(mano)
			// game.addVisual(nivelEasy)
			// game.addVisual(nivelMedium)
			// game.addVisual(nivelHard)
		keyboard.up().onPressDo{ mano.moverseA(mano.position().up(2))}
		keyboard.down().onPressDo{ mano.moverseA(mano.position().down(2))}
		keyboard.a().onPressDo{ self.elegirNivel()}
	}

	method elegirNivel() {
		if (mano.position() == game.at(3, 6)) {
			// score.metaAAlcanzar(nivelEasy.metaScore())
			score.metaAAlcanzar(1000)
		}
		if (mano.position() == game.at(3, 4)) {
			// score.metaAAlcanzar(nivelMedium.metaScore())
			score.metaAAlcanzar(2000)
		// self.fondoInicioJuego()
		}
		if (mano.position() == game.at(3, 2)) {
			// score.metaAAlcanzar(nivelHard.metaScore())
			score.metaAAlcanzar(3000)
		// self.fondoInicioJuego()
		}
		self.fondoInicioJuego()
	}

	method fondoInicioJuego() {
		game.clear()
		game.addVisual(fondoPrincipal)
		hijitusUI.enJuego(true)
		self.configuracionInicio()
	}

	method configuracionInicio() {
		// game.removeVisual(primerFondo)
		game.addVisual(score)
		hijitusUI.configurarPersonajes()
		hijitusUI.configurarAcciones()
		hijitusUI.configurarEventos()
		musicaPrincipal.play()
	}

	method perdio() {
		self.terminarJuego("gameOverUno.mp3", fondoPerdio)
	}

	method gano() {
		self.terminarJuego("gano.mp3", fondoDeGano)
	}

	method terminarJuego(musica, fondoQueFinalizara) {
		game.clear()
		musicaPrincipal.pause()
		game.addVisual(fondoQueFinalizara)
		game.schedule(7000, { game.stop()})
		game.sound(musica).play()
	}

}

object mano {

	var property position = game.at(3, 6)
	var property image = "mano.png"

	method moverseA(nuevaPosicion) {
		position = nuevaPosicion
		self.corregirPosition()
	}

	method corregirPosition() {
		position = new Position(x = 3, y = (position.y().max(2)).min(6))
	}

}

class Fondos {

	var property position
	var property image

}

object primerFondo {

	var property position = game.at(0, 0)
	var property image = "fondoInicial.jpg"

}

object fondoPrincipal {

	var property position = game.at(0, 0)
	var property image = "fondoPrincipal.jpg"

}

object fondoPerdio {

	var property position = game.at(0, 0)
	var property image = "gameOver.jpg"

}

object fondoComplejidad {

	var property position = game.at(0, 0)
	var property image = "fondoComplejidad.jpg"

}

object fondoDeGano {

	var property position = game.at(0, 0)
	var property image = "fondoganhou.jpg"

}


// ------------------------------------------------
//           VIDAS EN PANTALLA

class HijitusChiquito {

	var property position = new Position(x = 0, y = 9)

	method image()

	method hijitusVida(num) = hijitus.hijitusVida() < num

}

object vidaUm inherits HijitusChiquito(position = game.at(0, 9)) {

	override method image() = if (self.hijitusVida(1)) "vidaVacia.png" else "vidaHijitus.png"

}

object vidaDos inherits HijitusChiquito(position = game.at(1, 9)) {

	override method image() = if (self.hijitusVida(2)) "vidaVacia.png" else "vidaHijitus.png"

}

object vidaTres inherits HijitusChiquito(position = game.at(2, 9)) {

	override method image() = if (self.hijitusVida(3)) "vidaVacia.png" else "vidaHijitus.png"

}

object paleta {

	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"

}

// ----------------------------------------------------------------
//                           SCORE
object score {

	var property position = game.at(15, 9)
	var property score = 0
	var property metaAAlcanzar = 0

	method text() = "Score: " + score + "  Meta: " + metaAAlcanzar

	method textColor() = paleta.verde()

	method sumarScore(cantidad) {
		score = score + cantidad
	}

	method alcanzarMeta() = score >= metaAAlcanzar

}

/*const primerFondo = new Fondos(position = game.at(0, 0), image = "fondoInicial.jpg")

 * const fondoPrincipal = new Fondos(position = game.at(0, 0), image = "fondoPrincipal.jpg")

 * const fondoPerdio = new Fondos(position = game.at(0, 0), image = "gameOver.jpg")

 * const fondoDeGano = new Fondos(position = game.at(0, 0), image = "fondoganhou.jpg")

 const fondoComplejidad = new Fondos(position = game.at(0, 0), image = "fondoComplejidad.jpg")*/
/*object nivelEasy {

 * 	var property position = game.at(6, 7)
 * 	var property image = "easy.png"
 * 	var property metaScore = 1000

 * }

 * object nivelMedium {

 * 	var property position = game.at(6, 5)
 * 	var property image = "medium.png"
 * 	var property metaScore = 2000

 * }

 * object nivelHard {

 * 	var property position = game.at(6, 3)
 * 	var property image = "hard.png"
 * 	var property metaScore = 3000

 }*/

