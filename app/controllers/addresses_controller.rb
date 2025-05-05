class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]
  before_action :set_zip_code, only: %i[ create update ]
  before_action :load_states

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all.order(id: :desc)
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_path, status: :see_other, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.includes(:state, :zip_code).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def address_params
      ps = params.expect(address: [ :line_1, :line_2, :city, :state_id ]).
        merge({ zip_code: @zip_code || @address&.zip_code })
      Rails.logger.info("ps: #{ps}")
      ps
    end

    def load_states
      @states = State.all.order(:name)
    end

    def set_zip_code
      Rails.logger.info(params.inspect)
      code = params["address"].delete("zip_code.code")
      Rails.logger.info("code: #{code}")
      @zip_code = code.present? ? ZipCode.find_or_create_by!(code:) : @address&.zip_code
      Rails.logger.info(@zip_code)
    end
end
