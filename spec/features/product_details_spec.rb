require 'rails_helper'

RSpec.feature "navigation from home to ProductDetails page", type: :feature, js: true do
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
  scenario "select and click for single item" do
    # ACT
    visit root_path
    # DEBUG / VERIFY
    
    page.first('article.product a').click
    expect(page).to have_css '.product-detail'
    
    # save_screenshot
  end
end
