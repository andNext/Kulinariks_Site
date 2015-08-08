class UsersController < ApplicationController
	#фильтры перед действиями требующий от посетителя входа
	#(защита от несанкционированного доступа)
  	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  	before_action :correct_user,   only: [:edit, :update]
  	before_action :admin_user,     only: :destroy # только для админов

  	#показ страницы пользователя
  	def show
   		@user = User.find(params[:id])
      @adts = @user.adts.paginate(page: params[:page])
 	end

 	#просмотр зарегистрированных пользователей(только для авторизованных)
 	#пагинация пользователей
 	def index
    	@users = User.paginate(page: params[:page])
  	end

 	#создание нового пользователяs
 	def create
	    @user = User.new(user_params)    # Not the final implementation!
	    if @user.save
	      # Успешное прохождение валидации и уникальности(успешное сохранение)
	      # Создание флэш сообщения об успешной регистрации
	      # перенаправление на страницу пользователя
	      sign_in @user
	      flash[:success] = "Вы успешно зарегистрировались!"
	      redirect_to @user
	    else
	      #в случае неудачного сохранения повторная загрузка страницы регистрации
	      render 'new'
	    end
  	end

  	#страница для создания нового пользователя (регистрация)
  	def new
  		@user=User.new
  	end

  	#редактирование пользователя
  	def edit
 	end

 	#обновление данных пользователя после редактирования
 	def update
   		#при успешно введенных данных выводится сообщение
    	#а также происходит редирект на страницу пользователя
    	#при неудачном перезагружает данную страницу
    	if @user.update_attributes(user_params)
      		flash[:success] = "Профиль успешно обновлён!"
     		redirect_to @user
    	else
      		render 'edit'
    	end
  	end

  	#определяет является ли этот пользователь администратором
  	def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  	#удаление пользователя(для администрации)
  	def destroy
    	User.find(params[:id]).destroy
    	flash[:success] = "Пользователь успешно удален."
    	redirect_to users_url
 	  end


  	private
	  	# версия хэша params содержащего только разрешенные атрибуты
	  	def user_params
	      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
	 	end

    #предфильтры
    #защита от изменений edit/update страниц 
      def correct_user
          @user = User.find(params[:id])
          redirect_to(root_url) unless current_user?(@user)
    end
end