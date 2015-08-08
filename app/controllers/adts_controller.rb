#
class AdtsController < ApplicationController
  #предфильтры для действий destroy и create
  before_action :signed_in_user, only: [:create, :destroy, :edit]
  before_action :correct_user,   only: :destroy

  def index
  end

  def create
    @adt = current_user.adts.build(adt_params)
    if @adt.save
      flash[:success] = "Вы разместили объявление"
      redirect_to add_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  #удаление объявления
  def destroy
    @adt.destroy
    redirect_to add_path
  end

  def edit
    @adt  = current_user.adts.build
    @feed_items= current_user.feed.paginate(page: params[:page])
  end

  private

    #параметры объявления
    def adt_params
      params.require(:adt).permit(:about)
    end

    #проверки того, что текущий пользователь имеет микросообщение с данным id.
    def correct_user
      @adt = current_user.adts.find_by(id: params[:id])
      redirect_to root_url if @adt.nil?
    end
end