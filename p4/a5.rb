#Práctica 4: Cifrado A5/1
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es
########################################################################

#Semillas

SR1 = '1001000100011010001'
SR2 = '0101100111100010011010'
SR3 = '10111100110111100001111'


class Array

  def desplazar
    arr = []

    self.each_with_index do |val, i|
      arr[i+1] = val
    end

    arr
  end

end

class a5

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

    cuenta_ceros = mayoria.count(0)
    cuenta_unos = mayoria.count(1)

    if cuenta_ceros > cuenta_unos
      return false
    else
      return true
    end

  end

  def cifrar

    #Convirtiendo mensaje a binario
    a=['0b'] #tengo que añadir el 0b para que tome el número como binario

    @mensaje_original.each_byte do |c|
        a << '0' + c.to_s(2) #añado el 0 ya que lo simplifica por defecto
    end

    @mensaje_original_binario = Integer(a.join(''))

    #Registros
    r1 = Array.new(19) #del 0 al 18
    r2 = Array.new(22) #del 0 al 21
    r3 = Array.new(23) #del 0 al 22

    #Array para almacenar los bits que forman el mensaje cifrado
    m_cifrado = []

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

    #Calcular bit que sale
    m_cifrado << (r1[18].to_i^r2[21].to_i^r3[22].to_i)

    #Calcular mayoria para saber que registro se mueve
    mayoria = calcular_mayoria(r1, r2, r3)

    if mayoria #significa que la mayoria es 1
      if r1[8] == 1
        aux = (r[18]^r1[17]^r1[16]) #valor para la retroalimentación
        array_aux = r1.desplazar
        array_aux[0] = aux
        r1 = array_aux

      if r2[10] == 1


  end

end
