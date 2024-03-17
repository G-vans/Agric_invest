class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:index, :send_payout, :process_payout]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @investments = Investment.all
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
  
    respond_to do |format|
      if @transaction.save
        chimoney_response = send_money_via_chimoney(@transaction)
  
        # Extract the paymentLink from the Chimoney response
        payment_link = JSON.parse(chimoney_response.body)["data"]["paymentLink"]
  
        format.html { redirect_to invest_success_url(payment_link: payment_link), notice: "Transaction was successfully created." }
        format.json { render json: chimoney_response.body, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  def send_payout
    @transaction = Transaction.find(params[:id])
  end

  def process_payout
    require 'uri'
    require 'net/http'

    url = URI("https://api-v2-sandbox.chimoney.io/v0.2/payouts/chimoney")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    @transaction = Transaction.find(params[:id])
    phone = @transaction.number
    phone_number = "+#{phone}"

    email = @transaction.email

    amount = params[:amount]

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["X-API-KEY"] = 'bdf360cd6f2b0435d90395368225b5cde1cd376466c281c1af2b1c707a41205e'
    request.body = "{\"chimoneys\":[{\"email\":\"#{email}\",\"phone\":\"#{phone_number}\",\"valueInUSD\":#{amount}}]}"

    response = http.request(request)

    # Handle the response as needed

    redirect_to @transaction, notice: 'Payout sent successfully'
  end

  def success
    
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def send_sms
    # Set your app credentials
    username = "valeria"
      apikey = "a91bf656d1ef72542dcbfe7b650e1263c08616ca9a71bf32f304699541cf86ce"
    
      # Initialize the SDK
      @AT = AfricasTalking::Initialize.new(username, apikey)
    
      sms = @AT.sms
    # Retrieve the Current user's details from the database
    phone_number = @transaction.number
      to = "+#{phone_number}"
    
      # Send the welcome message
      message = "Welcome #{@transaction.name} to Nafaka! Thank you for investing in Wanjohis project. Expect SMS updates on the status. Stay tuned and have a great day!"
      
      # Set your shortCode or senderId
      # from = "Vaxx-Alerts"
    
      options = {
        "to" => to,
        "message" => message
        # "from" => from
      }
    
      begin
        # Send the SMS and retrieve the response
        response = sms.send(options)
    
        # Log success or any necessary information
        Rails.logger.info "SMS sent successfully"
      rescue AfricasTalking::AfricasTalkingException => ex
        # Log error or any necessary information
        Rails.logger.error "Failed to send SMS: #{ex.message}"
      end
      
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:name, :email, :number, :investment_id)
    end

   # Initiate chimoney payment
# Initiate chimoney payment
def send_money_via_chimoney(transaction)
  require 'uri'
  require 'net/http'

  url = URI("https://api-v2-sandbox.chimoney.io/v0.2/payouts/chimoney")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  phone = transaction.number
  phone_number = "+#{phone}"
  amount = transaction.investment.amount
  email = transaction.email

  request = Net::HTTP::Post.new(url)
  request["accept"] = 'application/json'
  request["content-type"] = 'application/json'
  request["X-API-KEY"] = 'bdf360cd6f2b0435d90395368225b5cde1cd376466c281c1af2b1c707a41205e'

  # Update the request body to include payerEmail
  request.body = "{\"chimoneys\":[{\"payerEmail\":\"#{email}\",\"valueInUSD\":#{amount}}]}"

  # Perform the HTTP request and return the response
  http.request(request)
end

end
