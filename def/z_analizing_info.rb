# analizing_info

def analizing_info
	puts '4__Анализ информации из ХЕШа.'

	# Получаем массив @arr из Хеша @tree
	create_array @tree, @arr

	output_array @arr

	#  read_info

	# create_array @tree_old, @arr_old

	# output_array @arr_old

	# сравним массивы
	# compare_arrays


end

def create_array hh, array
	item = []
	hh.each do |key, value|
		arr = key.split('/')					# Разделим путь на папки
		### puts arr.inspect

		item = []
		
		if arr.size >= 4							# файлs лежит в ПОД-папке службы. Например "Фото"
			item[0] = arr[0]+'/'+arr[1]	# - пункт мероприятия
			item[1] = arr[2]						# - служба
			item[2] = value.size				# - кол-во файлов
			item[3] = value							# - имена файлов

		elsif arr.size == 3							# файл лежит в папке службы СТАНДАРТ
			item[0] = arr[0]+'/'+arr[1]
			item[1] = arr[2]
			item[2] = value.size
			item[3] = value	

		elsif arr.size == 2							# файлs лежит в папке пункта НЕ ХОРОШО
			item[0] = arr[0]+'/'+arr[1]
			item[1] = '----------------------'
			item[2] = value.size
			item[3] = value		

		elsif arr.size == 1							# файлs лежит в корневой папке ПЛОХО 
			item[0] = arr[0]+'/'
			item[1] = '----------------------'
			item[2] = value.size
			item[3] = value	
		end	


		# Будем искать "старые_данные" в массиве
		f = 0	
		array.each do |old_item|			# перечислим массив.  
			if old_item[0] == item[0] && old_item[1] == item[1] # Если пункт и служба совпали
				old_item[2] += item[2]		# то добавим новые данные к старым
				old_item[3] += item[3]
				f = 1 	
			end	
		end # поиск закончился. 

		array << item	if f == 0				# Если старых данных в массиве нет f=0, 
																# то пишем в массив свои данные. Теперь есть.
		
	end 
end

def output_array arr
	puts '==============================='
	arr.each do |item|
		if item[2] == 0
			print ' - '
		else
			print ' + '
		end	
		puts "#{item[0]} - (#{item[2]}) #{item[1]}: #{item[3]}"
	end	
end	

def compare_arrays
	un = []
	uo = []
	# Сравним - размеры, а затем содержимое.
	arr_size = @arr.size
	arr_old_size = @arr_old.size

	# puts '   | '
	if arr_size > arr_old_size 
		puts "   | общее количество записей: УВЕЛИЧИЛОСЬ на #{arr_size - arr_old_size}"
		
	elsif arr_size < arr_old_size
		puts "   | Общее количество записей: уменьшилось на #{arr_old_size - arr_size}"
		
	elsif
		puts '   | Общее количество записей: не изменилось.'

	end
	comp_2 @arr, @arr_old, un, uo
	
	out_ar un, uo

	comp_all @arr, @arr_old

end

def comp_all n, o
	puts '   |'
	puts '   | Следующие записи имеют несовпадения:'
	n.each do |item_n|
		o.each do |item_o|
			if item_n[0] == item_o[0] && item_n[1] == item_o[1]

				if item_n[2] != item_o[2] || item_n[3] != item_o[3]
					puts "   | Old: #{item_o[0]+'/'+item_o[1]} = #{item_o[2]}: #{item_o[3]}"
					puts "   | Now: #{item_n[0]+'/'+item_n[1]} = #{item_n[2]}: #{item_n[3]}" 
					puts '   | '
				end
					
			end 
		end	
	end	
end



# ---------------------------------------------------------------------------
# Метод: Ищет записи в одном массиве (n) без пары в другом массиве (o). 
#   Результаты: уникальные записи из (n) -> un,          (o) -> uo 
def comp_2 n, o, un, uo
	n.each do |item_n|
		
		f = 0	# Нет пары							
		o.each do |item_o|
			if item_n[0] == item_o[0] && item_n[1] == item_o[1]
				f = 1 # Есть пара
			end	 	
		end

		if f == 0  # Нашёл запись без пары в NOW-массиве
			un << item_n
		end	

	end	

	o.each do |item_o|
		
		f = 0	# Нет пары							
		n.each do |item_n|
			if item_o[0] == item_n[0] && item_o[1] == item_n[1]
				f = 1 # Есть пара
			end	 	
		end

		if f == 0  # Нашёл запись без пары в OLD-массиве
			uo << item_o
		end	

	end	
end




def out_ar un, uo
	### puts un
	if un.size != 0
		puts '   | Появились новые записи:'
		un.each_with_index do |item, index|
			puts "   | #{index+1}. #{item}"
		end
	end
	### puts uo
	if uo.size != 0	
		puts '   | Исчезли старые записи:'
		uo.each_with_index do |item, index|
			puts "   | #{index+1}. #{item}"
		end
	end	
end