require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Welcome to Advisor Now') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:consult) { FactoryGirl.create(:consult) }
      before do

        FactoryGirl.create(:consult_membership, customer: user, consult: 
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.consults.each do |item|
          expect(page).to have_selector("asdfasd", text: 'hi john')
        end
      end
    end
  end
end
