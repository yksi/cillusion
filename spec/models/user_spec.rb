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

  context "USER" do
    it "can create article" do
      @user = FactoryGirl.create(:user)
      @article = FactoryGirl.create(:article)
      @article.user = @user
    end
  end


end