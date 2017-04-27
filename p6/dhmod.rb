#Práctica 7: INTERCAMBIO DE CLAVES DE DIFFIE-HELLMAN
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es
################################################################################

#Algoritmo de exponenciación rápida
def exponenciacion(base, b, modulo) #b es el exponente
      x = 1 #Inicialización de la x a 1
      y = base%modulo #la y es igual a la base

      while (b>0) and (y>1) do
          if ((b%2)!=0) #si b es impar
              x = (x*y)%modulo
              b = b-1
          else #si b es par
              y = (y*y)%modulo
              b = b/2
          end
      end

      x
end

class Dh

  #Setters y getters
  attr_accessor :secreto
  attr_accessor :y
  attr_accessor :alfa
  attr_accessor :np
  attr_accessor :k

  #Constructor
  def initialize(secreto, alfa, np)
    @secreto =  secreto #la variable X del enunciado
    @y = nil
    @alfa = alfa
    @np = np #número primo
    @k = nil
  end


  #Método para calcular la variable Y
  def calcular_y
    @y = exponenciacion(@alfa, @secreto, @np)
    #@y = (@alfa ** @secreto) % @np
  end

  #Método para calcular la variable K (clave)
  def calcular_clave(y) #esta y es la y del otro participante en la comunicación
    @k = exponenciacion(y, @secreto, @np)
    #@k = (y ** @secreto) % @np
  end


end

################################################################################

puts ""
print "Inserte número de participantes: "
participantes = gets.to_i
puts " "

puts ""
print "Inserte número primo: "
num = gets.to_i
puts " "

print "Inserte alfa: "
alfa = gets.to_i
puts " "

participantes.times do |i|
  print "Inserte secreto de #{i+1}: "
  x = gets.to_i
  puts " "
  a = Dh.new(x, alfa, num)
  instance_variable_set("@p#{i+1}", a)

end


puts "CALCULO DE LA Y"
participantes.times do |i|
  instance_variable_get("@p#{i+1}").calcular_y
end

participantes.times do |i|
  y = instance_variable_get("@p#{i+1}").y
  puts "y"+"#{i+1}: #{y}"
end
puts " "

puts "CALCULO DE LA Z" #clave intermedia

participantes.times do |i|
  if i+1 < participantes #si no ha llegado al último
    z = instance_variable_get("@p#{i+1}").calcular_clave(instance_variable_get("@p#{i+2}").y)
    instance_variable_set("@z#{i+1}", z)
    puts "Z"+"#{i+1}: #{z}"
  else #si ha llegado al último que intercambie claves con el primero
    z = instance_variable_get("@p#{i+1}").calcular_clave(@p1.y)
    instance_variable_set("@z#{i+1}", z)
    puts "Z"+"#{i+1}: #{z}"
  end

end


puts " "
puts "CALCULO DE LA K"

cuenta = participantes #variable para controlar que no se me salga del número de participantes (también podía haber usado módulo)
participantes.times do |i|

  if cuenta > 0
    k = instance_variable_get("@z#{i+1}") #clave intermedia, Z
    exp = instance_variable_get("@p#{cuenta}").secreto
    m = instance_variable_get("@p#{cuenta}").np
    resultado = exponenciacion(k, exp, m)
    puts "K"+"#{i+1}: #{resultado}"
    instance_variable_set("@z#{i+1}", resultado)
  end

  cuenta = cuenta+1
  if cuenta > participantes
    cuenta = 1
  end
end
puts " "
