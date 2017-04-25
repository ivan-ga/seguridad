# 7.times do |x|
#   "p"+"#{x}" = x
#
# end

x = 3

puts "p"+"#{x}"


instance_variable_set("@Game#{x += 1}", 20)

puts @Game4
