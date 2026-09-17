 object ningunQuilombero {
  method hacerQuilombo(casa){}
  method velocidad() = 9999
 }

//CASA
object casa{
  var cuidador = tom
  var quilombero = ningunQuilombero
  var suciedad = 0

  method cuidador() = cuidador
  method cuidador(unCuidador) { cuidador = unCuidador }


  method quilombero() = quilombero
  method quilombero(unQuilombero) { quilombero = unQuilombero }

  method suciedad() = suciedad 


  method aumentarSuciedad(cantidad){
    suciedad = 0.max(suciedad+cantidad)
  }

  method dejarLimpia(){
    suciedad = 0
  }

  method pasarElDia(){
    cuidador.limpiarLaCasa(self)
    if(cuidador.puedeAtraparQuilombero(quilombero)){
      quilombero = ningunQuilombero
    }
  }

  method pasarNoche(){
    cuidador.siesta()
    quilombero.hacerQuilombo(self)
  }
}

//CUIDADORES
object tom {
  var energia = 100

  method energia() = energia
  method energia(nuevaEnergia) { energia = 0.max(nuevaEnergia) }
  method velocidad() = 5 + (energia/10)

  method limpiarLaCasa(unaCasa){
    unaCasa.aumentarSuciedad(-100)
    energia 0.max(energia - 40)
  }

  method siesta(){
    energia +=50
  }

  method interrumpirSueno(){
    energia = 0.max(energia - 20)
  }

  method puedeAtraparQuilombero(quilombero) = self.velocidad() > quilombero.velocidad()

}

object robocat {
  method limpiarLaCasa(unaCasa){
      unaCasa.dejarLimpia()
    }
  
  method puedeAtraparQuilombero(quilombero) = true

  method siesta(){}

  method interrumpirSueno(){}

  }

//NUEVO CUIDADOR
object spike{
  var paciencia = 50

  method paciencia() = paciencia

  method limpiarLaCasa(unaCasa){
    casa.aumentarSuciedad(-150)
  }

  method velocidad()= 8

  method puedeAtraparQuilombero(quilombero) = self.velocidad() > quilombero.velocidad()

  method dormir(){
    paciencia +=20
  }

  method interrumpirSueno(){
    paciencia = 0.max(paciencia - 10)
  }
}

//QUILOMBEROS
object jerry {
  var peso = 1

  method peso() = peso
  method peso(nuevoPeso) { peso = nuevoPeso }
  method velocidad() = 10 - peso

  method hacerQuilombo(casa){
    casa.aumentarSuciedad(110)
    peso+=1
  }
}

object tuffy {
  method velocidad() = 10

  method hacerQuilombo(casa){
    casa.cuidador().interrumpirSueno()
  }
}

//PANDILLA
object pandilla{
  var miembros = []

  method miembros() = miembros
  method miembros(nuevosMiembros) { miembros = nuevosMiembros }

  method velocidad() = miembros.map({ m => m.velocidad()}).min() / 2

  method hacerQuilombo(casa){
    miembros.forEach({m => m.hacerQuilombo(casa)})
    if (miembros.size() > 3){
      casa.cuidador().interrumpirSueno()
    }
  }
}

//NUEVO QUILOMBERO
object butch{
  method velocidad() = 5

  method hacerQuilombo(casa){
    casa.aumentarSuciedad(150)
    casa.cuidador().interrumpirSueno()
  }
}