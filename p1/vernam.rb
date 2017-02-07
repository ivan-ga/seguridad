#Práctica 1: cifrado de vernam
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

CLAVE = 0b001111000001100001110011 #clave para el cifrado

class Vernam
  attr_accessor :mensaje
  attr_accessor :mensaje_original_binario
  attr_accessor :mensaje_cifrado_binario
  attr_accessor :mensaje_cifrado

  #constructor
  def initialize(m)
    @mensaje = m
    @mensaje_original_binario = nil
    @mensaje_cifrado = nil
    @mensaje_cifrado_binario = nil
  end

  def cifrar
    a=['0b']

    @mensaje.each_byte do |c|
        a << '0' + c.to_s(2)
    end

    c=Integer(a.join(''))
    @mensaje_original_binario = c
    resultado = c ^ CLAVE
    @mensaje_cifrado_binario = '0' + resultado.to_s(2)

    @mensaje_cifrado = a.join('').unpack('C*')
  end



end

print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto

mensaje_a_cifrar = Vernam.new(m1)
mensaje_a_cifrar.cifrar()

puts "Mensaje original: #{m1}"

puts "Mensaje original en binario: #{mensaje_a_cifrar.mensaje_original_binario.to_s(2)}"

puts "Clave aleatoria: #{CLAVE.to_s(2)}"

puts "Mensaje cifrado en binario: #{mensaje_a_cifrar.mensaje_cifrado_binario}"

puts mensaje_a_cifrar.mensaje_cifrado
