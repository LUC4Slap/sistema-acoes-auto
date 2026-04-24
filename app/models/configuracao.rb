class Configuracao < ApplicationRecord
  validates :chave, presence: true, uniqueness: true
  
  # Método de classe para pegar uma configuração
  def self.get(chave, default = nil)
    find_by(chave: chave)&.valor || default
  end
  
  # Método de classe para setar uma configuração
  def self.set(chave, valor)
    config = find_or_initialize_by(chave: chave)
    config.valor = valor
    config.save
  end
  
  # Método específico para o token da API
  def self.token_api
    get('token_api') || ENV['TOKEN_API']
  end
end
