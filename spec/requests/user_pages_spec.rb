require 'spec_helper'

describe "User pages" do
  subject {page}


  describe "profile page" do
    let(:user) {FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it {should have_title(user.name)}
    it {should have_content(user.name)}
  end

  describe "signup page" do
      before {visit signup_path}
      it {should have_content('Sign up')}
      it {should have_title(full_title('Sign up'))}

      let(:submit) { "Create My Account" }

      describe "signup with valid information" do
        before do
          fill_in "Name", with: "Alex"
          fill_in "Email", with: "alex@gmail.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)

        end


        describe "after saving the user" do
          before {click_button submit}

          let(:user) { User.find_by(email: 'alex@gmail.com')}

          it {should have_title(user.name)}
          it {should have_link('Sign Out', href: signout_path)}
          it {should have_selector("div.alert.alert-success", text: 'Welcome')}

        end

      end

      describe "signup with invalid information" do
        it "should not create a user" do
          expect do
            click_button submit
          end.not_to change(User, :count)
        end
      end
  end
end
