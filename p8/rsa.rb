# PRÁCTICA 8: CIFRADO RSA
# Autor: Iván González Aguiar
# alu0100551266@ull.edu.es
################################################################################

#Abro la clase Array e incluyo un método que comprueba si todos los elementos de un array
#son iguales a uno
class Array

  def todo_unos?
    if self.max == 1 && self.min == 1
      return true
    else
      return false
    end
  end

end


#Array que almacena los primos pequeños
PRIMOS = [2, 3, 5, 7, 11]

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

#Comprueba si un número es divisible por otro
def divisible(num)

    PRIMOS.size().times do |i|

      if(num % PRIMOS[i]) == 0
        divisible = true
      else
        divisible = false
        break
      end

    end

    divisible
end

#Test de primalidad
def test_primalidad(num)

  if divisible(num)
    return false

  else

    vector_enteros = []

    if num > 100

      100.times do |i|
        vector_enteros << rand(1..num-1)
      end

    else

      (num/2).times do |i|
        vector_enteros << rand(1..num-1)
      end

    end

    exponente = (num-1) / 2
    resultado = []

    vector_enteros.each_with_index do |val, i|
      resultado[i] = exponenciacion(val, exponente, num)

      if resultado[i] != 1 || resultado[i] != -1
        retorna = false
        break
      end
    end

    if resultado.todo_unos?
      retorna = false
    else
      retorna = true
    end


    retorna
end
