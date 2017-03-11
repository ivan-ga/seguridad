#Práctica 4: Cifrado A5/1
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es
########################################################################

#Semillas

SR1 = '1001000100011010001'
SR2 = '0101100111100010011010'
SR3 = '10111100110111100001111'

#Abriendo clase Array para implementar un método para desplazar dentro de los registros
class Array

  def desplazar(registro)
    if registro == 1
      arr = Array.new(19)
    elsif registro == 2
      arr = Array.new(22)
    elsif registro == 3
      arr = Array.new(23)
    end

    self.each_with_index do |val, i|
      if i+1 < self.length()
        arr[i+1] = val
      end
    end

    arr
  end

end

# class Integer
#
# 	  def num_digitos
#
# 	      self.to_s.size
#
# 	  end
#
# end

class A5

  attr_accessor :mensaje_original
  attr_accessor :mensaje_original_binario
  attr_accessor :mensaje_cifrado_binario
  attr_accessor :mensaje_cifrado

  #Constructor
  def initialize(m)

    @mensaje_original = m
    @mensaje_original_binario = nil
    @mensaje_cifrado = nil
    @mensaje_cifrado_binario = nil

  end

  #Método para el cálculo de la mayoría
  def calcular_mayoria(r1, r2, r3)

    mayoria = Array.new(3)
    mayoria[0] = r1[8] #es el 8 en vez de 9 porque empiezo en 0
    mayoria[1] = r2[10] #es el 10 en vez de 11 porque empiezo en 0
    mayoria[2] = r3[10] #es el 10 en vez de 11 porque empiezo en 0

    cuenta_ceros = mayoria.count(0) #cuenta el numero de 0
    cuenta_unos = mayoria.count(1) #cuenta el numero de unos

    if cuenta_ceros > cuenta_unos
      puts "Mayoria: 0"
      return false
    else
      puts "Mayoria: 1"
      return true
    end

  end

  def cifrar

    #Convirtiendo mensaje a binario
    m_bin = ['0b'] #tengo que añadir el 0b para que tome el número como binario

    @mensaje_original.each_byte do |c|

        if c.between?(64, 127) then
          m_bin << '0' + c.to_s(2) #añado el 0 ya que lo simplifica por defecto
        elsif c.between?(0, 63) then
          m_bin << '00' + c.to_s(2) #añado el 00 ya que lo simplifica por defecto
        else
          m_bin << c.to_s(2)
        end

    end

    @mensaje_original_binario = m_bin.join('')
    m_bin = Integer(m_bin.join('')) #convierto a entero el string binario
    tam_mensaje = @mensaje_original_binario.length() - 2 #resto 2 para no contar el 0b

    #puts "Mensaje en binario: #{@mensaje_original_binario}"
    #puts "tam #{tam_mensaje}"

    #Registros
    r1 = Array.new(19) #del 0 al 18
    r2 = Array.new(22) #del 0 al 21
    r3 = Array.new(23) #del 0 al 22

    #Array para almacenar los bits que forman la clave
    cl = []

    #Inicialización de los registros con las semillas
    #Reverse para invertir los índices y que me quede como en el ejemplo
    SR1.reverse.each_char do |c|
      r1 << c.to_i
    end

    SR2.reverse.each_char do |c|
      r2 << c.to_i
    end

    SR3.reverse.each_char do |c|
      r3 << c.to_i
    end

    #elimino los elementos nil que se añaden por defecto al crear los arrays
    r1.delete(nil)
    r2.delete(nil)
    r3.delete(nil)

    #imprimo los registros inicializados
    puts "ITERACION 0"
    print "r1: #{r1}"
    puts ""
    print "r2: #{r2}"
    puts ""
    print "r3: #{r3}"
    puts ""
    puts ""

    #Cálculo de la clave
    iter = 0 #iterador
    while iter<tam_mensaje do

      #Calcular bit que sale
      cl << (r1[18].to_i^r2[21].to_i^r3[22].to_i)
      puts "Bits de clave: #{cl.join('')}"

      #Calcular mayoria para saber que registro se mueve
      mayoria = calcular_mayoria(r1, r2, r3)

      if mayoria #la mayoria es 1
        if r1[8] == 1
          puts "Se desplaza r1"
          aux = (r1[18]^r1[17]^r1[16]) #valor para la retroalimentación
          array_aux = r1.desplazar(1)
          array_aux[0] = aux
          r1 = array_aux
        end

        if r2[10] == 1
          puts "Se desplaza r2"
          aux2 = (r2[21]^r2[20]) #valor para la retroalimentación
          array_aux2 = r2.desplazar(2)
          array_aux2[0] = aux2
          r2 = array_aux2
        end


        if r3[10] == 1
          puts "Se desplaza r3"
          aux3 = (r3[22]^r3[21]^r3[20]^r3[7]) #valor para la retroalimentación
          array_aux3 = r3.desplazar(3)
          array_aux3[0] = aux3
          r3 = array_aux3
        end

      else #la mayoria es 0
        if r1[8] == 0
          puts "Se desplaza r1"
          aux = (r1[18]^r1[17]^r1[16]^r1[13]) #valor para la retroalimentación
          array_aux = r1.desplazar(1)
          array_aux[0] = aux #inserto el valor de la retroalimentación en la primera posición
          r1 = array_aux
        end

        if r2[10] == 0
          puts "Se desplaza r2"
          aux2 = (r2[21]^r2[20]) #valor para la retroalimentación
          array_aux2 = r2.desplazar(2)
          array_aux2[0] = aux2 #inserto el valor de la retroalimentación en la primera posición
          r2 = array_aux2
        end

        if r3[10] == 0
          puts "Se desplaza r3"
          aux3 = (r3[22]^r3[21]^r3[20]^r3[7]) #valor para la retroalimentación
          array_aux3 = r3.desplazar(3)
          array_aux3[0] = aux3 #inserto el valor de la retroalimentación en la primera posición
          r3 = array_aux3
        end
      end

      puts ""
      puts ""
      if iter + 1 >= tam_mensaje
        puts "Registros finales:"
        print "r1: #{r1}"
        puts ""
        print "r2: #{r2}"
        puts ""
        print "r3: #{r3}"
        puts ""
        puts ""
      else
        puts "ITERACION #{iter+1}"
        print "r1: #{r1}"
        puts ""
        print "r2: #{r2}"
        puts ""
        print "r3: #{r3}"
        puts ""
        puts ""
      end
      iter = iter + 1

    end
    puts "A5/1 finalizado"


    clave = Integer('0b' + cl.join(''))
    puts ""
    puts "Clave: #{'0b' + cl.join('')}"
    puts ""

    #Cifrando mensaje
    resultado = m_bin^clave
    resultado = resultado.to_s(2)
    if resultado.length() < tam_mensaje #para evitar que elimine los ceros a la izquierda
      n = tam_mensaje - resultado.length()
      n.times do |x|
        resultado.insert(0, '0') #inserta los 0 que faltan
      end
    end
    #puts "#{resultado}"
    @mensaje_cifrado_binario = '0b' + resultado
    y=[]
    z=0
    #separo por bytes (8 dígitos) el mensaje_cifrado_binario y lo almaceno en el array y
    while z<resultado.length() do
      arr=resultado[z..z+7]
      y << '0b' + arr
      z=z+8
      #print "arr: #{arr}"
      #puts ""
    end

    #convierto cada byte a su equivalente en ASCII y lo almaceno en el array mc
    mc=[]
    y.each do |x|
      #puts x
      mc << Integer(x).chr
    end

    @mensaje_cifrado = mc.join('')

  end

end


#######################################################################
# m = "O"
# me = A5.new(m)
# me.cifrar()

print "Inserte mensaje: "
m1 = gets #almacena en la variable m1 el texto introducido por el usuario

#se le da el formato adecuado al mensaje introducido por el usuario
m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
m1.gsub!(/\s+/, '') #elimino espacios
r = A5.new(m1)

puts " "
puts "MENU"
puts "==========="
puts ""
puts "Elige una opción:
1: Cifrar
2: Descifrar"

case gets.strip
  when "1"
    puts ""
    r.cifrar()
    puts "Mensaje original: #{r.mensaje_original}"
    puts "Mensaje original en binario: #{r.mensaje_original_binario}"
    puts "Mensaje cifrado en binario: #{r.mensaje_cifrado_binario}"
    puts "Mensaje cifrado: #{r.mensaje_cifrado}"
  when "2"
    puts ""
    r.cifrar()
    puts "Mensaje cifrado: #{r.mensaje_original}"
    puts "Mensaje cifrado en binario: #{r.mensaje_original_binario}"
    puts "Mensaje original en binario: #{r.mensaje_cifrado_binario}"
    puts "Mensaje original: #{r.mensaje_cifrado}"
end

puts ""
puts ""
