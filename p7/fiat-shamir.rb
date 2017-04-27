

#Algoritmo de Euclides para comprobar si dos números son primos entre sí
def euclides(a, b)
  if(a < b)
    dividendo = b
    divisor = a
  else
    dividendo = a
    divisor = b
  end

  resto = 1

  while(resto > 0)
    cociente = dividendo / divisor
    resto = dividendo % divisor
    dividendo = divisor
    divisor = resto
  end

  if(dividendo != 1)
    return false
  else
    return true
  end

end
