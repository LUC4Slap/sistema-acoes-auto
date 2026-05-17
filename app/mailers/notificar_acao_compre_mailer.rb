class NotificarAcaoCompreMailer < ApplicationMailer
  # Envia notificação quando uma ação atinge o preço de compra
  #
  # @param acao [Acao] A ação que atingiu o preço
  # @param preco_atual [Float] O preço atual da ação
  # @param destinatario [String] Email do destinatário (opcional, usa default se não informado)
  def notificar_compra(acao:, preco_atual:, destinatario: nil)
    @acao = acao
    @preco_atual = preco_atual
    @data_notificacao = Time.current
    
    # Define o destinatário (usa o email padrão se não for informado)
    email_destino = destinatario || Configuracao.get('email_notificacao', 'usuario@example.com')
    
    mail(
      to: email_destino,
      subject: "🎯 Oportunidade de Compra: #{@acao.sigla}"
    )
  end
  
  # Preview do email para testes
  # Acesse em: http://localhost:3000/rails/mailers/notificar_acao_compre_mailer/notificar_compra
  def self.preview
    acao = Acao.new(sigla: 'PETR4', preco: 28.50)
    notificar_compra(acao: acao, preco_atual: 28.00)
  end
end
