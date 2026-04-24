class ConfiguracoesController < ApplicationController
  def index
    @token_api = Configuracao.get('token_api')
  end

  def update
    if Configuracao.set('token_api', params[:token_api])
      redirect_to configuracoes_path, notice: "Token da API atualizado com sucesso!"
    else
      redirect_to configuracoes_path, alert: "Erro ao atualizar o token."
    end
  end
end
