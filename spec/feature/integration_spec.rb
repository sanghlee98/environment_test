# location: spec/feature/integration_spec.rb
require 'rails_helper'

def select_date(date, options = {})
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
    year, month, day = date.split(',')
    select year,  :from => "#{base_id}_1i"
    select month, :from => "#{base_id}_2i"
    select day,   :from => "#{base_id}_3i"
  end

RSpec.describe 'Creating a book', type: :feature do
    scenario 'valid inputs' do
        visit new_book_path
        fill_in 'Title', with: 'harry potter'
        fill_in 'Author', with: 'J.K.Rowling'
        fill_in 'Price', with: '100.00'
        select_date("1997,June,26", :from => "Published date")
        click_on 'Create Book'
        visit books_path
        expect(page).to have_content('harry potter')
    end
end
