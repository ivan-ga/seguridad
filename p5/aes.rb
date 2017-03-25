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

RCON = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]

MATRIZ_MIX_COLUMN = [0x2, 0x3, 0x1, 0x1,
0x1, 0x2, 0x3, 0x1,
0x1, 0x1, 0x2, 0x3,
0x3, 0x1, 0x1, 0x2]

#MATRICES PARA LA BUSQUEDA DE VALORES AL MULTIPLICAR EN MIXCOLUMN
#multiplicación por 2
M2 = [0x00,0x02,0x04,0x06,0x08,0x0a,0x0c,0x0e,0x10,0x12,0x14,0x16,0x18,0x1a,0x1c,0x1e,
0x20,0x22,0x24,0x26,0x28,0x2a,0x2c,0x2e,0x30,0x32,0x34,0x36,0x38,0x3a,0x3c,0x3e,
0x40,0x42,0x44,0x46,0x48,0x4a,0x4c,0x4e,0x50,0x52,0x54,0x56,0x58,0x5a,0x5c,0x5e,
0x60,0x62,0x64,0x66,0x68,0x6a,0x6c,0x6e,0x70,0x72,0x74,0x76,0x78,0x7a,0x7c,0x7e,
0x80,0x82,0x84,0x86,0x88,0x8a,0x8c,0x8e,0x90,0x92,0x94,0x96,0x98,0x9a,0x9c,0x9e,
0xa0,0xa2,0xa4,0xa6,0xa8,0xaa,0xac,0xae,0xb0,0xb2,0xb4,0xb6,0xb8,0xba,0xbc,0xbe,
0xc0,0xc2,0xc4,0xc6,0xc8,0xca,0xcc,0xce,0xd0,0xd2,0xd4,0xd6,0xd8,0xda,0xdc,0xde,
0xe0,0xe2,0xe4,0xe6,0xe8,0xea,0xec,0xee,0xf0,0xf2,0xf4,0xf6,0xf8,0xfa,0xfc,0xfe,
0x1b,0x19,0x1f,0x1d,0x13,0x11,0x17,0x15,0x0b,0x09,0x0f,0x0d,0x03,0x01,0x07,0x05,
0x3b,0x39,0x3f,0x3d,0x33,0x31,0x37,0x35,0x2b,0x29,0x2f,0x2d,0x23,0x21,0x27,0x25,
0x5b,0x59,0x5f,0x5d,0x53,0x51,0x57,0x55,0x4b,0x49,0x4f,0x4d,0x43,0x41,0x47,0x45,
0x7b,0x79,0x7f,0x7d,0x73,0x71,0x77,0x75,0x6b,0x69,0x6f,0x6d,0x63,0x61,0x67,0x65,
0x9b,0x99,0x9f,0x9d,0x93,0x91,0x97,0x95,0x8b,0x89,0x8f,0x8d,0x83,0x81,0x87,0x85,
0xbb,0xb9,0xbf,0xbd,0xb3,0xb1,0xb7,0xb5,0xab,0xa9,0xaf,0xad,0xa3,0xa1,0xa7,0xa5,
0xdb,0xd9,0xdf,0xdd,0xd3,0xd1,0xd7,0xd5,0xcb,0xc9,0xcf,0xcd,0xc3,0xc1,0xc7,0xc5,
0xfb,0xf9,0xff,0xfd,0xf3,0xf1,0xf7,0xf5,0xeb,0xe9,0xef,0xed,0xe3,0xe1,0xe7,0xe5]

