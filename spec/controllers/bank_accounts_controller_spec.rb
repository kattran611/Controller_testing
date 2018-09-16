require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  login_user

  let(:valid_attributes) {
    { institution: 'Chase',
      amount: 200,
      active: true
    }
  }

    let(:invalid_attributes) {
      {
        institution: '',
        amount: 200,
        active: true
      }
    }

  describe "GET #index" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :show, params: {id:bank_account.id}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :edit, params: {id: bank_account.id}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "creates with valid params" do
      it "creates a new Bank Account" do
        expect {
          post :create, params: {bank_account: valid_attributes}
        }.to change(BankAccount, :count).by(1)
      end

      it "redirects to the created bank_account" do
        post :create, params: {bank_account: valid_attributes}
        expect(response).to redirect_to(BankAccount.last)
      end
    end

    context "creates with invalid params" do
      it "does not create a new Bank Account" do
        expect {
          post :create, params: {bank_account: invalid_attributes}
        }.to change(BankAccount, :count).by(0)
      end

      it "redirect back to form" do
        post :create, params: {bank_account: invalid_attributes}
        expect(response).to be_successful
      end

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested bank_account" do
      bank_account = @user.bank_accounts.create! valid_attributes
      expect {
        delete :destroy, params: {id: bank_account.id}
      }.to change(BankAccount, :count).by(-1)
    end

    it "redirects to the bank_accounts list" do
      bank_account = @user.bank_accounts.create! valid_attributes
      delete :destroy, params: {id: bank_account.id}
      expect(response).to redirect_to(bank_accounts_url)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attr) {
        {amount: 500}
      }

      it "updates the bank_account" do
        bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: {id: bank_account.id, bank_account: new_attr}
        bank_account.reload
        expect(bank_account.amount).to eq(new_attr[:amount])
      end

      it "redirect to the bank account" do
        bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: {id: bank_account.id, bank_account: new_attr}
        expect(response).to redirect_to(bank_account)
      end
    end

    context "with invalid params" do
      it 'does not update the bank account' do
        bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: {id: bank_account.id, bank_account: invalid_attributes}
        bank_account.reload
        expect(bank_account.institution).to_not eq(invalid_attributes[:institution])
      end

      it "render out the form" do
        bank_account = @user.bank_accounts.create! valid_attributes
        put :update, params: {id: bank_account.id, bank_account: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

end
