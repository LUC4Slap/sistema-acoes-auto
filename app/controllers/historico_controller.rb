class HistoricoController < ApplicationController
  def index
    @historico = Acao.where(sigla: params[:sigla]).order(data_busca: :desc)
  end
end
