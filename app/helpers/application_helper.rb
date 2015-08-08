module ApplicationHelper
	#Хелпер для решения проблемы с отсутствующим заголовком страницы
	#В случае если кастомный заголовок не определен, будет возвращен базовый заголовок
	#в противном будет возвращен базовый заголовок с вертикальной чертой перед кастомной частью заголовка
	def full_title(page_title)
		base_title ="Кулинарикс"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
