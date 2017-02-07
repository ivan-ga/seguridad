#Práctica 1: cifrado de vernam
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

CLAVE = "001111000001100001110011" #clave para el cifrado

class Vernam
  attr_accessor :mensaje

  #constructor
  def initialize(m)
    @mensaje = m.unpack("B*") #convierte el mensaje m a binario con el método unpack
    @mensaje_cifrado = nil
  end

  def cifrar
    @mensaje_cifrado = "0b + #{@mensaje[0]}" ^ CLAVE.to_i
  end



end
puts CLAVE
print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto

mensaje_a_cifrar = Vernam.new(m1)
#puts mensaje_a_cifrar.mensaje[0].to_i(2)
#mensaje_a_cifrar.cifrar()
puts mensaje_a_cifrar.cifrar()
