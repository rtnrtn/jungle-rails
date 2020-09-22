require 'rails_helper'

RSpec.feature "Visitor adds item to cart from home page", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click 'Add to Cart' and their cart increases by one" do
    # ACT
    visit root_path
    click_on('Add', match: :first)  
    find_link('My Cart')

    # DEBUG 
    # save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end

end
