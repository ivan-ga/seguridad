#Práctica final
#Autor: Iván González Aguiar
#alu0100551266@ull.edu.es

################################################################################

#Incluyendo todos los ficheros
require './vernam.rb'
require './vigenere.rb'
require './rc4.rb'
require './a5.rb'
require './aes.rb'
require './dh.rb'
require './fiat-shamir.rb'
require './rsa.rb'


#Funciones

def vernam
  print "Inserte mensaje: "
  m1 = gets #almacena en la variable m1 el texto introducido por el usuario
  m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
  puts ""
  m = Vernam.new(m1)

  puts "MENU"
  puts "==========="
  puts ""
  puts "Elige una opción
  1: Cifrar
  2: Descifrar"

  case gets.strip
    when "1"
      puts ""
      m.cifrar()

      puts "Mensaje original: #{m.mensaje}"

      puts "Mensaje original en binario: #{m.mensaje_original_binario.to_s(2)}"

      puts "Clave aleatoria: #{CLAVE.to_s(2)}"

      puts "Mensaje cifrado en binario: #{m.mensaje_cifrado_binario}"

      puts "Mensaje cifrado: #{m.mensaje_cifrado}"
    when "2"
      puts ""
      m.descifrar()

      puts "Mensaje cifrado: #{m.mensaje}"

      puts "Mensaje cifrado en binario: #{m.mensaje_cifrado_binario}"

      puts "Mensaje descifrado en binario: #{m.mensaje_original_binario}"

      puts "Mensaje descifrado: #{m.mensaje_cifrado}"
    end
end

def vigenere

  print "Inserte mensaje: "
  m1 = gets #almacena en la variable m1 el texto introducido por el usuario

  #se le da el formato adecuado al mensaje introducido por el usuario
  m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
  m1.delete!(' ') #elimino los espacios
  m1 = m1.upcase #se pasa el mensaje a mayúsculas
  #m1.scan(/.../) #divido el texto en bloques
  puts " "

  print "Inserte clave: "
  c1 = gets #almacena en la variable c1 la clave introducida por el usuario

  #se le da el formato adecuado a la clave introducida por el usuario
  c1.delete!("\n") #elimino el salto de línea que se incluye por defecto
  c1.delete!(' ') #elimino los espacios
  c1 = c1.upcase #se pasa la clave a mayúsculas
  puts " "

  m = Vigenere.new(m1)

  puts "MENU"
  puts "==========="
  puts ""
  puts "Elige una opción:
  1: Cifrar
  2: Descifrar"

  case gets.strip
    when "1"
      puts ""
      m.cifrar(c1)

      puts "Mensaje original: #{m.mensaje_original}"

      puts "Mensaje cifrado: #{m.mensaje_cifrado}"
    when "2"
      puts ""
      m.descifrar(c1)

      puts "Mensaje original: #{m.mensaje_original}"

      puts "Mensaje descifrado: #{m.mensaje_cifrado}"
  end

end

def rc4

  r = Rc4.new()

  print "Inserte mensaje: "
  m1 = gets #almacena en la variable m1 el texto introducido por el usuario

  #se le da el formato adecuado al mensaje introducido por el usuario
  m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
  r.mensaje_original = m1.split(" ")
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
      puts "Mensaje original: #{r.mensaje_original.join(" ")}"
      puts "Mensaje cifrado: #{r.mensaje_cifrado.join(" ")}"
    when "2"
      puts ""
      r.cifrar()
      puts "Mensaje cifrado: #{r.mensaje_original.join(" ")}"
      puts "Mensaje original: #{r.mensaje_cifrado.join(" ")}"
  end

end

def a5

  puts " "
  puts "MENU"
  puts "==========="
  puts ""
  puts "Elige una opción:
  1: Letras
  2: Números binarios"

  opc = gets #almacena opcion
  opc = opc.to_i #para que me funcionen bien los if lo paso a entero

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
      r.cifrar(opc)
      puts "Mensaje original: #{r.mensaje_original}"
      if opc == 1
        puts "Mensaje original en binario: #{r.mensaje_original_binario}"
      end
      puts "Mensaje cifrado en binario: #{r.mensaje_cifrado_binario}"
      if opc == 1
        puts "Mensaje cifrado: #{r.mensaje_cifrado}"
      end
    when "2"
      puts ""
      r.cifrar(opc)
      puts "Mensaje cifrado: #{r.mensaje_original}"
      if opc == 1
        puts "Mensaje original en binario: #{r.mensaje_original_binario}"
      end
      puts "Mensaje original en binario: #{r.mensaje_cifrado_binario}"
      if opc == 1
        puts "Mensaje cifrado: #{r.mensaje_cifrado}"
      end
  end

  puts ""
  puts ""

