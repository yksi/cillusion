require 'factory_girl_rails'  

  describe UsersController do
    context "Controller test" do
      it "redirect after create" do
        user = FactoryGirl.create(:user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
