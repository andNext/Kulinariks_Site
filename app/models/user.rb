class User < ActiveRecord::Base
	#функции обратного вызова
	#перед сохранение поля email в нижний регистр
	before_save{self.email=email.downcase}
	#перед созданием сессии создание токена пользователя
	before_create :create_remember_token

	# Пользователь имеет_много микросообщений. 
	# объявления уничтожаются при уничтожении самого пользователя
	has_many :adts, dependent: :destroy

	#валидация наличия ресурсов
	validates :name, presence: true, length: {maximum: 16}
	#константа валидация email(кастом)
	VALID_EMAIL_REGEX = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
	validates :email, presence: true, format:{with:VALID_EMAIL_REGEX}, 
			uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: {minimum: 6 } #валидация пароля,минимум 6 символов

	#генерация рандомного незашифрованного токена
	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	#шифрование токена с помощью SHA1 - хэширующего алгоритма 
  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
 	end

 	#поток объявлений
 	def feed
    	# Это предварительное решение. См. полную реализацию в "Following users".
    	Adt.where("user_id = ?", id)
  	end

  	private
	  	#создание пользовательского токена с шифрованием
	    def create_remember_token
	    	#шифрование токена и присвоение атрибуту пользователя 
	    	self.remember_token = User.encrypt(User.new_remember_token)
	    end
end
