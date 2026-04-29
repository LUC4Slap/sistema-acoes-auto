require "byebug"
class AcaosController < ApplicationController
  before_action :set_acao, only: %i[ show edit update destroy buscar_preco ]

  # GET /acaos or /acaos.json
  def index
    # Retorna a ação mais recente de cada sigla (agrupadas)
    @acaos = Acao.where(id: Acao.select("MAX(id)")
                                .group(:sigla))
                 .order(data_busca: :desc)
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

  # POST /acaos/1/buscar_preco
  def buscar_preco
    # debugger
    preco = buscar_acao(@acao.sigla)

    if preco
      @acao = Acao.create(sigla: @acao.sigla, preco: preco, data_busca: Time.current)
      redirect_to @acao, notice: "Preço atualizado com sucesso! Novo preço: R$ #{ActionController::Base.helpers.number_to_currency(preco, unit: "", separator: ",", delimiter: ".")}"
    else
      redirect_to @acao, alert: "Não foi possível buscar o preço da ação. Verifique a configuração do token da API."
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

    # Buscar preço da ação na API
    def buscar_acao(sigla)
      token = Configuracao.token_api

      unless token
        Rails.logger.error "TOKEN_API não encontrado. Configure o token em Configurações."
        return nil
      end

      begin
        response = Faraday.get("https://brapi.dev/api/quote/#{sigla}") do |req|
          req.headers['Authorization'] = "Bearer #{token}"
        end
        JSON.parse(response.body)["results"][0]["regularMarketPrice"]
      rescue => e
        Rails.logger.error "Erro ao buscar preço da ação #{sigla}: #{e.message}"
        nil
      end
    end
end
