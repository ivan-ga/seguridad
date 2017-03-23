#Práctica 5: AES
#AUtor: Iván González Aguiar
#alu0100551266@ull.edu.es

##############################################################################

class Matriz

  attr_accessor :filas
  attr_accessor :columnas
  attr_accessor :valores

  #CONSTRUCTOR
  def initialize(filas, columnas)
    @filas = filas
    @columnas = columnas
    @valores = []
  end

  #MÉTODO PARA CREAR MATRIZ VACÍA
  def crear_matriz
    aux = Array.new(filas)
    (0..aux.length-1).each_with_index do |i|
      aux[i] = Array.new(columnas)
    end
    @valores = aux
  end

  #SETTER
  def set_elemento(elemento, fila, columna)
    @valores[fila][columna] = elemento
  end

  #GETTER
  def get_elemento(fila, columna)
    @valores[fila][columna]
  end

  #MUESTRA LA MATRIZ
  def mostrar
    i=0 #filas

    while i<filas do
      j=0 #columnas
      while j<columnas do
        print "#{get_elemento(i,j)}" + " "
        j=j+1
      end
      i=i+1
      print "\n"
    end

  end

  #CALCULA LA TRASPUESTA DE LA MATRIZ
  def traspuesta
    i=0 #filas
    aux = Matriz.new(self.columnas, self.filas)
    aux.crear_matriz()
    while i<filas do
      j=0 #columnas
      while j<columnas do
        aux.set_elemento(get_elemento(i,j),j,i)
        j=j+1
      end
      i=i+1
    end

    @valores = aux.valores

  end

end

class Aes

  attr_accessor :mensaje_original
  attr_accessor :mensaje_cifrado

  def initialize(mensaje)
    @mensaje_original = mensaje
    @mensaje_cifrado = nil
    @matriz_estado = nil
    @matriz_clave = nil
  end

  def generar_matriz(dato)

    mat = Matriz.new(4,4)
    mat.crear_matriz()

    pares = dato.scan(/.{1,2}/)
    i=0
    j=0
    pares.each do |val|
      val = '0x' + val

      if i<mat.filas
        if j<mat.columnas
          mat.set_elemento(val,i,j)
          j=j+1
        else
          j=0
          i=i+1
          mat.set_elemento(val,i,j)

          j=j+1
        end
      end
    end

    mat

  end

end



pepe = Aes.new('00112233445566778899aabbccddeeff')
a=pepe.generar_matriz(pepe.mensaje_original)
a.traspuesta()
a.mostrar()
