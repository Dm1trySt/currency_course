require 'net/http'
require 'uri'
require 'rexml/document'

# Ссылка
URL = "http://www.cbr.ru/scripts/XML_daily.asp"

# Парсим сссылку и сохраняем полученный ответ
response = Net::HTTP.get_response(URI.parse(URL))

# Представляем файл в виде XML
doc = REXML::Document.new(response.body)

# В Valute ищем строчку ID , которая удовлетворят нашему запросу,
# а именно id R01010 или id R01239
doc.each_element('ValCurs/Valute [@ID = "R01235" or @ID = "R01239"]') do |element|

  # .get_text - возвращает текст
  name = element.get_text('Name')
  value = element.get_text('Value')

  # Вывод
  puts "#{name}: #{value} руб."
end

