require 'factory_girl_rails'
require 'faker'

describe User do
  it "is valid with my info" do
    user = User.new(email: "embox@ukr.net", first_name: "Vitaliy", last_name: "Krushelnitskiy", age: 18, sex: true)
    user.save
    expect(user.email).to eq("embox@ukr.net")
  end

  context "method with ? test" do
    it "ALL FIELDS ARE FILLed" do
      test_user = User.new(first_name: "John", last_name: "Carter", age: 18, hometown: "New York", sex: true, email: "john@carter.com")
      expect(test_user).to be_is_all_fields_filled 
    end
  end

  context "Factory" do
    it "makes 8 users" do
      i = 0
      8.times do 
        User.new do |t|
          t.first_name = Faker::Name.first_name
          t.last_name = Faker::Name.last_name
          t.email = Faker::Internet.email
          t.save
          t.get_short_info_as_string          
        end
        i+=1
      end
      expect(i).to eq 8
    end
  end

  context "USER CAN CREATE POSTS" do
    it "must be valid" do
      user_with_articles = FactoryGirl.build(:user_with_articles)
      # user_with_articles do |article|
      #   article.print_info
      # end
      # user_with_articles.articles.length
    end
  end

  end

end