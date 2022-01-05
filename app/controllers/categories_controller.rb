# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :redirect_to_sign_up
  before_action :require_needed_signed_user, only: %i[edit destroy update]
  def index
    @categories = current_user.people.collect(&:categories).flatten.uniq
  end

  # rubocop:disable  Rails/Date
  def details_init
    @category = Category.find_by(id: params[:id])
    @first_date = Date.today.beginning_of_month
    @second_date = Date.tomorrow
    @transactions = transactions_filtering(@first_date, @second_date, current_category_transactions)
    render :details
  end
  # rubocop:enable  Rails/Date

  def details
    @category = Category.find_by(id: params[:id])
    if params[:first_date].present? && params[:second_date].present?
      @first_date = Date.parse(params[:first_date])
      @second_date = Date.parse(params[:second_date])
    else
      flash[:notice] = 'Укажите начальную и конечную дату'
      details_init
    end
    @transactions = transactions_filtering(@first_date, @second_date, current_category_transactions)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    params[:category][:id].each do |person_id|
      @category.people << Person.find(person_id) unless person_id.empty?
    end
    if @category.save
      redirect_to categories_path
    else
      flash[:notice] = 'Не удалось сохранить категорию'
    end
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    if @category.people.length < 2
      redirect_to categories_path
      flash[:notice] = 'Невозможно удалить последнюю категорию пользователя'
      return
    end
    redirect_to categories_path if @category.destroy
  end

  private

  def current_category_transactions
    Transaction.where(person_category_id: PersonCategory.where(category_id: @category.id))
  end

  # rubocop:disable Metrics/AbcSize
  def transactions_filtering(start_date, end_date, transactions)
    result = transactions.where(created_at: start_date.to_date..end_date.to_date)
    result = result.where.not(note: nil) if params[:only_with_note].present? && params[:only_with_note] == '1'
    if params[:only_with_important].present? && params[:only_with_important] == '1'
      result = result.where(important: true)
    end
    result || []
  end
  # rubocop:enable Metrics/AbcSize

  def category_params
    params.require(:category).permit(:title, :debit)
  end

  def require_needed_signed_user
    category = Category.find(params[:id])
    return if current_user == category.people.first.user

    redirect_to root_path
  end
end
