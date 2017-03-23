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

    puts s.to_s
    #puts s[209]
    #Generación de secuencia cifrante(PRGA)
    # while GeneratingOutput:
    # i := i + w
    # j := k + S[j + S[i]]
    # k := k + i + S[j]
    # swap values of S[i] and S[j]
    # output z := S[j + S[i + S[z + k]]]
    # endwhile


    i = 0
    f = 0 #esta es la j en el algoritmo
    w = 5
    k = 0
    a3 = 0 #esta es la z en el algoritmo
    mensaje_original.each do |val|

      i = (i + w) % 256
      puts "i: #{i}"
      f = (k + s[(f + (s[i%256].to_i))%256].to_i)
      puts "f: #{f}"
      k = i + k + (s[f%256].to_i)
      puts "k: #{k}"
      s.swap!(i, f)
      #t = (s[i] + s[f]) % 256

      #Valor de z: (está hecho por partes)
      a1 = (s[(a3 + k)%256].to_i)
      a2 = (s[(i + a1)% 256].to_i)
      a3 = (s[(f + a2)%256].to_i) #este es el valor final de z

      mensaje_cifrado << a3

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
