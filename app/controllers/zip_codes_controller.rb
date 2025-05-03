class ZipCodesController < ApplicationController
  before_action :set_zip_code, only: %i[ show edit update destroy ]

  # GET /zip_codes or /zip_codes.json
  def index
    @zip_codes = ZipCode.all
  end

  # GET /zip_codes/1 or /zip_codes/1.json
  def show
  end

  # GET /zip_codes/new
  def new
    @zip_code = ZipCode.new
  end

  # GET /zip_codes/1/edit
  def edit
  end

  # POST /zip_codes or /zip_codes.json
  def create
    @zip_code = ZipCode.new(zip_code_params)

    respond_to do |format|
      if @zip_code.save
        format.html { redirect_to @zip_code, notice: "Zip code was successfully created." }
        format.json { render :show, status: :created, location: @zip_code }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @zip_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zip_codes/1 or /zip_codes/1.json
  def update
    respond_to do |format|
      if @zip_code.update(zip_code_params)
        format.html { redirect_to @zip_code, notice: "Zip code was successfully updated." }
        format.json { render :show, status: :ok, location: @zip_code }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @zip_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zip_codes/1 or /zip_codes/1.json
  def destroy
    @zip_code.destroy!

    respond_to do |format|
      format.html { redirect_to zip_codes_path, status: :see_other, notice: "Zip code was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zip_code
      @zip_code = ZipCode.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def zip_code_params
      params.expect(zip_code: [ :code ])
    end
end
