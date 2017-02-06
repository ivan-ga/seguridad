#Práctica 1: cifrado de vernam
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

CLAVE = 0b001111000001100001110011 #clave para el cifrado

class Vernam
  attr_accessor :mensaje

  def initialize(m)
    @mensaje = m
  end

  def pasar_a_ascii
    a = []
    @mensaje.each_byte do |num|
      a << num
    end
    a
  end

end

print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto

mensaje_a_cifrar = Vernam.new(m1)

puts mensaje_a_cifrar.pasar_a_ascii()
