require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o e-mail' do
      u = User.new(name: 'Júlia Rezende', email: 'juliarznd@gmail.com')

      result = u.description

      expect(result).to eq('Júlia Rezende <juliarznd@gmail.com>')
    end
    
  end
end
