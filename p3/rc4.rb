#Práctica 3: Cifrado RC4
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

################################################################################

SEMILLA = [2, 5] #semilla de clave
TAM_SEMILLA = SEMILLA.size() #tamaño del array SEMILLA

#Abriendo la clase array para implementar un método swap para intercambiar valores en el array
class Array

  def swap!(a, b)
    self[a], self[b] = self[b], self[a]
    self
  end

end

class Rc4

  attr_accessor :mensaje_original
  attr_accessor :mensaje_cifrado

  def initialize
    @mensaje_original = []
    @mensaje_cifrado = []
  end

  def cifrar
    s = []
    k = []

    #Inicialización(KSA)
    256.times do |i|
      s[i] = i
      k[i] = SEMILLA[i % TAM_SEMILLA]
    end
    #print s
    f = 0
    256.times do |i|
      f = (f + s[i] + k[i]) % 256
      s.swap!(i, f)
    end

    #Generación de secuencia cifrante(PRGA)
    i = 0
    f = 0
    mensaje_original.each do |val|

      i = (i + 1) % 256
      f = (f + s[i]) % 256
      s.swap!(i, f)
      t = (s[i] + s[f]) % 256

      mensaje_cifrado << (s[t].to_i ^ val.to_i)

    end
  end

end

################################################################################

r = Rc4.new()

print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario

#se le da el formato adecuado al mensaje introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
r.mensaje_original = m1.split(" ")
puts " "
puts "MENU"
puts "==========="
puts ""
puts "Elige una opción:
1: Cifrar
2: Descifrar"

case gets.strip
  when "1"
    puts ""
    r.cifrar()
    puts "Mensaje original: #{r.mensaje_original.join(" ")}"
    puts "Mensaje cifrado: #{r.mensaje_cifrado.join(" ")}"
  when "2"
    puts ""
    r.cifrar()
    puts "Mensaje cifrado: #{r.mensaje_original.join(" ")}"
    puts "Mensaje original: #{r.mensaje_cifrado.join(" ")}"
end
