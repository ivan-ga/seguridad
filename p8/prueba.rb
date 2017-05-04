def divisible(num)

    PRIMOS.size().times do |i|

      if(num % PRIMOS[i]) == 0
        divisible = true
      else
        divisible = false
        break
      end

    end

    divisible
end


def test_primalidad(num)

  if divisible(num)
    return false

  else

    vector_enteros = []

    if num > 100

      100.times do |i|
        vector_enteros << rand(1..num-1)
      end

    else

      (num/2).times do |i|
        vector_enteros << rand(1..num-1)
      end

    end

    exponente = (num-1) / 2
    resultado = []

    vector_enteros.each_with_index do |val, i|
      resultado[i] = exponenciacion(val, exponente, num)

      if resultado[i] != 1 || resultado[i] != -1
        retorna = false
        break
      end
    end

    if resultado.todo_unos?
      retorna = false
    else
      retorna = true
    end


    retorna
end
end

puts test_primalidad(4)
