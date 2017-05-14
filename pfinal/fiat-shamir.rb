# PRÁCTICA 7: ALGORITMO DE FIAT-SHAMIR
# Autor: Iván González Aguiar
# alu0100551266@ull.edu.es
################################################################################

require 'mathn' #Para el método prime?

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

  #Setters y getters
  attr_accessor :a
  attr_accessor :y
  attr_accessor :s
  attr_accessor :x
  attr_accessor :e
  attr_accessor :v

  #Constructor
  def initialize()
    @a = nil
    @y = nil
    @x = nil #secreto de A
    @e = nil
    @v = nil #clave pública de A
  end

  #Calcular el valor de a
  def calcular_a(n)
    @a = exponenciacion(@x, 2, n)
  end

  #Calcular el valor de y
  def calcular_y(n, s)
    if @e == 0
      @y = @x % n
    else
      @y = (@x*s) % n
    end
  end

  #Calcular el valor de v, clave pública de A
  def calcular_v(s, n)
    @v = exponenciacion(s, 2, n)
  end


end

################################################################################

class Verificador #el B del enunciado

  #Setters y getters
  attr_accessor :e
  attr_accessor :a
  attr_accessor :y

  #Constructor
  def initialize()
    @e = nil
    @a = nil
    @y = nil
  end

  #Verifica si el probador es quien dice ser
  def verificar(n, v)
    if @e == 0
      if exponenciacion(@y, 2, n) == @a
        puts "#{y}² = #{@a}(mod #{n})"
        puts "VERIFICACION CORRECTA"
      else
        puts "#{y}² != #{@a}(mod #{n})"
        puts "VERIFICACION FALLIDA"
      end
    else
      if exponenciacion(@y, 2, n) == (@a*v)%n
        puts "#{y}² = #{@a}*#{v}(mod #{n})"
        puts "VERIFICACION CORRECTA"
      else
        puts "#{y}² != #{@a}*#{v}(mod #{n})"
        puts "VERIFICACION FALLIDA"
      end
    end
  end

end



################################################################################
