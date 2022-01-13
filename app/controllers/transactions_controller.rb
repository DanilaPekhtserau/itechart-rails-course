# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class TransactionsController < ApplicationController
  def index
    current_user_person_categories = PersonCategory.where(person_id: current_user.people)
    @transactions = Transaction.where(person_category_id: current_user_person_categories)
  end

  def importants
    @transactions = Transaction.where(important: true)
  end

  # rubocop:disable  Rails/Date
  def details_init
    @first_date = Date.today.beginning_of_month
    @second_date = Date.tomorrow
    categories, transacions = categories_transactions_declaration
    @debit_transactions = get_transactions_by_type(categories, transacions, true)
    @credit_transactions = get_transactions_by_type(categories, transacions, false)
    @debit_chart_data = get_chart_data_by_type(categories, transacions,true)
    @credit_chart_data = get_chart_data_by_type(categories, transacions, false)
    render :details
  end

  # rubocop:enable  Rails/Date
  def details
    valid_date(params)
    categories, transacions = categories_transactions_declaration
    @debit_transactions = get_transactions_by_type(categories, transacions, true)
    @credit_transactions = get_transactions_by_type(categories, transacions, false)
    @debit_chart_data = get_chart_data_by_type(categories, transacions,true)
    @credit_chart_data = get_chart_data_by_type(categories, transacions, false)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    add_note
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
    edit_note
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

  def categories_transactions_declaration
    categories = current_user.people.collect(&:categories).flatten.uniq
    transacions = transactions_filtering(@first_date, @second_date, Transaction.all)
    [categories, transacions]
  end

  def valid_date(params)
    if params[:first_date].present? && params[:second_date].present?
      @first_date = Date.parse(params[:first_date])
      @second_date = Date.parse(params[:second_date])
    else
      flash[:notice] = 'Укажите начальную и конечную дату'
      details_init
    end
  end

  def transaction_params
    params.require(:transaction).permit(:money_amount, :important, :person_category_id)
  end

  def note_params
    params.require(:transaction).permit(:body)
  end

  def add_note
    if note_params[:body].present?
      @transaction.note = Note.new(body: note_params[:body])
    else
      @transaction.note_id = nil
    end
  end

  def edit_note
    @transaction.note.update(note_params) if note_params[:body].present?
  end

  def transactions_filtering(start_date, end_date, transactions)
    result = transactions.where(created_at: start_date.to_date..end_date.to_date)
    result || []
  end

  def get_transactions_by_type(categories, transactions, debit = true)
    result = []
    categories.select{ |item| item.debit == debit }.each do |category|
      result += transactions.where(person_category_id: category.person_categories)
    end
    result
  end

  def get_chart_data_by_type(categories, transactions, debit = true)
    data = []
    categories.select{ |item| item.debit == debit }.each do |category|
      data += [[category.title, transactions.where(person_category_id: category.person_categories).sum(:money_amount)]]
    end
    data
  end
end
# rubocop:enable Metrics/ClassLength
