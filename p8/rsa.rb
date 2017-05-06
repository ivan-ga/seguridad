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
def euclides_extendido(num, mod)

  z = nil
  anterior = 1
  ante_anterior = 0

  dividendo = mod
  divisor = num

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


class Rsa

  #Setters y getters
  attr_accessor :mensaje_original
  attr_accessor :mensaje_codificado
  attr_accessor :mensaje_cifrado
  attr_accessor :pe
  attr_accessor :q
  attr_accessor :fi

  #Constructor
  def initialize(mensaje)
    @mensaje_original = mensaje
    @mensaje_codificado = nil
    @mensaje_cifrado = nil
    @pe = nil
    @q = nil
    @fi = nil
    @d = nil
  end

  #Método para calcular j-1, tamaño de bloques de texto
  def calcular_j(n)
    j = 0
    resultado = 0

    while resultado<n
      resultado = TAM_ALFABETO ** j
      if resultado<n
        j = j + 1
      end
    end

    j-1
  end

  #Método para la codificación del texto
  def codificar(n)

    j = calcular_j(n)

    texto = @mensaje_original
    texto = texto.delete!(' ') #elimino espacios
    texto_bloques = texto.chars.each_slice(j).map(&:join) #array con el mensaje dividido en bloques de tamaño j-1
    i = j - 1
    resultado_parcial = 0
    resultado = []

    texto_bloques.each do |c|
      i = j - 1
      resultado_parcial = 0

      c.split("").each do |k|
        resultado_parcial = resultado_parcial + (ALFABETO[k]*(TAM_ALFABETO**i))
        i = i-1
      end

      resultado << resultado_parcial
    end

    @mensaje_codificado = resultado

  end

  #Método para calcular fi de n
  def calcular_fi(p, q)
    @fi = (@pe-1)*(@q-1)
  end

  #Método para cifrar el mensaje
  def cifrar(n, mensaje_en_bloques, e)
    resultado = []
    mensaje_en_bloques.each do |val|
      resultado << exponenciacion(val, e, n)
    end

    @mensaje_cifrado = resultado
  end

  #Método para descifrar el mensaje
  def descifrar(n, mensaje_en_bloques, e)
    resultado = []
    mensaje_en_bloques.each do |val|
      resultado << exponenciacion(val, e, n)
    end

    @mensaje_cifrado = resultado #es el mensaje original
  end


end


################################################################################

puts ""
print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario

#se le da el formato adecuado al mensaje introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
#m1.delete!(' ') #elimino los espacios
m1 = m1.upcase #se pasa el mensaje a mayúsculas

puts ""
print "Inserte valor de p: "
pe = gets.to_i
puts " "

#si el valor no es primo, se vuelve a pedir
if test_primalidad(pe) == false
  while !test_primalidad(pe)
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

#Cálculo de la N
n = pe * q

#si el valor no es primo, se vuelve a pedir
if test_primalidad(q) == false
  while !test_primalidad(q)
    puts ""
    puts "El valor insertado no es primo, insertalo de nuevo."
    print "Inserte valor de p: "
    q = gets.to_i
    puts " "
  end
end

print "Inserte valor de d: "
d = gets.to_i
puts " "

#si el valor es menor que cero o no es primo con N, se vuelve a pedir
if d<0 || euclides(d, n) == false
  while d<0 || euclides(d, n) == false
    puts ""
    puts "El valor insertado no es correcto, insertalo de nuevo."
    print "Inserte valor de d: "
    d = gets.to_i
    puts " "
  end
end

# print "Inserte valor de Φ: "
# fi = gets.to_i
# puts " "

a = Rsa.new(m1)

#Asignación de valores
a.pe = pe
a.q = q

#Codificación del mensaje
a.codificar(n)

#Cálculo de fi
a.calcular_fi(pe, q)
puts a.fi

#Cálculo de la e
e = euclides_extendido(d, a.fi)
if e < 0
  e = (e + a.fi)
end


puts "MENU"
puts "==========="
puts ""
puts "Elige una opción:
1: Cifrar
2: Descifrar"

case gets.strip
  when "1"
    puts ""

    a.cifrar(n, a.mensaje_codificado, e)

    puts "Mensaje original: #{a.mensaje_original}"

    puts "N: #{n}"
    puts "Φ: #{a.fi}"
    puts "e: #{e}"

    puts "Mensaje cifrado: #{a.mensaje_cifrado. join(" ")}"
  when "2"
    puts ""
    a.descifrar(n, a.mensaje_codificado, e)

    puts "Mensaje cifrado: #{a.mensaje_original}"

    puts "N: #{n}"
    puts "Φ: #{a.fi}"
    puts "e: #{e}"

    puts "Mensaje descifrado: #{a.mensaje_cifrado. join(" ")}"
end
