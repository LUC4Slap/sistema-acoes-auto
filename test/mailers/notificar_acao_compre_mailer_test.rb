require "test_helper"

class NotificarAcaoCompreMailerTest < ActionMailer::TestCase
  test "notificar_compra envia email com dados corretos" do
    acao = acoes(:one) # Usa fixture, ou crie uma ação de teste
    preco_atual = 28.00
    destinatario = 'teste@example.com'
    
    # Envia o email
    email = NotificarAcaoCompreMailer.notificar_compra(
      acao: acao,
      preco_atual: preco_atual,
      destinatario: destinatario
    )
    
    # Testa se o email foi enviado
    assert_emails 1 do
      email.deliver_now
    end
    
    # Verifica o destinatário
    assert_equal [destinatario], email.to
    
    # Verifica o assunto
    assert_match /Oportunidade de Compra/, email.subject
    assert_match acao.sigla, email.subject
    
    # Verifica o corpo do email (versão HTML)
    assert_match acao.sigla, email.html_part.body.to_s
    assert_match preco_atual.to_s, email.html_part.body.to_s
    
    # Verifica o corpo do email (versão texto)
    assert_match acao.sigla, email.text_part.body.to_s
    assert_match preco_atual.to_s, email.text_part.body.to_s
  end
  
  test "notificar_compra usa email padrao quando nao informado" do
    acao = acoes(:one)
    
    # Configura email padrão
    Configuracao.set('email_notificacao', 'default@example.com')
    
    email = NotificarAcaoCompreMailer.notificar_compra(
      acao: acao,
      preco_atual: 25.00
    )
    
    assert_equal ['default@example.com'], email.to
  end
end
