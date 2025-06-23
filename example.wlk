class Paciente {
  var property edad
  var property nivelDeFortalezaMuscular
  var property nivelDeDolor
  const property aparatosAsignados = #{}
  const property rutina = []

  method puedeHacerRutina() = rutina.all({a => self.tieneAparato(a) && self.puedeUtilizar(a)}) 

  method tieneAparato(unAparato) = aparatosAsignados.any({a => a == unAparato})

  method realizarRutina() {
    if(self.puedeHacerRutina()){
      rutina.forEach({a => self.usarAparato(a)})
    }
  }
  /*----------------------------------------*/

  method puedeUtilizar(unAparato) = unAparato.puedeUtilizarsePor(self)
  
  method usarAparato(unAparato) {
    if (self.puedeUtilizar(unAparato)){
      unAparato.usa(self)
    }
  }
  /*----------------------------------------*/

  method bajarNivelDeDolorPor(unPorcentaje) {
    nivelDeDolor = nivelDeDolor * unPorcentaje
  }

  method bajarNivelDeDolorEn(unNumero) {
    nivelDeDolor = nivelDeDolor - unNumero
  }

  method aumentarNivelDeFortalezaMuscular(unNumero) {
    nivelDeFortalezaMuscular = nivelDeFortalezaMuscular + unNumero
  }
}

class Resistente inherits Paciente {
  override method realizarRutina() {
    super()
    nivelDeFortalezaMuscular = nivelDeFortalezaMuscular + rutina.size()    
  }
}

class Caprichoso inherits Paciente {
  override method puedeHacerRutina() = super() && aparatosAsignados.any({a => a.color() == rojo})
  override method realizarRutina() {
    if(self.puedeHacerRutina()){
      rutina.forEach({a => self.usarAparato(a)})
      rutina.forEach({a => self.usarAparato(a)})
    }
  }
}

class RapidaRecuperacion inherits Paciente {
  override method realizarRutina(){
    super()
    nivelDeDolor = nivelDeDolor - decrementoDeRapidaRecuperacion.valor()
  }
}

object decrementoDeRapidaRecuperacion {
  const property valor = 3
}

object blanco{}
object rojo {}
object verde {}

class Aparato {
  var property color = blanco
  method puedeUtilizarsePor(unPaciente)
  method usa(unPaciente)

  method necesitaMantenimiento()
  method hacerMantenimiento(){}
}

class Magneto inherits Aparato {
  var puntosDeImantacion = 800

  override method puedeUtilizarsePor(unPaciente) = true 
  override method usa(unPaciente){
    unPaciente.bajarNivelDeDolorPor(0.9)
    puntosDeImantacion = puntosDeImantacion - 1
  }

  override method necesitaMantenimiento() = puntosDeImantacion < 100

  override method hacerMantenimiento() {
    puntosDeImantacion = puntosDeImantacion + 500
  }
}

class Bicicleta inherits Aparato {
  var vecesDeTornillosDesajustados = 0
  var vecesPierdeAceite = 0
  
  override method puedeUtilizarsePor(unPaciente) = unPaciente.edad() > 8
  override method usa(unPaciente){
    if(unPaciente.nivelDeDolor() > 30){
      vecesDeTornillosDesajustados = vecesDeTornillosDesajustados + 1 
    } else (unPaciente.nivelDeDolor() > 30 && unPaciente.edad().between(30, 50)){
      vecesDeTornillosDesajustados = vecesDeTornillosDesajustados + 1 
      vecesPierdeAceite = vecesPierdeAceite + 1
    }
    unPaciente.bajarNivelDeDolorEn(4)
    unPaciente.aumentarNivelDeFortalezaMuscular(3)
  }

  override method necesitaMantenimiento() = vecesDeTornillosDesajustados >= 10 || vecesPierdeAceite >= 5

  override method hacerMantenimiento() {
    vecesDeTornillosDesajustados = 0
    vecesPierdeAceite = 0
  }
}

class Minitramp inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = unPaciente.nivelDeDolor() < 20
  override method usa(unPaciente){
    var incremento = unPaciente.edad() * 0.10
    unPaciente.aumentarNivelDeFortalezaMuscular(incremento)
  }

  override method necesitaMantenimiento() = false
}

object centroDeKinesiologia {
  const aparatos = #{}
  const pacientes = #{}
  var visitasDelTecnico = 0

  method agregar(unAparato) {
    aparatos.add(unAparato)
  }
  method agregarPaciente(unPaciente) {
    pacientes.add(unPaciente)
  }

  method colorDe(unAparato) = unAparato.color() //para un solo aparato.
  method colorDeTodosLosAparatos() = aparatos.map({a => a.color()}) //para todos los aparatos.

  method pacientesMenoresDeOcho() = pacientes.filter({p => p.edad() < 8})
  method cantidadDePacientesSinCumplirSesion() = pacientes.filter({p => not p.puedeHacerRutina()})

  method aparatosEstanEnOptimasCondiciones() = aparatos.all({a => not a.necesitaMantenimiento()})
  method estaComplicado() = aparatos.count({a => a.necesitaMantenimiento()}) >= aparatos.size() / 2

  method visitaDelTecnico(){
    if (aparatos.necesitaMantenimiento()){
      aparatos.forEach({a => a.hacerMantenimiento()})
    }
  }
}