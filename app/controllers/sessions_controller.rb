class SessionsController < ApplicationController

	#страница для новой сессии (вход)
	def new
	end

	#создание новой сессии
	#проверка наличия пользователя, проверка пароля
	def create
 		user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
    		#введенные данные верны, перенаправление на страницу пользователя
    		sign_in user
      		redirect_back_or user
  		else
   			#создание сообщения об ошибке(исчезает после допол. запроса) 
   			#и перезагрузка страницы
   			flash.now[:error] = 'Неверные email/пароль' 
      		render 'new'
  		end
	end

	#удаление сессии (выход)
	def destroy
		sign_out
    	redirect_to root_url
	end
end
