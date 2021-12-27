class TransactionsController < ApplicationController
  def index
    current_user_person_categories = PersonCategory.where(person_id: current_user.people)
    @transactions = Transaction.where(person_category_id: current_user_person_categories)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.note_id = nil
    if @transaction.save
      flash[:notice] = 'Супер-класс, молодец'
      redirect_to transactions_path
    else
      render :new
    end
  end

  def edit
    @transaction = Transaction.find_by(id: params[:id])
  end

  def update
    @transaction = Transaction.find_by(id: params[:id])
    if @transaction.update(transaction_params)
      redirect_to transactions_path
    else
      render :edit
    end
  end

  def destroy
    @transaction = Transaction.find_by(id: params[:id])
    @transaction.destroy
    redirect_to transactions_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:money_amount,:important, :person_category_id)
  end

end
