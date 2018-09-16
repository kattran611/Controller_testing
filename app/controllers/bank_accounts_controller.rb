class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]

  def index
    @bank_accounts = current_user.bank_accounts
  end

  def show
  end

  def new
    @bank_account = current_user.bank_accounts.new
  end

  def edit
  end

  def create
    @bank_account = current_user.bank_accounts.new(bank_account_params)
    if @bank_account.save
      redirect_to @bank_account, notice: 'Bank account was successfully created'
    else
      render :new
    end
  end

  def update
    if @bank_account.update(bank_account_params)
      redirect_to @bank_account, notice: 'Bank account was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @bank_account.destroy
    redirect_to bank_accounts_url, notice: 'Bank account was successfully destroyed'
  end

  private
  def set_bank_account
    @bank_account = current_user.bank_accounts.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:title, :institution, :amount, :description, :active)
  end
end
