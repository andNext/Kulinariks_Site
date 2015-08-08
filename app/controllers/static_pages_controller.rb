class StaticPagesController < ApplicationController
	#основные действия

  #главная страница
  def home
  
      #@adt  = current_user.adts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])

     @all_user = User.all
     #@adt  = @all_user.adts.build
     #@feed_items = @all_user.feed.paginate(page: params[:page])


  end

  #помощь
  def help
  end

  #о проекте
  def about
  end

  #контакты
  def contact
  end
end
