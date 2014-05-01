# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    user nil
    provider "MyString"
    uid "MyString"
    oauth_token "MyString"
    oauth_secret "MyString"
    oauth_expires_at "2014-05-01 02:49:27"
  end
end
