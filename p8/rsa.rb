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

#Comprueba si un número es divisible por los primos pequeños
def divisible(num)

    es_divisible = nil

    (PRIMOS.size()).times do |i|

      if(num % PRIMOS[i]) == 0
        es_divisible = true
      else
        es_divisible = false
        break
      end

    end

    es_divisible
end

#Test de primalidad
def test_primalidad(num)
  retorna = nil

  if divisible(num)
    retorna = false

  else
    vector_enteros = []

    if num > 100

      entero = rand(1..num-1)
      vector_enteros << entero
      99.times do |i|
        while vector_enteros.include? entero #para que no repita números
          entero = rand(1..num-1)
        end
        vector_enteros << entero
      end

    else

      entero = rand(1..num-1)
      vector_enteros << entero
      (num/2).times do |i|
        while vector_enteros.include? entero #para que no repita números
          entero = rand(1..num-1)
        end
        vector_enteros << entero
      end

    end

    exponente = (num-1) / 2
    resultado = []

    vector_enteros.each_with_index do |val, i|
      resultado[i] = exponenciacion(val, exponente, num)

      if (resultado[i] != 1) && (resultado[i] != (num-1))
        retorna = false
        break
      end
    end

    if retorna == nil
      if resultado.todo_unos?
        retorna = false
      else
        retorna = true
      end
    end


    retorna
  end
end
