SR1 = '1001000100011010001'
m = "mo"
a = []
b = []

SR1.reverse.each_char do |c|
  a << c
end

m.each_byte do |ch|
  b << ch
end

class Integer

	  def num_digitos

	      self.to_s.size

	  end

end

y = Integer(b.join(''))
puts y
puts y.num_digitos
puts "#{(109+111).to_s(2)}"
class Array

  def desplazar
    arr = []

    self.each_with_index do |val, i|
      arr[i+1] = val
    end

    arr
  end

end
 j = [1,2,3]

 j2 = j.desplazar
 j2[0] = -3
 j2.each_with_index do |val, i|
   puts "#{i} #{val}"
 end

 puts 0b01^0b01^0b01
