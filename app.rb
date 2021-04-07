# Программа сбора информации о файлах
require './helper.rb'

@tree = {}
@tree_old = {}
@file_params = []
@arr = []
@arr_old = []

system('clear')
puts 'Запуск приложения.'
puts

### '1__Query folder adress'
get_folder_name
puts "   ! Готово: Папака для чтения: #{@folder_name}"
puts

### '2__Make folders and files tree. Create data hach'
make_tree
puts '   ! Готово: Данные получены. Создано дерево файлов.'
puts

### '3__Safe hach information to file'
# safe_info
puts '   ! Готово: Дерево файлов сохранено на диск.'
puts

### '4__Analiz informations from hach'
analizing_info
puts '   ! Готово: Анализ данных завершен.'
puts

### '5__Display rezult'
display_rezult
puts '   ! Готово: Выведен результат анализа'
puts 

