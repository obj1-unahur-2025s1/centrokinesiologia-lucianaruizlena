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
  var property decremento = 3
  override method realizarRutina(){
    super()
    nivelDeDolor = nivelDeDolor - decremento
  }

}

object blanco{}
object rojo {}
object verde {}

class Aparato {
  var property color = blanco
  method puedeUtilizarsePor(unPaciente)
  method usa(unPaciente)
}

class Magneto inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = true 
  override method usa(unPaciente){
    unPaciente.bajarNivelDeDolorPor(0.9)
  }
}

class Bicicleta inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = unPaciente.edad() > 8
  override method usa(unPaciente){
    unPaciente.bajarNivelDeDolorEn(4)
    unPaciente.aumentarNivelDeFortalezaMuscular(3)
  }
}

class Minitramp inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = unPaciente.nivelDeDolor() < 20
  override method usa(unPaciente){
    var incremento = unPaciente.edad() * 0.10
    unPaciente.aumentarNivelDeFortalezaMuscular(incremento)
  }
}

object centroDeKinesiologia {
  const aparatos = #{}
  const pacientes = #{}

  method colorDe(unAparato) = unAparato.color() //para un solo aparato.
  method colorDeTodosLosAparatos() = aparatos.map({a => a.color()}) //para todos los aparatos.

  method pacientesMenoresDeOcho() = pacientes.filter({p => p.edad() < 8})
  method cantidadDePacientesSinCumplirSesion() = pacientes.filter({p => not p.puedeHacerRutina()})
}