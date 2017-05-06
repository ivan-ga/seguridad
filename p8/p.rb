ALFABETO = {"A"=>0,"B"=> 1,"C"=> 2,"D"=> 3,"E"=> 4,"F"=> 5,"G"=> 6,"H"=> 7,
"I"=> 8,"J"=> 9, "K"=>10, "L"=>11, "M"=>12, "N"=>13, "O"=>14, "P"=>15, "Q"=>16,
"R"=>17, "S"=>18, "T"=>19, "U"=>20, "V"=>21, "W"=>22, "X"=>23, "Y"=>24, "Z"=>25}

TAM_ALFABETO = ALFABETO.size() #tamaño del alfabeto

def calcular_j(n)
  j = 0
  resultado = 0

  while resultado<n
    resultado = TAM_ALFABETO ** j
    puts resultado
    if resultado<n
      j = j + 1
    end
  end

  j-1
end

#Método para la codificación del texto
def codificar(texto, n)

  j = calcular_j(n)

  texto = texto.delete!(' ') #elimino espacios
  texto_bloques = texto.chars.each_slice(j).map(&:join) #array con el mensaje dividido en bloques de tamaño j-1
  i = j - 1
  resultado_parcial = 0
  resultado = []

  texto_bloques.each do |c|
    i = j - 1
    resultado_parcial = 0

    c.split("").each do |k|
      resultado_parcial = resultado_parcial + (ALFABETO[k]*(TAM_ALFABETO**i))
      i = i-1
    end

    resultado << resultado_parcial
  end

  resultado

end

n=2347*347

puts calcular_j(n)
