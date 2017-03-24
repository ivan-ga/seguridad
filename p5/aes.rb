#Práctica 5: AES
#AUtor: Iván González Aguiar
#alu0100551266@ull.edu.es

##############################################################################

CAJA_S = [0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16]

MATRIZ_MIX_COLUMN = [0x2, 0x3, 0x1, 0x1,
0x1, 0x2, 0x3, 0x1,
0x1, 0x1, 0x2, 0x3,
0x3, 0x1, 0x1, 0x2]


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

  #RELLENA MATRIZ CON LOS ELEMENTOS DE UN VECTOR DADO
  def rellenar_matriz(vector)

      i=0 #filas
      k=0 #iterador para el vector
      aux = Matriz.new(self.filas, self.columnas)
      aux.crear_matriz()
      while i<filas && k<vector.length() do
        j=0 #columnas
        while j<columnas do
          aux.set_elemento(vector[k],i,j)
          j=j+1
          k=k+1
        end
        i=i+1
      end

      @valores = aux.valores

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

  #ROTWORD
  def desplazar_vertical(columna)
    arr_aux = []

    arr_aux << @valores.get_elemento(1, columna)
    arr_aux << @valores.get_elemento(2, columna)
    arr_aux << @valores.get_elemento(3, columna)
    arr_aux << @valores.get_elemento(0, columna)

    arr_aux
  end

  #AÑADIR COLUMNA A LA DERECHA
  def add_columna(v1, v2, v3, v4)

    set_elemento(v1, 0, @columnas) #columnas-1 porque empieza en 0
    set_elemento(v2, 1, @columnas)
    set_elemento(v3, 2, @columnas)
    set_elemento(v4, 3, @columnas)
    @columnas = @columnas + 1
  end

end

class Aes

  attr_accessor :mensaje_original
  attr_accessor :mensaje_cifrado
  attr_accessor :clave

  def initialize(mensaje, clave)
    @mensaje_original = mensaje
    @clave = clave
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

  def calcular_sublcaves
    j=4 #columnas
    while j<16
      if j%4 == 0
        aux = @matriz_clave.desplazar_vertical(j)
        #cambiar por valor de la caja s y hacer el xor
      else
        i=0
        while i<@matriz_clave.filas
            @matriz_clave.set_elemento((@matriz_clave.get_elemento(i,j-1)^@matriz_clave.get_elemento(i,j-4),i,j))
            i=i+1
        end
      end
      @columnas=@columnas+1
      j=j+1
    end
  end

end



pepe = Aes.new('00112233445566778899aabbccddeeff', '000102030405060708090a0b0c0d0e0f')
mat_estado=pepe.generar_matriz(pepe.mensaje_original)
mat_estado.traspuesta()
mat_estado.mostrar()
puts ""
mat_claves=pepe.generar_matriz(pepe.clave)
mat_claves.traspuesta()
mat_claves.mostrar()
puts ""
caja_s = Matriz.new(16,16)
caja_s.rellenar_matriz(CAJA_S)
caja_s.mostrar()
