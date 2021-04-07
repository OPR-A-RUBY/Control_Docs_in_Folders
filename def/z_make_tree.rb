# make_tree

def make_tree
	puts '2__Создать папку и дерево файлов. Поместить данные в Хеш.'
	
	read_from_dir @folder_name, @folder_name		# Сформировать список файлов

	# view_files_hash	@tree												# Показать полученный список

end



# (01) =================================================================================
# Формируем список папок в заданной дтректории, с файлами и без            (РЕКУРСИВНЫЙ)
#                (папка и путь)  
def read_from_dir folder, path      # имя папки и путь к ней 
	d = Dir.children(folder)					# Получаем массив дочерних файлов
	
	@tree[path + '/'] = [] 						# По умолчанию в нашей папке пусто
	# И если так случиться, что в ней нет файлов и папок, то код ниже не выполнится
	# исключение файлы 'Thumbs.db', но их мы не обрабатываем. См. ниже.	

	Dir.chdir(folder) do							# Заходим в папку, чтобы там дейчствовать:
	
		d.each do |filename|						# Перебираем все файлы и папки в этой папке
			
			if Dir.exist?(filename) 			# этот файл - есть директория?
				# It is DIR
				path_cur = path + '/' + filename 

				read_from_dir filename, path_cur # тогда РЕКУРСИВНО за пускае себя с нов. парам.
				
			elsif File.exist?(filename)
				# It is file
				if filename != 'Thumbs.db'  # исключаем паразитов 'Thumbs.db' из учёта в список (!)
					
          path_cur = path + '/' 	
          
					@tree[path_cur] = @tree[path_cur] << filename # пишем параметры в хеш
				
				end
			end	
		end
	end  
end



# (02) =================================================================================
# Показать, хеш файлов полученный после полного прохода всех паппок
def view_files_hash hh

	hh.each do |key, value| 
			puts "#{key} \t\t #{value}"
	end

end



# (03) =================================================================================
# Получить параметры файла f и в виде массива вернуть из этого метода
def read_file_params f
	#                    acces          modefi         size     name
	@file_params = [File.atime(f), File.mtime(f), File.size(f), f]

end