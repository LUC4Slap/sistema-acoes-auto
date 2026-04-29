require "faraday"
require "byebug"
class BuscarAcoesJob < ApplicationJob
  queue_as :acoes

  def perform(*args)
    acoes_busca.each do |sigla|
      preco = buscar_acao(sigla)
      Acao.create(sigla: sigla, preco: preco, data_busca: Time.current)
    end
  end

  private

  def acoes_busca
    # Buscar todas as ações cadastradas no banco de dados
    @acoes =  Acao.all.group_by(&:sigla).values.map { |acoes| acoes.max_by(&:data_busca) }.pluck(:sigla)
  end

  def buscar_acao(sigla)
    token = Configuracao.token_api
    
    unless token
      Rails.logger.error "TOKEN_API não encontrado. Configure o token em Configurações."
      return nil
    end

    response = Faraday.get("https://brapi.dev/api/quote/#{sigla}") do |req|
      req.headers['Authorization'] = "Bearer #{token}"
    end
    JSON.parse(response.body)["results"][0]["regularMarketPrice"]
  end
end