end

def aes

  caja_s = Matriz.new(16,16)
  caja_s.rellenar_matriz(CAJA_S)

  caja_s_inv = Matriz.new(16,16)
  caja_s_inv.rellenar_matriz(CAJA_S_INV)

  rcon = Matriz.new(4,10)
  rcon.rellenar_matriz(RCON)

  mc = Matriz.new(4,4)
  mc.rellenar_matriz(MATRIZ_MIX_COLUMN)

  mc_inv = Matriz.new(4,4)
  mc_inv.rellenar_matriz(MATRIZ_MIX_COLUMN_INV)

  print "Inserte mensaje: "
  m1 = gets #almacena en la variable m1 el texto introducido por el usuario
  #se le da el formato adecuado al mensaje introducido por el usuario
  m1.delete!("\n") #elimino el salto de línea que se incluye por defecto
  #m1 = m1.split(" ")
  print "Inserte clave: "
  c1 = gets #almacena en la variable m1 el texto introducido por el usuario
  c1.delete!("\n") #elimino el salto de línea que se incluye por defecto
  #c1 = c1.split(" ")

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
      ej1 = Aes.new(m1, c1)
      ej1.cifrar(caja_s, rcon, mc)
      puts ""
      puts "Mensaje cifrado: #{ej1.mensaje_cifrado}"
      puts ""
    when "2"
      puts ""
      ej1 = Aes.new(m1, c1)
      ej1.descifrar(caja_s, rcon, mc_inv, caja_s_inv)
      puts ""
      puts "Mensaje descifrado: #{ej1.mensaje_cifrado}"
      puts ""
  end

end

def diffieHellman

  puts ""
  print "Inserte número primo: "
  num = gets.to_i
  puts " "

  print "Inserte alfa: "
  alfa = gets.to_i
  puts " "

  print "Inserte secreto de A: "
  xa = gets.to_i
  puts " "

  print "Inserte secreto de B: "
  xb = gets.to_i
  puts " "

  a = Dh.new(xa, alfa, num)
  b = Dh.new(xb, alfa, num)

  puts "CALCULO DE LA Y"
  a.calcular_y()
  b.calcular_y()

  puts "yA: #{a.y}"
  puts "yB: #{b.y}"
  puts " "

  puts "CALCULO DE LA K"
  a.calcular_clave(b.y)
  b.calcular_clave(a.y)

  puts "k (generada en A): #{a.k}"
  puts "k (generada en B): #{b.k}"
  puts ""

end

def fiatShamir

  puts ""
  print "Inserte valor de p: "
  pe = gets.to_i
  puts " "

  #si el valor no es primo, se vuelve a pedir
  if pe.prime? == false
    while !pe.prime?
      puts ""
      puts "El valor insertado no es primo, insertalo de nuevo."
      print "Inserte valor de p: "
      pe = gets.to_i
      puts " "
    end
  end

  print "Inserte valor de q: "
  q = gets.to_i
  puts " "

  #si el valor no es primo, se vuelve a pedir
  if q.prime? == false
    while !q.prime?
      puts ""
      puts "El valor insertado no es primo, insertalo de nuevo."
      print "Inserte valor de p: "
      q = gets.to_i
      puts " "
    end
  end

  #Cálculo de la N
  n = pe * q

  print "Inserte valor de s: "
  s = gets.to_i
  puts " "

  #si el valor es menor que cero o no es primo con N, se vuelve a pedir
  if s<0 || euclides(s, n) == false
    while s<0 || euclides(s, n) == false
      puts ""
      puts "El valor insertado no es correcto, insertalo de nuevo."
      print "Inserte valor de s: "
      s = gets.to_i
      puts " "
    end
  end

  print "Inserte número de iteraciones: "
  i = gets.to_i
  puts " "

  a = Probador.new()
  b = Verificador.new()


  #Identificación pública de A
  a.calcular_v(s, n)

  puts "N: #{n}"
  puts "v: #{a.v}"

  i.times do |iter|
    puts ""
    puts "Iteración #{iter+1}:"
    puts ""
    print "Inserte valor de x: "
    a.x = gets.to_i
    puts ""
    print "Inserte valor de e: "
    b.e = gets.to_i
    puts ""

    #A envía a B el testigo
    a.calcular_a(n)
    b.a = a.a
    puts "a: #{a.a}"

    #B envía reto a A
    a.e = b.e

    #Respuesta, A envía a B la y
    a.calcular_y(n, s)
    b.y = a.y

    #Verificar, B comprueba la información recibida
    b.verificar(n, a.v)
  end

