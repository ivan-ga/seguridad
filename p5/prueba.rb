#crear matriz

def crearmatriz(filas, columnas)
  aux = Array.new(filas)
  (0..aux.length-1).each_with_index do |i|
    aux[i] = Array.new(columnas)
  end
  aux
end

s = ["0x0a","0x0b","0x0c","0x0d"]
e=s[0].to_s.split('')
puts e
num=e[3].to_i(16)
puts num
