# safe_info

def safe_info
	puts '3__Сохранить информацию из Хеша в файл.'

	# Создать папку listings для хранения файлов с деревом (Если такой дир-и здесь нет)
	list_folder = 'listings'
	Dir.mkdir(list_folder) if !Dir.exist?(list_folder) 

	dirs = @tree.size.to_s
	files = 0
	@tree.each { |key, value| files += value.size }
	files = files.to_s

	# Создать уникальное имя файла (по "сейчас" дате и времени) с расширением .list	
	listing_file_l = Time.now.strftime '%Y-%m-%d__%H:%M:%S__(D-' + dirs + '_f-' + files + ')_.list' 
	listing_file_h = Time.now.strftime '%Y-%m-%d__%H:%M:%S__(D-' + dirs + '_f-' + files + ')_.html' 
	puts '   | file_name: ' + listing_file_l
	puts '   | file_name: ' + listing_file_h

	# Дальше работаем в дирктории 'listings' (Заходим в блок do-end)
	Dir.chdir(list_folder) do
	
		# Открываем файл для записи с уникальным именем, созданным выше
		output_file_list = File.open(listing_file_l, "w") 
		output_file_html = File.open(listing_file_h, "w") 
		# Запись служебной информации (имя файла, количество объектов)
		output_file_list.write "My name: #{listing_file_l}\n"
		output_file_list.write "I'm has: #{dirs} Dirs, #{files} files\n"
		output_file_list.write "----------------------------------\n"

		output_file_html.write "<h3> My name: #{listing_file_h} </h3>"
		output_file_html.write "<h3> I'm has: #{dirs} Dirs, and #{files} files </h3>"
		output_file_html.write "<h4>----------------------------------</h4>"

		# Перебираем весь Хеш @files и пишем данные в файл (разделитель табуляция)
		@tree.each do |key, value|
			f = '' 
			value.each do |file|
				f = f + ', ' + file
			end
			output_file_list.write "#{key}\t#{f}\n"
			output_file_html.write "#{key}: = #{f}<br/>"
		end

		# Кончился Хеш. Закрываем файл.
		output_file_list.close
		output_file_html.close

		# Закрываем блок. Возвращаемся в исходную директорию
	end

end

def read_info
	# Получить информацию из файла в Хеша.

	# Получить имя файла OLD_.list	
	o_file = 'OLD_.list' 
	# puts '   | file_name: ' + o_file

	# Дальше работаем в дирктории 'listings' (Заходим в блок do-end)
	l_dir = 'listings'
	Dir.chdir(l_dir) do
	
		# Открываем файл для чтения со специальным именем, см выше
		input_file = File.open(o_file, "r") 
		# Пропускаем служебную информацию 
		3.times { line = input_file.gets }

		while (line = input_file.gets)
		# Записываем в Хеш @tree_o информацию из файла
			arr0 = line.chomp.split("\t")
			if arr0[1] != nil
				arr = arr0[1].split(', ')
				arr.delete_at(0)
			else
				arr = []
			end	
 # print arr0[0]				
 # puts arr.inspect
			@tree_old[arr0[0]] = arr
		end
			
		# Кончился файл. Закрываем файл.
		input_file.close

		# Закрываем блок. Возвращаемся в исходную директорию
	end
end
