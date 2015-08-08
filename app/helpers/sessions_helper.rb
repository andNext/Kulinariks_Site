module SessionsHelper
	#вход пользователя, создание сессии
	def sign_in(user)
		#создание нового токена
	    remember_token = User.new_remember_token
	    #помещаем зашифрованный токен в куки браузера(исчезают через 20лет)
	    cookies.permanent[:remember_token] = remember_token
	    #сохраняем зашифрованный токен в базе данных
	    user.update_attribute(:remember_token, User.encrypt(remember_token))
	    #устанавливаем текущего пользователя равным данному пользователю
	    self.current_user = user
  end

  #выход пользователя, удаление cookies
    def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  #Определение назначения current_user
  def current_user=(user)
    	@current_user = user
  end

  #авторизирован ли данный пользователь
  def current_user?(user)
    user == current_user
  end

  	#Поиск текущего пользователя с помощью remember_token
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  #проверка, авторизировался ли пользователь?
  def signed_in?
    !current_user.nil?
  end

  #сохраняет страницу, а после авторизации, возвращает нас к ней
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  #сохраняет страницу
  def store_location
    session[:return_to] = request.url if request.get?
  end


  #требует от посетителя входа
  def signed_in_user
          unless signed_in?
          store_location
          redirect_to signin_url, notice: "Пожалуйста, авторизируйтесь!"
        end 
      end 
      
end
