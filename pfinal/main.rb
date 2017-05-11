#Práctica final
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

################################################################################

#Incluyendo todos los ficheros
require './vernam.rb'
require './vigenere.rb'


#Funciones

def vernam
  print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
puts ""
m = Vernam.new(m1)

puts "MENU"
puts "==========="
puts ""
puts "Elige una opción
1: Cifrar
2: Descifrar"

case gets.strip
  when "1"
    puts ""
    m.cifrar()

    puts "Mensaje original: #{m.mensaje}"

    puts "Mensaje original en binario: #{m.mensaje_original_binario.to_s(2)}"

    puts "Clave aleatoria: #{CLAVE.to_s(2)}"

    puts "Mensaje cifrado en binario: #{m.mensaje_cifrado_binario}"

    puts "Mensaje cifrado: #{m.mensaje_cifrado}"
  when "2"
    puts ""
    m.descifrar()

    puts "Mensaje cifrado: #{m.mensaje}"

    puts "Mensaje cifrado en binario: #{m.mensaje_cifrado_binario}"

    puts "Mensaje descifrado en binario: #{m.mensaje_original_binario}"

    puts "Mensaje descifrado: #{m.mensaje_cifrado}"
  end
end

def vigenere

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

end


################################################################################

puts "MENU DE PRACTICAS"
puts "==========="
puts ""
puts "Elige una opción
1: Vernam
2: Vigenere"

case gets.strip
  when "1"
    vernam()


  when "2"
    vigenere()
end
