# Testando o NotificarAcaoCompreMailer

O mailer foi criado com todas as funcionalidades necessárias para notificar quando uma ação atinge o preço de compra.

## Estrutura Criada

```
app/mailers/
  └── notificar_acao_compre_mailer.rb          # Classe do mailer

app/views/notificar_acao_compre_mailer/
  ├── notificar_compra.html.erb                # Template HTML
  └── notificar_compra.text.erb                # Template texto

test/mailers/
  ├── notificar_acao_compre_mailer_test.rb     # Testes unitários
  └── previews/
      └── notificar_acao_compre_mailer_preview.rb  # Preview no navegador
```

## Formas de Testar

### 1. Preview no Navegador (Mais Visual)

Inicie o servidor Rails:
```bash
rails server
```

Acesse no navegador:
```
http://localhost:3000/rails/mailers/notificar_acao_compre_mailer/notificar_compra
```

Você verá o email renderizado como se fosse enviado!

### 2. Console Rails (Teste Rápido)

```bash
rails console
```

Depois execute:
```ruby
# Carrega o script de teste
load 'test_mailer.rb'
```

Ou teste manualmente:
```ruby
# Cria uma ação
acao = Acao.create!(sigla: 'PETR4', preco: 28.50)

# Gera o email
email = NotificarAcaoCompreMailer.notificar_compra(
  acao: acao,
  preco_atual: 28.00,
  destinatario: 'seu_email@example.com'
)

# Visualiza as informações
puts email.subject
puts email.to
puts email.text_part.body

# Para enviar de verdade (configure SMTP antes!)
email.deliver_now
```

### 3. Testes Automatizados

Execute os testes:
```bash
rails test test/mailers/notificar_acao_compre_mailer_test.rb
```

## Como Usar no Código

### Uso Básico
```ruby
# Envia notificação quando detectar oportunidade de compra
acao = Acao.find_by(sigla: 'PETR4')
preco_atual = 28.00

NotificarAcaoCompreMailer.notificar_compra(
  acao: acao,
  preco_atual: preco_atual
).deliver_later  # Envia em background
```

### Com Destinatário Específico
```ruby
NotificarAcaoCompreMailer.notificar_compra(
  acao: acao,
  preco_atual: 28.00,
  destinatario: 'investidor@example.com'
).deliver_now  # Envia imediatamente
```

## Configuração do Email

Configure o email padrão para notificações:
```ruby
Configuracao.set('email_notificacao', 'seu_email@example.com')
```

## Configurar SMTP (Para Envio Real)

Edite `config/environments/development.rb`:

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'example.com',
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  authentication: 'plain',
  enable_starttls_auto: true
}
```

## Recursos do Mailer

✅ Email HTML responsivo com design bonito  
✅ Email texto plano como fallback  
✅ Parâmetros nomeados para clareza  
✅ Destinatário configurável  
✅ Suporte a preview no navegador  
✅ Testes automatizados  
✅ Script de teste pronto  

## Próximos Passos

1. Configure o SMTP para envio real
2. Integre com o job de monitoramento de ações
3. Adicione mais templates conforme necessário
