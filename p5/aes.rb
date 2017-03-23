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
    @valores = nil
  end

  #MÉTODO PARA CREAR MATRIZ VACÍA
  def crear_matriz
    aux = Array.new(self.filas)
    (0..aux.length-1).each_with_index do |i|
      aux[i] = Array.new(self.columnas)
    end
    self.valores=aux
  end

  #SETTER
  def set_elemento!(elemento, fila, columna)
    valores[fila][columna] = elemento
  end

  #GETTER
  def get_elemento(fila, columna)
    valores[fila][columna]
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

end

class AES
  

end
