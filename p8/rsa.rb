# PRÁCTICA 8: CIFRADO RSA
# Autor: Iván González Aguiar
# alu0100551266@ull.edu.es
################################################################################

#hash para asignar a cada letra del alfabeto un valor
ALFABETO = {"A"=>0,"B"=> 1,"C"=> 2,"D"=> 3,"E"=> 4,"F"=> 5,"G"=> 6,"H"=> 7,
"I"=> 8,"J"=> 9, "K"=>10, "L"=>11, "M"=>12, "N"=>13, "O"=>14, "P"=>15, "Q"=>16,
"R"=>17, "S"=>18, "T"=>19, "U"=>20, "V"=>21, "W"=>22, "X"=>23, "Y"=>24, "Z"=>25}

TAM_ALFABETO = ALFABETO.size() #tamaño del alfabeto


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

#Algoritmo de Euclides extendido, para calcular el inverso de un número modulo con otro
def euclides_extendido(a, b)

  z = nil
  anterior = 1
  ante_anterior = 0

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

    if resto == 0 #para que no vuelva a calcular la z
      break
    end

    z = ((-1*cociente) * anterior) + ante_anterior
    ante_anterior = anterior
    anterior = z
    dividendo = divisor
    divisor = resto
  end

  z

end

#Método para calcular j-1, tamaño de bloques de texto
def calcular_j(n)
  j = 0
  resultado = 0

  while resultado<n
    resultado = n ** j
    j = j + 1
  end

  j
end

#Método para la codificación del texto
def codificar(texto, n)
  j = nil #el j-1 del enunciado


end
