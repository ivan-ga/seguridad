#crear matriz

def crearmatriz(filas, columnas)
  aux = Array.new(filas)
  (0..aux.length-1).each_with_index do |i|
    aux[i] = Array.new(columnas)
  end
  aux
end

num = 45
arcadio = num.to_s.split('')
num1 = arcadio[0].to_i
puts num1.class
puts num1
