#Práctica 2: Cifrado de Vigenere
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

####################################################################################################

#hash para asignar a cada letra del alfabeto un valor
ALFABETO_VIGENERE = {"A"=>0,"B"=> 1,"C"=> 2,"D"=> 3,"E"=> 4,"F"=> 5,"G"=> 6,"H"=> 7,
"I"=> 8,"J"=> 9, "K"=>10, "L"=>11, "M"=>12, "N"=>13, "O"=>14, "P"=>15, "Q"=>16,
"R"=>17, "S"=>18, "T"=>19, "U"=>20, "V"=>21, "W"=>22, "X"=>23, "Y"=>24, "Z"=>25}

TAM_ALFABETO_VIGENERE = ALFABETO_VIGENERE.size() #tamaño del alfabeto

class Vigenere
  attr_accessor :mensaje_original
  attr_accessor :mensaje_original_binario
  attr_accessor :mensaje_cifrado_binario
  attr_accessor :mensaje_cifrado

  #constructor
  def initialize(mensaje)
    @mensaje_original = mensaje
    @mensaje_cifrado = nil
  end

  #método para el cifrado del mensaje
  def cifrar(clave)
    tam_clave = clave.length() #variable que almacena el tamaño de la clave

    mensaje_bloques = mensaje_original.chars.each_slice(tam_clave).map(&:join) #array con el mensaje dividido en bloques del mismo tamaño que la clave

    resultado = [] #array para almacenar las letras resultantes

    mensaje_bloques.each_with_index do |val, i|
      j = 0
      clave.split('').each do |c| #cada letra de la clave

        num = ALFABETO_VIGENERE[val[j]].to_i + ALFABETO_VIGENERE[c].to_i #la suma de los valores de cada letra dentro del alfabeto

        if num < 26
          resultado << ALFABETO_VIGENERE.key(num)
        else
          resultado << ALFABETO_VIGENERE.key(num % TAM_ALFABETO_VIGENERE)
        end

        j = j+1
        break if (j>=val.length()) #rompe el bucle si la clave es mayor que el bloque del mensaje

      end
    end

    @mensaje_cifrado = resultado.join('')
  end

  #método para el descifrado del mensaje
  def descifrar(clave)
    tam_clave = clave.length() #variable que almacena el tamaño de la clave

    mensaje_bloques = mensaje_original.chars.each_slice(tam_clave).map(&:join) #array con el mensaje dividido en bloques del mismo tamaño que la clave

    resultado = []

    mensaje_bloques.each_with_index do |val, i|

      j = 0
      clave.split('').each do |c| #cada letra de la clave

        num = ALFABETO_VIGENERE[val[j]].to_i - ALFABETO_VIGENERE[c].to_i #la resta de los valores de cada letra dentro del alfabeto
        if num >= 0
          resultado << ALFABETO_VIGENERE.key(num)
        else
          resultado << ALFABETO_VIGENERE.key(num % TAM_ALFABETO_VIGENERE)
        end

        j = j+1

        break if (j>=val.length()) #rompe el bucle si la clave es mayor que el bloque del mensaje

      end
    end

    @mensaje_cifrado = resultado.join('') #en este caso es el mensaje descifrado lo que almacena

  end

end
