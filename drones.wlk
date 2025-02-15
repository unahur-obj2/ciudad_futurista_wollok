class Dron {
    var autonomia = 0
    const property procesamiento = 0
    var property mision

    method eficienciaOperativa() =
        autonomia * 10 + mision.eficienciaOperativa()

    method esAvanzado() = 
        self.esAvanzadoSegunTipo() or mision.esAvanzadoSegunMision(self)

    method esAvanzadoSegunTipo()

    method disminuirAutonomia() {
        autonomia = autonomia * 0.95
    }

}

class DronComercial inherits Dron {
    override method eficienciaOperativa() = super() * 1.1
    override method esAvanzadoSegunTipo() = false
}

class DronSeguridd inherits Dron {
    override method esAvanzadoSegunTipo() = procesamiento > 50
}

class Mision {
    method eficienciaOperativa()
    method esAvanzadoSegunMision(dron)
}

object transporte inherits Mision {
    override method eficienciaOperativa() = 100
    override method esAvanzadoSegunMision(dron) = dron.autonomia() >= 50
}

object exploracion inherits Mision {
    override method  eficienciaOperativa() = 0
    override method esAvanzadoSegunMision(dron) = dron.eficienciaOperativa().even()
}

class Vigilancia inherits Mision {
    var property sensores = []
    override method  eficienciaOperativa() = 
        sensores.sum { sensor => sensor.eficienciaOperativa() }
    override method esAvanzadoSegunMision(dron) =
        sensores.all { sensor => sensor.esDuradero()}
}

class Sensor {
    const property capacidad
    const property durabilidad
    const property mejorasTecnologicas
    method  eficienciaOperativa() = if (mejorasTecnologicas) capacidad * 2 else capacidad
    method esDuradero() = durabilidad > 2 * capacidad
}

class Escuadron {
    const property drones = []

    method agregarDron(unDron) {
        if (ciudad.maximaCantidadPorEscuadron() >= drones.size())
            self.error("Supera la cantidad máxima definida por la ciudad")
        drones.add(unDron)
    }
    method puedeOperar(zona) =
        self.alMenosUnAvanzado() and self.eficienciaOperativa() * 1.5 > zona.tamano()
    method eficienciaOperativa() = drones.sum{ dron => dron.eficienciaOperativa()}
    
    method alMenosUnAvanzado() = drones.any ( { dron => dron.esAvanzado()})

    method operar(zona) {
        if (self.puedeOperar(zona)){
            zona.recibirOperacion()
            drones.forEach( {
                dron => dron.disminuirAutonomia()
            })
        }
    }
}

class Zona {
    const property tamano
    var operacionRecibidad = 0

    method recibirOperacion() {
        operacionRecibidad += 1
    }
}

object ciudad {
    var property maximaCantidadPorEscuadron= 10
}