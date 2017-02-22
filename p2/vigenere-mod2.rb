#Práctica 2: Cifrado de Vigenere
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es
#MODIFICACIÓN 2: añadir 4 elementos al alfabeto y revertir orden del alfabeto
####################################################################################################

#hash para asignar a cada letra del alfabeto un valor
# ALFABETO = {"A"=>29,"B"=> 28,"C"=> 27,"D"=> 26,"E"=> 25,"F"=> 24,"G"=> 23,"H"=> 22,
# "I"=> 21,"J"=> 20, "K"=>19, "L"=>18, "M"=>17, "N"=>16, "O"=>15, "P"=>14, "Q"=>13,
# "R"=>12, "S"=>11, "T"=>10, "U"=>9, "V"=>8, "W"=>7, "X"=>6, "Y"=>5, "Z"=>4}

ALFABETO = {"¿"=>0,"?"=> 1,"_"=> 2,"*"=> 3,"Z"=> 4,"Y"=> 5,"X"=> 6,"W"=> 7,
"V"=> 8,"U"=> 9, "T"=>10, "S"=>11, "R"=>12, "Q"=>13, "P"=>14, "O"=>15, "N"=>16,
"M"=>17, "L"=>18, "K"=>19, "J"=>20, "I"=>21, "H"=>22, "G"=>23, "F"=>24, "E"=>25, "D"=>26, "C"=>27, "B"=>28, "A"=>29}

#ALFABETO_REV = Hash[ALFABETO.to_a.reverse]

#ALFABETO_REV << {"¿"=>26, "?"=>27, "_"=>28, "*"=>29}
ALFABETO["¿"]=0
ALFABETO["?"]=1
ALFABETO["_"]=2
ALFABETO["*"]=3

TAM_ALFABETO = ALFABETO.size() #tamaño del alfabeto
#puts ALFABETO
#puts ALFABETO_REV.size()


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
        #puts ALFABETO[val[j]].to_i + ALFABETO[c].to_i
        num = ALFABETO[val[j]].to_i + ALFABETO[c].to_i #la suma de los valores de cada letra dentro del alfabeto

        if num < TAM_ALFABETO
          resultado << ALFABETO.key(num)
        else
          resultado << ALFABETO.key((num % TAM_ALFABETO))
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

        num = ALFABETO[val[j]].to_i - ALFABETO[c].to_i #la resta de los valores de cada letra dentro del alfabeto
        if num >= 0
          resultado << ALFABETO.key(num)
        else
          resultado << ALFABETO.key((num % TAM_ALFABETO))
        end

        j = j+1

        break if (j>=val.length()) #rompe el bucle si la clave es mayor que el bloque del mensaje

      end
    end

    @mensaje_cifrado = resultado.join('') #en este caso es el mensaje descifrado lo que almacena

  end

end

print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario

#se le da el formato adecuado al mensaje introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
m1.delete!(' ') #elimino los espacios
m1 = m1.upcase #se pasa el mensaje a mayúsculas
#m1.scan(/.../) #divido el texto en bloques
puts " "

print "Inserte clave: "
c1 = gets #almacena en la variable c1 la clave introducida por el usuario

#se le da el formato adecuado a la clave introducida por el usuario
c1.delete!("\n") #elimino el salto de línea que se incluye por defecto
c1.delete!(' ') #elimino los espacios
c1 = c1.upcase #se pasa la clave a mayúsculas
puts " "

m = Vigenere.new(m1)

puts "MENU"
puts "==========="
puts ""
puts "Elige una opción:
1: Cifrar
2: Descifrar"

case gets.strip
  when "1"
    puts ""
    m.cifrar(c1)

    puts "Mensaje original: #{m.mensaje_original}"

    puts "Mensaje cifrado: #{m.mensaje_cifrado}"
  when "2"
    puts ""
    m.descifrar(c1)

    puts "Mensaje original: #{m.mensaje_original}"

    puts "Mensaje descifrado: #{m.mensaje_cifrado}"
end
