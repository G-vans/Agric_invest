json.extract! investment, :id, :title, :description, :amount, :image_url, :created_at, :updated_at
json.url investment_url(investment, format: :json)
