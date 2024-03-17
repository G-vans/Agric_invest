class InvestmentsController < ApplicationController
  before_action :set_investment, only: %i[ show edit update destroy ]

  # GET /investments or /investments.json
  def index
    @investments = Investment.all
  end

  # GET /investments/1 or /investments/1.json
  def show
  end

  # GET /investments/new
  def new
    @investment = Investment.new
  end

  # GET /investments/1/edit
  def edit
  end

  # POST /investments or /investments.json
  def create
    @investment = Investment.new(investment_params)

    respond_to do |format|
      if @investment.save
        format.html { redirect_to investment_url(@investment), notice: "Investment was successfully created." }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investments/1 or /investments/1.json
  def update
    respond_to do |format|
      if @investment.update(investment_params)
        format.html { redirect_to investment_url(@investment), notice: "Investment was successfully updated." }
        format.json { render :show, status: :ok, location: @investment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investments/1 or /investments/1.json
  def destroy
    @investment.destroy!

    respond_to do |format|
      format.html { redirect_to investments_url, notice: "Investment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment
      @investment = Investment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment).permit(:title, :description, :amount, :image_url)
    end
end
