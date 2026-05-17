require "faraday"
require "byebug"
class BuscarAcoesJob < ApplicationJob
  queue_as :acoes

  def perform(*args)
    acoes_busca.each do |sigla|
      preco_novo = buscar_acao(sigla)
      
      # Buscar a última ação salva (anterior) para comparação
      acao_anterior = Acao.where(sigla: sigla).order(data_busca: :desc).first
      
      # Criar nova ação com o preço atual
      nova_acao = Acao.create(sigla: sigla, preco: preco_novo, data_busca: Time.current)
      # debugger

      if acao_anterior.nil? || preco_novo < acao_anterior.preco
        begin
          NotificarAcaoCompreMailer.notificar_compra(
            acao: nova_acao,
            preco_atual: preco_novo,
            destinatario: 'lucaslap27@gmail.com'
          ).deliver_now
        rescue => e
          Rails.logger.error "Erro ao enviar email para #{sigla}: #{e.message}"
          # Continua o processamento mesmo se o email falhar
        end
      end
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
