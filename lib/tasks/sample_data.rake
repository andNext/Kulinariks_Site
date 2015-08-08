namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    admin = User.create!(name: "Grey",
                         email: "thegoodest@yandex.ru",
                         password: "salomand",
                         password_confirmation: "salomand",
                         admin: true)

      admin.adts.create!(	about: "Срочно",
      					    cost: 40,
      						spare: "ТТ",
      						marka: "ваз",
      						city: "Волгоград")
 
  end
end