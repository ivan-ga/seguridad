#Práctica 5: AES
#AUtor: Iván González Aguiar
#alu0100551266@ull.edu.es

##############################################################################

class Matriz

  def initialize(filas, columnas)
    @filas = filas
    @columnas = columnas

    aux = Array.new(filas)
    (0..aux.length-1).each_with_index do |i|
      aux[i] = Array.new(columnas)
    end
    aux
  end

  def set_elemento!(elemento, fila, columna)
    self[fila][columna] = elemento
  end

  def get_elemento(fila, columna)
    self[fila][columna]
  end

  
end
