require 'rails_helper'

RSpec.describe 'Revenue' do
  it 'can return merchants ranked by total revenue' do
    create_list(:merchant, 4)
    
  end

end
