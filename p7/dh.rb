#Práctica 7: INTERCAMBIO DE CLAVES DE DIFFIE-HELLMAN
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es
################################################################################

class Dh

  attr_accessor :secreto
  attr_accessor :y
  attr_accessor :alfa
  attr_accessor :np
  attr_accessor :k

  def initialize(secreto, alfa, np)
    @secreto =  secreto #la variable X del enunciado
    @y = nil
    @alfa = alfa
    @np = np #número primo
    @k = nil
  end

  def calcular_y
    @y = (@alfa ** @secreto) % @np
  end

  def calcular_clave(y) #esta y es la y del otro participante en la comunicación
    @k = (y ** @secreto) % @np
  end


end

################################################################################

puts ""
print "Inserte número primo: "
num = gets.to_i #almacena en la variable m1 el texto introducido por el usuario
puts " "

print "Inserte alfa: "
alfa = gets.to_i #almacena en la variable c1 la clave introducida por el usuario
puts " "

print "Inserte secreto de A: "
xa = gets.to_i #almacena en la variable c1 la clave introducida por el usuario
puts " "

print "Inserte secreto de B: "
xb = gets.to_i #almacena en la variable c1 la clave introducida por el usuario
puts " "

a = Dh.new(xa, alfa, num)
b = Dh.new(xb, alfa, num)

puts "CALCULO DE LA Y"
a.calcular_y()
b.calcular_y()

puts "yA: #{a.y}"
puts "yB: #{b.y}"
puts " "

puts "CALCULO DE LA K"
a.calcular_clave(b.y)
b.calcular_clave(a.y)

puts "k (generada en A): #{a.k}"
puts "k (generada en B): #{b.k}"
puts ""
