require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
  
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

  scenario "They see product details" do
    # ACT
    visit root_path
    click_on('Details »', match: :first)
    # sleep(1) # this will give the page enough time to load the element as well as the product image but can also do the line below to have it wait for this element before continuing: 
    find('section.products-show')

    # DEBUG 
    # save_screenshot

    # VERIFY
    expect(page).to have_css 'section.products-show', count: 1
  end

end
