require 'factory_bot'

FactoryBot.define do
  factory :user do
    nome { 'Ciccio' }

    factory :user_random do
      sequence(:nome) { |n| "User #{n}" }
      username {'dd'}
      cognome {'ww'}
      email {'f@f'}
      password {'weqasd'}
    end
    
    factory :user_random_admin do
      sequence(:nome) { |n| "User #{n}" }
      username {'ddadmin'}
      cognome {'ww'}
      email {'g@g'}
      password {'weqasd'}
      role {'admin'}
    end
  end
end