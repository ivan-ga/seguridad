#Práctica 2: Cifrado de Vigenere
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

####################################################################################################

class Vigenere
  attr_accessor :mensaje_original
  attr_accessor :mensaje_original_binario
  attr_accessor :mensaje_cifrado_binario
  attr_accessor :mensaje_cifrado

  #constructor
  def initialize(mensaje)
    @mensaje_original = mensaje
    @mensaje_original_binario = nil
    @mensaje_cifrado = nil
    @mensaje_cifrado_binario = nil
  end

  #método para dar el formato correcto al mensaje introducido por el usuario
  def formatear
    @mensaje_original.delete!("\n") #elimino el salto de línea que se incluye por defecto
    @mensaje_original.delete!(' ') #elimino los espacios
  end

  #método para el cifrado del mensaje
  def cifrar(clave)
    tam_clave = clave.length() #variable que almacena el tamaño de la clave



  end
end

print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
m1.delete!(' ') #elimino los espacios
m1.scan(/.../) #divido el texto en bloques
puts " "

print "Inserte clave: "
c1 = gets #almacena en la variable c1 la clave introducida por el usuario
c1.delete!("\n") #elimino el salto de línea que se incluye por defecto
c1.delete!(' ') #elimino los espacios
puts " "
