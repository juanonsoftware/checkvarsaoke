class TransactionService
  def self.save_transactions(new_transactions, online_file)
    # Save all transactions in a batch
    Transaction.transaction do
      new_transactions.each do |hash|
        transaction = Transaction.new(hash)
        transaction.online_file_id = online_file.id
        transaction.save!
      end 
    end

    # Update the online file status to 'processed'
    online_file.status = 'processed'
    online_file.save
  end
end