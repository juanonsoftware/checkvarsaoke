class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.where(status: get_status).page(get_page_number).per(20)
    
    render json: {
      total_count: @transactions.total_count,
      total_pages: @transactions.total_pages,
      current_page: @transactions.current_page,
      data: @transactions
    }
  end

  def stats
    transactions = Transaction.group(:status).count
    transactions_ok = transactions[:ok] || 0
    transactions_nok = transactions[:nok] || 0
    total_amount = Transaction.where(status: :ok).sum(:amount)

    render json: { 
      transactions_ok: transactions_ok,
      transactions_nok: transactions_nok,
      total_amount: total_amount
     }
  end

  private

  def get_status
    status = params[:status].presence.downcase
    return status == 'ok'? :ok : :nok
  end

  def get_page_number
    page = params[:page].presence.to_i || 1
    return page < 0 ? 0 : page
  end
end