end

def rsa

  puts ""
  print "Inserte mensaje: "
  m8 = gets #almacena en la variable m1 el texto introducido por el usuario

  #se le da el formato adecuado al mensaje introducido por el usuario
  m8.delete!("\n") #elimino el salto de línea que se incluye por defecto
  #m1.delete!(' ') #elimino los espacios
  m8 = m8.upcase #se pasa el mensaje a mayúsculas

  puts ""
  print "Inserte valor de p: "
  pee = gets.to_i
  puts " "

  #si el valor no es primo, se vuelve a pedir
  if test_primalidad(pee) == false
    while !test_primalidad(pee)
      puts ""
      puts "El valor insertado no es primo, insertalo de nuevo."
      print "Inserte valor de p: "
      pee = gets.to_i
      puts " "
    end
  end

  print "Inserte valor de q: "
  qq = gets.to_i
  puts " "

  #Cálculo de la N
  nn = pee * qq

  #si el valor no es primo, se vuelve a pedir
  if test_primalidad(qq) == false
    while !test_primalidad(qq)
      puts ""
      puts "El valor insertado no es primo, insertalo de nuevo."
      print "Inserte valor de p: "
      qq = gets.to_i
      puts " "
    end
  end

  print "Inserte valor de d: "
  dd = gets.to_i
  puts " "

  #si el valor es menor que cero o no es primo con N, se vuelve a pedir
  if dd<0 || euclides(dd, nn) == false
    while dd<0 || euclides(dd, nn) == false
      puts ""
      puts "El valor insertado no es correcto, insertalo de nuevo."
      print "Inserte valor de d: "
      dd = gets.to_i
      puts " "
    end
  end

  # print "Inserte valor de Φ: "
  # fi = gets.to_i
  # puts " "

  rsa = Rsa.new(m8)

  #Asignación de valores
  rsa.pee = pee
  rsa.qq = qq

  #Codificación del mensaje
  rsa.codificar(nn)

  #Cálculo de fi
  rsa.calcular_fi(pee, qq)

  #Cálculo de la e
  ee = euclides_extendido(dd, rsa.fi)
  if ee < 0
    ee = (ee + rsa.fi)
  end


  puts "MENU"
  puts "==========="
  puts ""
  puts "Elige una opción:
  1: Cifrar
  2: Descifrar"

  case gets.strip
    when "1"
      puts ""

      rsa.cifrar(nn, rsa.mensaje_codificado, ee)

      puts "Mensaje original: #{rsa.mensaje_original}"

      puts "N: #{nn}"
      puts "Φ: #{rsa.fi}"
      puts "e: #{ee}"

      puts "Mensaje cifrado: #{rsa.mensaje_cifrado.join(" ")}"
    when "2"
      puts ""
      rsa.descifrar(nn, rsa.mensaje_codificado, ee)

      puts "Mensaje cifrado: #{rsa.mensaje_original}"

      puts "N: #{nn}"
      puts "Φ: #{rsa.fi}"
      puts "e: #{ee}"

      puts "Mensaje descifrado: #{rsa.mensaje_cifrado.join(" ")}"
  end

end


################################################################################

op = -1
while op != 0
  puts ""
  puts ""
  puts "MENU DE PRACTICAS"
  puts "================="
  puts ""
  puts "Elige una opción
  1: Vernam
  2: Vigenere
  3: RC4
  4: A5
  5: AES
  6: Diffie-Hellman
  7: Fiat-Shamir
  8: RSA
  0: Salir"

  case gets.strip
  when "0"
    op = 0

    when "1"
      vernam()

    when "2"
      vigenere()

    when "3"
      rc4()

    when "4"
      a5()

    when "5"
      aes()

    when "6"
      diffieHellman()

    when "7"
      fiatShamir()

    when "8"
      rsa()
  end
end
