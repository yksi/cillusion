require "faker"

FactoryGirl.define do

  factory :article do 
    theme Faker::Name.first_name
    content Faker::Lorem.paragraphs
    date Time.now + 1.day
    created_at Time.now
  end

  factory :user do 
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    age "18".to_i
    sequence(:email) { |n| "user#{n}@examle.com"}
    password "123123123"
    
    factory :user_with_articles do    
  
        ignore do
          articles_count 5
        end

        after(:create) do |user, evaluator|
          create_list(:article, evaluator.articles_count, user_id: user.id)
        end
    end
  

  end

  
  


  
end 