# Script de teste do NotificarAcaoCompreMailer
# Execute no Rails console: rails console
# Depois cole este código:

puts "=" * 60
puts "TESTE DO NOTIFICAR ACAO COMPRE MAILER"
puts "=" * 60

# 1. Cria uma ação de teste (ou usa uma existente)
acao = Acao.find_or_create_by(sigla: 'PETR4') do |a|
  a.preco = 28.50
end

puts "\n✓ Ação criada/encontrada: #{acao.sigla} - R$ #{acao.preco}"

# 2. Testa o envio do email em modo preview (não envia de verdade)
puts "\n--- Testando geração do email ---"
email = NotificarAcaoCompreMailer.notificar_compra(
  acao: acao,
  preco_atual: 28.00,
  destinatario: 'teste@example.com'
)

puts "✓ Email criado:"
puts "  De: #{email.from}"
puts "  Para: #{email.to}"
puts "  Assunto: #{email.subject}"
puts "  Partes: #{email.parts.count} (HTML e Texto)"

# 3. Mostra o conteúdo texto
puts "\n--- Conteúdo (versão texto) ---"
puts email.text_part.body.to_s

# 4. Para enviar de verdade (descomente a linha abaixo):
# email.deliver_now
# puts "\n✓ Email enviado!"

puts "\n--- Para visualizar no navegador ---"
puts "1. Inicie o servidor: rails server"
puts "2. Acesse: http://localhost:3000/rails/mailers/notificar_acao_compre_mailer"
puts "3. Clique em 'notificar_compra' para ver o preview"

puts "\n=" * 60
