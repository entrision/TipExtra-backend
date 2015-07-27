ipad_user = User.create!(email: 'admin@tipextra.com', password: 't1p3xtr4!', first_name: 'Tip', last_name: 'Extra')
menu = Menu.create!(name: 'The Menu', user: ipad_user)

rc = Drink.create!(name: 'Rum & Coke', price: 600, menu: menu)
mr = Drink.create!(name: 'Gin Martini', price: 900, menu: menu)
bl = Drink.create!(name: 'Bud Light', price: 400, menu: menu)

i1 = Image.create!(image: File.open(Rails.root + 'spec/support/drink_images/rum_coke.jpg'))
i1.drink = rc
i1.save

i2 = Image.create!(image: File.open(Rails.root + 'spec/support/drink_images/martini.jpg'))
i2.drink = mr
i2.save

i3 = Image.create!(image: File.open(Rails.root + 'spec/support/drink_images/bud_light_bottle.jpg'))
i3.drink = bl
i3.save
