require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 25.99
      )
    end
  end

  scenario "visit home, click add to cart update render on my cart" do
    # ACT
    visit root_path
    first('Button').click
    save_screenshot('jungle1.png')
    expect(page).to have_text 'My Cart (1)'

  end
end
