#Práctica 7: INTERCAMBIO DE CLAVES DE DIFFIE-HELLMAN
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es
################################################################################

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
