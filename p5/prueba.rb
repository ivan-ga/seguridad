#crear matriz

def crearmatriz(filas, columnas)
  aux = Array.new(filas)
  (0..aux.length-1).each_with_index do |i|
    aux[i] = Array.new(columnas)
  end
  aux
end
