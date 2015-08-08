class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
  	#добавляет колонку password_digest к таблице users
    add_column :users, :password_digest, :string
  end
end
