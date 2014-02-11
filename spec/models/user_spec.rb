require 'factory_girl_rails'

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
      @users = Array.new(8)
      emails = Array.new(8)
      @users.each do |s| 
        s =  FactoryGirl.build(:user)
        s.get_short_info_as_string
        emails.insert(i, s.email)
        i+=1
      end
      p emails.include?("user8@examle.com")
      expect(@users).to_not eq nil
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