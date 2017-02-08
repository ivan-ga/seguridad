#Práctica 1: cifrado de vernam
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

CLAVE = 0b001111000001100001110011 #clave para el cifrado

class Vernam
  attr_accessor :mensaje
  attr_accessor :mensaje_original_binario
  attr_accessor :mensaje_cifrado_binario
  attr_accessor :mensaje_cifrado

  #constructor
  def initialize(m)
    @mensaje = m
    @mensaje_original_binario = nil
    @mensaje_cifrado = nil
    @mensaje_cifrado_binario = nil
  end

  def cifrar
    a=['0b'] #tengo que añadir el 0b para que tome el número como binario

    @mensaje.each_byte do |c|
        a << '0' + c.to_s(2) #añado el 0 ya que lo simplifica por defecto
    end

    c=Integer(a.join(''))
    @mensaje_original_binario = c
    resultado = c ^ CLAVE
    @mensaje_cifrado_binario = '0' + resultado.to_s(2)

    y=[]
    z=0
    #separo por bytes (8 dígitos) el mensaje_cifrado_binario y lo almaceno en el array y
    while z<@mensaje_cifrado_binario.length() do
      arr=@mensaje_cifrado_binario[z..z+7]
      y << '0b' + arr
      z=z+8
    end

    #convierto cada byte a su equivalente en ASCII y lo almaceno en el array mc
    mc=[]
    y.each do |x|
      mc << Integer(x).chr
    end

    @mensaje_cifrado = mc.join('')
  end

  def descifrar
    a=['0b'] #tengo que añadir el 0b para que tome el número como binario

    @mensaje.each_byte do |c|
      if c.between?(64, 127) then
        a << '0' + c.to_s(2) #añado el 0 ya que lo simplifica por defecto
      elsif c.between?(0, 63) then
        a << '00' + c.to_s(2) #añado el 00 ya que lo simplifica por defecto
      else
        a << c.to_s(2)
      end
    end

    resultado=Integer(a.join(''))
    @mensaje_cifrado_binario = resultado

    c = resultado ^ CLAVE
    @mensaje_original_binario = '0' + c.to_s(2)

    y=[]
    z=0
    #separo por bytes (8 dígitos) el mensaje_cifrado_binario y lo almaceno en el array y
    while z<@mensaje_original_binario.length() do
      arr=@mensaje_original_binario[z..z+7]
      y << '0b' + arr
      z=z+8
    end

    #convierto cada byte a su equivalente en ASCII y lo almaceno en el array mc
    mc=[]
    y.each do |x|
      mc << Integer(x).chr
    end

    @mensaje_cifrado = mc.join('') #la variable se llama mensaje_cifrado pero corresponde con el mensaje original.
  end



end

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
