import wollok.game.*
import objetoParaLasCanasta.*

object hijitus {

	const nombre = "Hijitus"
	var property hijitusVida = 3
	//var pontos = 0
	var property position = new Position(x = 0, y = 0)

	method image() = "pepita1.png"

	method teQuedasteSinVida() = hijitusVida <= -1

	//method alcanzasteLaMeta() = pontos >= 1000

	method caminarA(nuevaPosicion) {
		if (!self.teQuedasteSinVida()) {
			position = nuevaPosicion
			self.corregirPosition()
		}
	}

	method corregirPosition() {
		position = new Position(x = (position.x().max(0)).min(17), y = 0)
	}

	method restarVida(cantidadDeVidas) {
		hijitusVida = hijitusVida - cantidadDeVidas
	}

	method sumarVida(cantidadDeVidas) {
		hijitusVida = (hijitusVida + cantidadDeVidas).min(3)
	}

	//method sumarPuntos(cantidadDePuntosASumar) {
		//pontos = pontos + cantidadDePuntosASumar
	//}

}

