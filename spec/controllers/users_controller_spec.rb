require 'factory_girl_rails'  

  describe UsersController do
    context "Controller test" do
      it "redirect after create" do
        user = FactoryGirl.create(:user)
        expect(response).to be_success
      end
    end
  end
