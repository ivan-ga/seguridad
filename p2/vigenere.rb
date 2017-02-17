#Práctica 2: Cifrado de Vigenere
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

####################################################################################################

ALFABETO = {"A"=>0,"B"=> 1,"C"=> 2,"D"=> 3,"E"=> 4,"F"=> 5,"G"=> 6,"H"=> 7,
"I"=> 8,"J"=> 9, "K"=>10, "L"=>11, "M"=>12, "N"=>13, "O"=>14, "P"=>15, "Q"=>16,
"R"=>17, "S"=>18, "T"=>19, "U"=>20, "V"=>21, "W"=>22, "X"=>23, "Y"=>24, "Z"=>25}

class Vigenere
  attr_accessor :mensaje_original
  attr_accessor :mensaje_original_binario
  attr_accessor :mensaje_cifrado_binario
  attr_accessor :mensaje_cifrado

  #constructor
  def initialize(mensaje)
    @mensaje_original = mensaje
    @mensaje_original_binario = nil
    @mensaje_cifrado = nil
    @mensaje_cifrado_binario = nil
  end

  #método para el cifrado del mensaje
  def cifrar(clave)
    tam_clave = clave.length() #variable que almacena el tamaño de la clave

    mensaje_bloques = mensaje_original.chars.each_slice(tam_clave).map(&:join) #array con el mensaje dividido en bloques del mismo tamaño que la clave

    resultado = []
    mensaje_bloques.each_with_index do |val, i|
      j = 0
      while j<val.length() do
        clave.split('').each do |c|
          if ALFABETO[ALFABETO[val[i][j]]+ALFABETO[c]] < 26
            resultado << ALFABETO[ALFABETO[val[i][j]]+ALFABETO[c]] < 26
          else
            resultado << (ALFABETO[ALFABETO[val[i][j]]+ALFABETO[c]]) % 26
          end
          j = j+1
        end
      end
    end

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

c1.split('').each { |c|
    puts c
}
# arr=m1.chars.each_slice(2).map(&:join)
#
# puts arr
# puts arr[0][0]

# h = {'A'=>1, 'B'=>7}
# s = 'A'
#
# puts h[s]
