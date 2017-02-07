a=['0b']

"SOL".each_byte do |c|

    a << '0' + c.to_s(2)
    a
end



print a

b=a.join('')
c=Integer(b)
puts b
puts c

r = c^0b001111000001100001110011
puts r
i=r.to_s(10)

h = '0'+r.to_s(2)
puts h
y=[]
z=0
while z<h.length() do
  arr=h[z..z+7]
  y << '0b' + arr
  z=z+8
end

puts Integer(y[0]).chr
