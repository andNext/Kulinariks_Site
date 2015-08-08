class Adt < ActiveRecord::Base
	#Микросообщение пренадлежит пользователю
	belongs_to :user
	#Упорядочивание микросообщений с default_scope.(по убыванию)
	default_scope -> { order('created_at DESC') }

	#валидация модели данных adts
	validates :about, presence: true, length: { maximum: 250 }
	#validates :spare, presence: false, length: { maximum: 25 }
	#validates :marka, presence: false, length: { maximum: 25 }
	#validates :city, presence: false, length: { maximum: 25 }
	validates :user_id, presence: true
	#validates :cost, presence: false

end
