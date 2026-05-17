# Preview all emails at http://localhost:3000/rails/mailers/notificar_acao_compre_mailer
class NotificarAcaoCompreMailerPreview < ActionMailer::Preview
  # Preview deste email em:
  # http://localhost:3000/rails/mailers/notificar_acao_compre_mailer/notificar_compra
  def notificar_compra
    acao = Acao.new(
      sigla: 'PETR4',
      preco: 28.50
    )
    
    NotificarAcaoCompreMailer.notificar_compra(
      acao: acao,
      preco_atual: 28.00,
      destinatario: 'teste@example.com'
    )
  end
  
  # Preview com valores diferentes
  # http://localhost:3000/rails/mailers/notificar_acao_compre_mailer/notificar_compra_vale
  def notificar_compra_vale
    acao = Acao.new(
      sigla: 'VALE3',
      preco: 65.00
    )
    
    NotificarAcaoCompreMailer.notificar_compra(
      acao: acao,
      preco_atual: 64.50,
      destinatario: 'teste@example.com'
    )
  end
end
