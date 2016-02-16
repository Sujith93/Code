# Prints
puts 3 
## Flow Of Control
# if/elsif/else
# case
# until/unless 
# while/for
a=5
if a==3
puts "a is 3"	
 elsif a==5
 	puts "a is 5"
 else
 	puts "a is not 3 or 5"
 end

 unless a==6
 puts "a is not 6"
 end	
a=10
while a>9
	puts a
	a -=1
	#same as a=a-1
end

a=9
until a>=10
	puts a
	a+=1
	puts a
end
#If modifier Form
a =5
b=0
puts "One Linear" if a==5 and b==0
times_2 = 2
times_2 *= 2 while times_2 < 100
puts times_2

#True/False
puts "Hai everyone" if 0
puts "Hai everyone" if "false"
puts "Hai everyone" if false  ## No output
puts "Hai everyone" if "nil"
puts "Hai everyone" if nil    ## No output
puts "Hai everyone" if ""
if Integer === 21
puts "its working"
end 