class AcaosController < ApplicationController
  before_action :set_acao, only: %i[ show edit update destroy ]

  # GET /acaos or /acaos.json
  def index
    # Agrupa por sigla e retorna apenas a mais recente de cada grupo
    @acaos = Acao.all.group_by(&:sigla).values.map { |acoes| acoes.max_by(&:data_busca) }
  end

  # GET /acaos/1 or /acaos/1.json
  def show
  end

  # GET /acaos/new
  def new
    @acao = Acao.new
  end

  # GET /acaos/1/edit
  def edit
  end

  # POST /acaos or /acaos.json
  def create
    @acao = Acao.new(acao_params)

    respond_to do |format|
      if @acao.save
        format.html { redirect_to @acao, notice: "Acao was successfully created." }
        format.json { render :show, status: :created, location: @acao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @acao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acaos/1 or /acaos/1.json
  def update
    respond_to do |format|
      if @acao.update(acao_params)
        format.html { redirect_to @acao, notice: "Acao was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @acao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @acao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acaos/1 or /acaos/1.json
  def destroy
    @acao.destroy!

    respond_to do |format|
      format.html { redirect_to acaos_path, notice: "Acao was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acao
      @acao = Acao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def acao_params
      params.require(:acao).permit(:sigla, :preco, :data_busca)
    end
end