#multiplicación por 3
M3 = [0x00,0x03,0x06,0x05,0x0c,0x0f,0x0a,0x09,0x18,0x1b,0x1e,0x1d,0x14,0x17,0x12,0x11,
0x30,0x33,0x36,0x35,0x3c,0x3f,0x3a,0x39,0x28,0x2b,0x2e,0x2d,0x24,0x27,0x22,0x21,
0x60,0x63,0x66,0x65,0x6c,0x6f,0x6a,0x69,0x78,0x7b,0x7e,0x7d,0x74,0x77,0x72,0x71,
0x50,0x53,0x56,0x55,0x5c,0x5f,0x5a,0x59,0x48,0x4b,0x4e,0x4d,0x44,0x47,0x42,0x41,
0xc0,0xc3,0xc6,0xc5,0xcc,0xcf,0xca,0xc9,0xd8,0xdb,0xde,0xdd,0xd4,0xd7,0xd2,0xd1,
0xf0,0xf3,0xf6,0xf5,0xfc,0xff,0xfa,0xf9,0xe8,0xeb,0xee,0xed,0xe4,0xe7,0xe2,0xe1,
0xa0,0xa3,0xa6,0xa5,0xac,0xaf,0xaa,0xa9,0xb8,0xbb,0xbe,0xbd,0xb4,0xb7,0xb2,0xb1,
0x90,0x93,0x96,0x95,0x9c,0x9f,0x9a,0x99,0x88,0x8b,0x8e,0x8d,0x84,0x87,0x82,0x81,
0x9b,0x98,0x9d,0x9e,0x97,0x94,0x91,0x92,0x83,0x80,0x85,0x86,0x8f,0x8c,0x89,0x8a,
0xab,0xa8,0xad,0xae,0xa7,0xa4,0xa1,0xa2,0xb3,0xb0,0xb5,0xb6,0xbf,0xbc,0xb9,0xba,
0xfb,0xf8,0xfd,0xfe,0xf7,0xf4,0xf1,0xf2,0xe3,0xe0,0xe5,0xe6,0xef,0xec,0xe9,0xea,
0xcb,0xc8,0xcd,0xce,0xc7,0xc4,0xc1,0xc2,0xd3,0xd0,0xd5,0xd6,0xdf,0xdc,0xd9,0xda,
0x5b,0x58,0x5d,0x5e,0x57,0x54,0x51,0x52,0x43,0x40,0x45,0x46,0x4f,0x4c,0x49,0x4a,
0x6b,0x68,0x6d,0x6e,0x67,0x64,0x61,0x62,0x73,0x70,0x75,0x76,0x7f,0x7c,0x79,0x7a,
0x3b,0x38,0x3d,0x3e,0x37,0x34,0x31,0x32,0x23,0x20,0x25,0x26,0x2f,0x2c,0x29,0x2a,
0x0b,0x08,0x0d,0x0e,0x07,0x04,0x01,0x02,0x13,0x10,0x15,0x16,0x1f,0x1c,0x19,0x1a]

################################################################################

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
    #puts "columna: #{columna}"
    arr_aux << @valores[1][columna]
    #puts "desplaza: #{@valores[1][2]}"
    arr_aux << @valores[2][columna]
    arr_aux << @valores[3][columna]
    arr_aux << @valores[0][columna]

    arr_aux
  end

  #DESPLAZAMIENTO HORIZONTAL PARA LA OPERACION SHIFTROWS
  def desplazar_horizontal(fila)
    col = 0
    arr_aux = []

    if fila == 1
      arr_aux << get_elemento(fila, 1)
      arr_aux << get_elemento(fila, 2)
      arr_aux << get_elemento(fila, 3)
      arr_aux << get_elemento(fila, 0)

    elsif fila == 2
      arr_aux << get_elemento(fila, 2)
      arr_aux << get_elemento(fila, 3)
      arr_aux << get_elemento(fila, 0)
      arr_aux << get_elemento(fila, 1)

    elsif fila == 3
      arr_aux << get_elemento(fila, 3)
      arr_aux << get_elemento(fila, 0)
      arr_aux << get_elemento(fila, 1)
      arr_aux << get_elemento(fila, 2)
    end

    while col<@columnas
      set_elemento(arr_aux[col],fila,col)
      col=col+1
    end
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

###############################################################################

