# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Criando ações iniciais..."

acoes_iniciais = [
  { sigla: 'MXRF11', preco: 9.92 },
  { sigla: 'GARE11', preco: 8.39 },
  { sigla: 'ZAGH11', preco: 9.60 },
  { sigla: 'SNAG11', preco: 10.61 },
  { sigla: 'NUIF11', preco: 91.10 },
  { sigla: 'TGAR11', preco: 66.99 }
]

acoes_iniciais.each do |acao_data|
  acao = Acao.find_or_initialize_by(sigla: acao_data[:sigla])
  if acao.new_record?
    acao.preco = acao_data[:preco]
    acao.data_busca = Time.current
    acao.save!
    puts "  ✓ Criada: #{acao.sigla} - R$ #{acao.preco}"
  else
    puts "  → Já existe: #{acao.sigla}"
  end
end

puts "Seed concluído! Total de ações: #{Acao.count}"
