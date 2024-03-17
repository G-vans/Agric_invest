class InvestController < ApplicationController

  EXCHANGE_RATE_USD_TO_KES = 126.6014
  def index
    
    @currency = params[:currency] || 'USD'
  @prices = Investment.all.map do |product|
    product.amount * EXCHANGE_RATE_USD_TO_KES
  end
  end
  def success
    @payment_link = params[:payment_link]
  end

  require 'rest-client'

    def stkpush
        phoneNumber = params[:phoneNumber]
        amount = "1"
        url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
        timestamp = "#{Time.now.strftime "%Y%m%d%H%M%S"}"
        business_short_code = ENV["MPESA_SHORTCODE"]
        password = Base64.strict_encode64("#{business_short_code}#{ENV["MPESA_PASSKEY"]}#{timestamp}")
        payload = {
        'BusinessShortCode': business_short_code,
        'Password': password,
        'Timestamp': timestamp,
        'TransactionType': "CustomerPayBillOnline",
        'Amount': amount,
        'PartyA': phoneNumber,
        'PartyB': business_short_code,
        'PhoneNumber': phoneNumber,
        'CallBackURL': "#{ENV["CALLBACK_URL"]}/callback_url",
        'AccountReference': 'Codearn',
        'TransactionDesc': "Payment for Codearn premium"
        }.to_json

        headers = {
        Content_type: 'application/json',
        Authorization: "Bearer #{get_access_token}"
        }

        response = RestClient::Request.new({
        method: :post,
        url: url,
        payload: payload,
        headers: headers
        }).execute do |response, request|
        case response.code
        when 500
        [ :error, JSON.parse(response.to_str) ]
        when 400
        [ :error, JSON.parse(response.to_str) ]
        when 200
        [ :success, JSON.parse(response.to_str) ]
        else
        fail "Invalid response #{response.to_str} received."
        end
        end
        render json: response
        # format.html { render :success }
        # format.json { render response }
    end

  def send_sms
    # Set your app credentials
    # username = "valeria"
    #   apikey = "a91bf656d1ef72542dcbfe7b650e1263c08616ca9a71bf32f304699541cf86ce"
      username = "Gvans"
      apikey = "f19a53547997899dd02428a43499c58a3eb7a5c9aabbf3d1ea4e93d8bfc517ab"
    
      # Initialize the SDK
      @AT = AfricasTalking::Initialize.new(username, apikey)
    
      sms = @AT.sms
    # Retrieve the Current user's details from the database

    to = params[:phone_number]
    
      # Send the welcome message
      message = "Welcome to Nafaka! Thank you for investing in Wanjohi's project. Expect SMS updates on the status. Stay tuned and have a great day!"
      
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

    private

    def generate_access_token_request
        @url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
        @consumer_key = ENV['MPESA_CONSUMER_KEY']
        @consumer_secret = ENV['MPESA_CONSUMER_SECRET']
        @userpass = Base64::strict_encode64("#{@consumer_key}:#{@consumer_secret}")
        headers = {
            Authorization: "Bearer #{@userpass}"
        }
        res = RestClient::Request.execute( url: @url, method: :get, headers: {
            Authorization: "Basic #{@userpass}"
        })
        res
    end

    def get_access_token
        res = generate_access_token_request()
        if res.code != 200
        r = generate_access_token_request()
        if res.code != 200
        raise MpesaError('Unable to generate access token')
        end
        end
        body = JSON.parse(res, { symbolize_names: true })
        token = body[:access_token]
        AccessToken.destroy_all()
        AccessToken.create!(token: token)
        token
    end
end