class Aes

  attr_accessor :mensaje_original
  attr_accessor :mensaje_cifrado
  attr_accessor :clave
  attr_accessor :matriz_estado
  attr_accessor :matriz_clave
  attr_accessor :array_claves

  def initialize(mensaje, clave)
    @mensaje_original = mensaje
    @clave = clave
    @mensaje_cifrado = nil
    @matriz_estado = nil
    @matriz_clave = nil
    @array_claves = []
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

  #DEVUELVE EL VALOR EN LA CAJA S
  def busqueda_caja_s(v1, v2, matriz)
    matriz.get_elemento(v1,v2)
  end

  def calcular_sublcaves(caj_s, rcon)
    j=4 #columnas
    n=0 #valor para columna rcon
    #@matriz_clave.mostrar()
    while j<44 #44 porque son 10 iteraciones con 4 columnas
      multiplo = j%4

      if (j%4).zero? #es multiplo de 4

        aux = @matriz_clave.desplazar_vertical(j-1)

        fil = 0
        while fil<@matriz_clave.filas
          indices = aux[fil].to_s.split('')

          indice_y = indices[2].to_i(16)
          indice_x = indices[3].to_i(16)

          v = busqueda_caja_s(indice_y, indice_x, caj_s)
          v = v.to_s(16)
          if v.length()<2
            v = "0x0" + v
          else
            v = "0x" + v
          end

          @matriz_clave.set_elemento(v,fil,j) #reemplazo por el valor de la caja s
          resultado = Integer(@matriz_clave.get_elemento(fil,j))^Integer(@matriz_clave.get_elemento(fil,j-4))^rcon.get_elemento(fil,n)

          resultado=resultado.to_s(16)
          if resultado.length() < 2
            resultado="0x0"+resultado
          else
            resultado="0x"+resultado
          end
          @matriz_clave.set_elemento(resultado,fil,j)
          fil=fil+1
        end
        n=n+1
      else
        i=0
        while i<@matriz_clave.filas
            resultado=Integer(@matriz_clave.get_elemento(i,j-1))^Integer(@matriz_clave.get_elemento(i,(j-4)))

            resultado=resultado.to_s(16)
            if resultado.length() < 2
              resultado="0x0"+resultado
            else
              resultado="0x"+resultado
            end
            @matriz_clave.set_elemento(resultado,i,j)
            i=i+1
        end
      end
      @matriz_clave.columnas=@matriz_clave.columnas+1
      j=j+1
    end
  end

  #ALMACENAR LAS CLAVES EN UN ARRAY PARA FACILITAR SU MANEJO
  def almacenar_subclaves
    j=0 #columnas
    aux = []

    while j<@matriz_clave.columnas #están en vertical por eso primero mantengo fija la columna
      i=0 #filas
      while i<@matriz_clave.filas
        aux << @matriz_clave.get_elemento(i,j)
        i=i+1
      end
      j=j+1
    end

    #eliminar el 0x del principio de cada elemento
    aux.each do |c|
      c.slice!('0x')
    end

    #almacenar las clave en el array_claves uniendo todas las partes que forman cada clave
    iter = 0
    while iter<aux.length()
      @array_claves << aux[iter..iter+15].join('')
      iter = iter+16
    end
  end

  #PROCESO SUBBYTES EN LA FASE DE CIFRADO
  def subbytes(caja_s)
    i=0
    while i<@matriz_estado.filas
      j=0
      while j<@matriz_estado.columnas
        indices = @matriz_estado.get_elemento(i,j).to_s.split('')
        #empiezo en 2 para evitar el 0x del inicio de cada número
        indice_y = indices[2].to_i(16)
        indice_x = indices[3].to_i(16)

        v = busqueda_caja_s(indice_y, indice_x, caja_s)
        v = v.to_s(16)
        if v.length()<2
          v = "0x0" + v
        else
          v = "0x" + v
        end

        @matriz_estado.set_elemento(v,i,j)
        j=j+1
      end
      i=i+1
    end
  end

  #PROCESO SHIFTROWS EN LA FASE DE CIFRADO
  def shiftrows
    #la fila 0 no se desplaza
    @matriz_estado.desplazar_horizontal(1)
    @matriz_estado.desplazar_horizontal(2)
    @matriz_estado.desplazar_horizontal(3)
  end

  #PROCESO MIXCOLUMNS EN LA FASE DE CIFRADO
  def mixcolumns(matriz)
    tmp = []
    aux = []

    #multiplicación de matrices(buscando resultado en la tabla correspondiente)
      j=0
      while j<@matriz_estado.columnas
        i=0
        while i<@matriz_estado.filas
          k=0
          while k<matriz.columnas
            if matriz.get_elemento(j,k).to_i == 1
              tmp << Integer(@matriz_estado.get_elemento(k,i))
            elsif matriz.get_elemento(j,k).to_i == 2
              tmp << M2[Integer(@matriz_estado.get_elemento(k,i))]

            else
              tmp << M3[Integer(@matriz_estado.get_elemento(k,i))]
            end
            k=k+1

          end
          aux << (tmp[0].to_i^tmp[1].to_i^tmp[2].to_i^tmp[3].to_i).to_s(16)
          tmp.clear()
          i=i+1
        end
          j=j+1
    end

    #añadiendo el 0x para que lo tome como número hexadecimal
    aux.each_with_index do |val, i|
      if val.length() == 2
        aux[i] = '0x' + val
      elsif val.length() == 1
         aux[i] = '0x0' + val
      end
    end

    #modificando la matriz de estados con los nuevos valores
    col=0 #columnas
    cont=0 #contador para el array aux
    while col<@matriz_estado.columnas
      fil=0
      while fil<@matriz_estado.filas
        @matriz_estado.set_elemento(aux[cont],fil,col)
        cont=cont+1
        fil=fil+1
      end
      col=col+1
    end
    @matriz_estado.traspuesta() #traspuesta ya que los inserté en horizontal
  end


  def add_round_key
    aux = []

    j=0 #columnas
    while j<@matriz_estado.columnas
      i=0 #filas
      while i<@matriz_estado.filas
        aux << ((@matriz_estado.get_elemento(i,j).to_i(16))^(@matriz_clave.get_elemento(i,j).to_i(16))).to_s(16)
        i=i+1
      end
      j=j+1
    end

    #añadiendo los 0x para que sean hexadecimales
    aux.each_with_index do |val, i|
      if val.length() == 2
        aux[i] = '0x' + val
      elsif val.length() == 1
         aux[i] = '0x0' + val
      end
    end

    @matriz_estado.rellenar_matriz(aux)
    @matriz_estado.traspuesta() #insertados en horizontal, necesito hacer traspuesta

  end

  def cifrar
    

  end

