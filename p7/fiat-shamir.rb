# PRÁCTICA 7: ALGORITMO DE FIAT-SHAMIR
# Autor: Iván González Aguiar
# alu0100551266@ull.edu.es
################################################################################

#Algoritmo de Euclides para comprobar si dos números son primos entre sí
def euclides(a, b)
  if(a < b)
    dividendo = b
    divisor = a
  else
    dividendo = a
    divisor = b
  end

  resto = 1

  while(resto > 0)
    cociente = dividendo / divisor
    resto = dividendo % divisor
    dividendo = divisor
    divisor = resto
  end

  if(dividendo != 1)
    return false
  else
    return true
  end

end

#Algoritmo de exponenciación rápida
def exponenciacion(base,b,modulo) #b es el exponente
      x = 1 #Inicialización de la x a 1
      y = base % modulo #la y es igual a la base

      while (b > 0) and (y>1) do
          if ((b % 2)!=0) #si b es impar
              x = (x*y) % modulo
              b = b-1
          else #si b es par
              y = (y*y) % modulo
              b = b/2
          end
      end

      x
  end

##############################################################################3#

class Probador #el A del enunciado

  def initialize(s, x)
    @a = nil
    @y = nil
    @s = s
    @x = x
  end



end

################################################################################

class Verificador #el B del enunciado


end



################################################################################


puts ""
print "Inserte valor de p: "
pe = gets.to_i
puts " "

if pe.prime? == false
  while !pe.prime
    puts ""
    puts "El valor insertado no es primo, insertalo de nuevo."
    print "Inserte valor de p: "
    pe = gets.to_i
    puts " "
  end
end

print "Inserte valor de q: "
q = gets.to_i
puts " "

print "Inserte valor de s: "
s = gets.to_i
puts " "

print "Inserte número de iteraciones: "
i = gets.to_i
puts " "

#Cálculo de la N
n = pe * q
