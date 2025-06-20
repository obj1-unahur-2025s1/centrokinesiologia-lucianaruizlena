/*
class Paciente {
  var property edad
  var property nivelDeFortalezaMuscular
  var property nivelDeDolor
  const aparatosAsignados = []

  method puedeUtilizar(unAparato) = unAparato.puedeUtilizarsePor(self)
  
  method usarAparato(unAparato) { if (unAparato.esMagneto()) {
    nivelDeDolor = nivelDeDolor * 0.9
  } else if (unAparato.esBicicleta()){
    nivelDeDolor = nivelDeDolor - 4
    nivelDeFortalezaMuscular = nivelDeFortalezaMuscular + 3
  } else nivelDeFortalezaMuscular = nivelDeFortalezaMuscular + (edad * 1.10)
  }
}

class Aparato {
  method puedeUtilizarsePor(unPaciente)
  method esMagneto() = false
  method esBicicleta() = false
  method esMinitramp() = false 
}

class Magneto inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = true 
  override method esMagneto() = true
}

class Bicicletea inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = unPaciente.edad() > 8
  override method esBicicleta() = true
}

class Minitramp inherits Aparato {
  override method puedeUtilizarsePor(unPaciente) = unPaciente.nivelDeDolor() < 20
  override method esMinitramp() = true
}
*/