end


###########################################################################################
puts ""
caja_s = Matriz.new(16,16)
caja_s.rellenar_matriz(CAJA_S)
#caja_s.mostrar()
rcon = Matriz.new(4,10)
rcon.rellenar_matriz(RCON)
#rcon.mostrar()

mc = Matriz.new(4,4)
mc.rellenar_matriz(MATRIZ_MIX_COLUMN)
puts "mixcolumn"
mc.mostrar()


pepe = Aes.new('00112233445566778899aabbccddeeff', '000102030405060708090a0b0c0d0e0f')
pepe.matriz_estado=pepe.generar_matriz(pepe.mensaje_original)
pepe.matriz_estado.traspuesta()
#pepe.matriz_estado.mostrar()
puts ""
pepe.subbytes(caja_s)
#pepe.matriz_estado.mostrar()
puts ""
pepe.shiftrows()
#pepe.matriz_estado.mostrar()
puts ""
j=0

pepe.mixcolumns(mc)

pepe.matriz_estado.mostrar()
pepe.matriz_clave=pepe.generar_matriz(pepe.clave)
pepe.matriz_clave.traspuesta()
puts ""
puts "matriz clave"
pepe.matriz_clave.mostrar()



pepe.calcular_sublcaves(caja_s, rcon)
#pepe.matriz_clave.mostrar()
pepe.almacenar_subclaves()
#pepe.matriz_clave.mostrar()
pepe.add_round_key()
