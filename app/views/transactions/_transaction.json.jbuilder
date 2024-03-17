json.extract! transaction, :id, :name, :email, :number, :investment_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
