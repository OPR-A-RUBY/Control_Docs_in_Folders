# make_tree

def make_tree
	puts '2__Создать папку и дерево файлов. Поместить данные в Хеш.'
	
	read_from_dir @folder_name, @folder_name		# Сформировать список файлов

	# view_files_hash															# Показать полученный список

end



# (01) =================================================================================
# Формируем список файлов в заданной дтректории                            (РЕКУРСИВНЫЙ)
#                (папка и путь)  
def read_from_dir folder, path      # имя папки и путь к ней 
	d = Dir.children(folder)					# Получаем массив дочерних файлов

	Dir.chdir(folder) do							# Заходим в папку, чтобы там делать:
		
		d.each do |filename|						# Перебираем все файлы в папке

			path_cur = path + '/' + filename	# Путь + / + файл = уникальный ключ (для хеша) 

			if Dir.exist?(filename) 			# этот файл - есть директория?
				# It is DIR
				read_from_dir filename, path_cur # тогда РЕКУРСИВНО за пускае себя с нов. парам.
			else
				# It is file
				if filename != 'Thumbs.db'  # исключаем паразитов 'Thumbs.db' из учёта в список (!)
				
					read_file_params filename # запрашиваем параметры файла

					@files[path_cur] = @file_params  # пишем параметры в хеш
				
				end

			end

		end

	end  
end




# (02) =================================================================================
# Показать, хеш файлов полученный после полного прохода всех паппок
def view_files_hash

	@files.each do |key, value| 
			puts "#{value} = from = #{key}"
	end

end



# (03) =================================================================================
# Получить параметры файла f и в виде массива вернуть из этого метода
def read_file_params f
	#                    acces          modefi         size     name
	@file_params = [File.atime(f), File.mtime(f), File.size(f), f]

end