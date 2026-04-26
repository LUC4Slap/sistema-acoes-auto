# 📈 VerifiAções

**Sistema de acompanhamento automático de cotações de ações da bolsa brasileira (B3)**

VerifiAções é uma aplicação web desenvolvida em Ruby on Rails que permite cadastrar e monitorar automaticamente as cotações de ações da bolsa de valores brasileira. O sistema busca os preços atualizados diariamente através da API brapi.dev e mantém um histórico completo de cada ação cadastrada.

---

## 📋 Sobre o Projeto

O VerifiAções foi desenvolvido para facilitar o acompanhamento de investimentos na bolsa de valores. Com ele você pode:

- **Cadastrar ações** que deseja acompanhar
- **Visualizar cotações atuais** de forma organizada
- **Consultar histórico completo** de preços de cada ação
- **Acompanhar variações** percentuais entre períodos
- **Receber atualizações automáticas** diárias sem precisar fazer nada

Ideal para investidores que querem manter um controle simples e eficiente das suas ações sem precisar acessar múltiplas plataformas.

---

## ✨ Funcionalidades

### 📊 Gestão de Ações
- Cadastro manual de ações por sigla (ticker)
- Listagem com a cotação mais recente de cada ação
- Visualização detalhada de cada ação
- Edição e exclusão de registros

### 📈 Histórico de Preços
- Histórico completo de todas as consultas realizadas
- Visualização de variação percentual entre períodos
- Estatísticas: preço atual, maior e menor preço histórico
- Interface gráfica intuitiva com cards informativos

### 🔄 Atualização Automática
- Busca automática de cotações **todos os dias à meia-noite**
- Integração com API brapi.dev para dados em tempo real
- Agendamento de tarefas com Rufus-scheduler
- Histórico preservado a cada atualização

### ⚙️ Configurações
- Interface web amigável para configurar o token da API
- Sem necessidade de editar arquivos ou usar terminal
- Token armazenado com segurança no banco de dados local

### 🎨 Interface Moderna
- Design responsivo (funciona em desktop e celular)
- Bootstrap 5 com ícones Bootstrap Icons
- Animações suaves e feedback visual
- Modo claro otimizado para leitura

---

## 🔧 Requisitos do Sistema

Antes de começar, certifique-se de ter instalado:

- **Ruby 3.2.3** ou superior
- **Rails 7.1.6** ou superior
- **SQLite3** (já vem instalado no Windows)
- **Bundler** (gerenciador de gems)

### Verificando as instalações

```bash
# Verificar versão do Ruby
ruby -v

# Verificar versão do Rails
rails -v

# Verificar versão do Bundler
bundle -v
```

---

## 🚀 Guia de Instalação e Configuração

### Passo 1: Clonar ou baixar o projeto

Se você baixou o projeto como ZIP, extraia-o em uma pasta de sua preferência.

Se está usando Git:
```bash
git clone <url-do-repositorio>
cd verifi-acoes
```

### Passo 2: Instalar as dependências

Abra o terminal (PowerShell ou Prompt de Comando) na pasta do projeto e execute:

```bash
bundle install
```

Este comando instalará todas as bibliotecas (gems) necessárias para o projeto funcionar.

### Passo 3: Configurar o banco de dados

Ainda no terminal, execute:

```bash
rails db:migrate
```

Isso criará o banco de dados SQLite com todas as tabelas necessárias.

### Passo 4: Iniciar o servidor

```bash
rails server
```

Você verá uma mensagem como:
```
=> Booting Puma
=> Rails 7.1.6 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Listening on http://127.0.0.1:3000
```

### Passo 5: Acessar o sistema

Abra seu navegador e acesse: **http://localhost:3000**

---

## 🐳 Executando com Docker

O projeto inclui suporte para Docker, permitindo rodar a aplicação em um container isolado com banco de dados SQLite.

### Pré-requisitos
- Docker instalado
- Docker Compose instalado (opcional)

### Construindo a imagem

```bash
docker build -t verifi-acoes .
```

### Executando com Docker Compose

1. Defina a variável de ambiente `RAILS_MASTER_KEY` com o conteúdo do arquivo `config/master.key`:
   ```bash
   export RAILS_MASTER_KEY=$(cat config/master.key)
   ```

2. Suba o container:
   ```bash
   docker-compose up -d
   ```

3. A aplicação estará disponível em `http://localhost:5001` (ou porta configurada no `docker-compose.yml`).

> **Nota**: O banco de dados SQLite é criado automaticamente dentro do container durante o build.

---

## ⚙️ Configuração Inicial

### 1. Obter Token da API

O sistema precisa de um token para buscar as cotações das ações:

1. Acesse [https://brapi.dev](https://brapi.dev)
2. Faça seu cadastro gratuito
3. Copie seu token de API (uma sequência de letras e números)

### 2. Configurar o Token no Sistema

1. No sistema, clique em **"Configurações"** no menu superior
2. Cole o token no campo indicado
3. Clique em **"Salvar Configuração"**
4. Pronto! O sistema já está configurado

> 💡 **Dica**: O token fica salvo no banco de dados local e não precisa ser configurado novamente.

### 3. Adicionar Suas Primeiras Ações

1. Clique em **"Nova Ação"**
2. Digite a **sigla da ação** que deseja acompanhar
   - Exemplos: PETR4, VALE3, ITUB4, BBAS3, MGLU3
3. Preencha o **preço atual** (você pode consultar em qualquer site de cotações)
4. Selecione a **data da busca** (normalmente a data atual)
5. Clique em **"Salvar Ação"**

---

## 📖 Como Usar o Sistema

### Tela Principal (Ações)
- Visualize todas as ações cadastradas com suas cotações mais recentes
- Clique em **"Ver"** para ver detalhes de uma ação específica
- Clique em **"Histórico"** para ver o histórico completo de preços

### Página de Histórico
- Visualize todas as consultas já realizadas de uma ação
- Veja a variação percentual entre cada período
- Confira estatísticas: preço atual, maior e menor preço histórico

### Atualização Manual
Se quiser atualizar as cotações imediatamente (sem esperar a meia-noite):

1. Abra o terminal na pasta do projeto
2. Execute: `rails console`
3. Digite: `BuscarAcoesJob.perform_now`
4. Aguarde alguns segundos
5. Digite: `exit` para sair do console

---

## 🔄 Funcionamento da Atualização Automática

O sistema utiliza o **Rufus-scheduler** para executar tarefas agendadas. Quando o servidor Rails está rodando:

- **Todos os dias à meia-noite** (00:00), o sistema:
  1. Busca todas as ações cadastradas
  2. Consulta o preço atual de cada uma na API
  3. Salva um novo registro no histórico
  4. Mantém todos os registros anteriores para comparação

> ⚠️ **Importante**: Para a atualização automática funcionar, o servidor Rails precisa estar rodando. Se você desligar o computador ou fechar o terminal, o agendamento não funcionará.

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Descrição |
|------------|-----------|
| **Ruby 3.2.3** | Linguagem de programação |
| **Rails 7.1.6** | Framework web full-stack |
| **SQLite** | Banco de dados relacional leve |
| **Docker** | Containerização da aplicação |
| **Bootstrap 5** | Framework CSS para interface responsiva |
| **Bootstrap Icons** | Biblioteca de ícones |
| **Faraday** | Cliente HTTP para requisições à API |
| **Rufus-scheduler** | Agendador de tarefas em Ruby |
| **API brapi.dev** | Fonte de dados das ações da B3 |

---

## 🗂️ Estrutura do Projeto

```
verifi-acoes/
├── app/
│   ├── controllers/     # Controladores (lógica de negócio)
│   ├── models/          # Modelos (estrutura de dados)
│   ├── views/           # Views (interface visual)
│   └── jobs/            # Jobs (tarefas agendadas)
├── config/
│   ├── routes.rb        # Rotas da aplicação
│   └── initializers/
│       └── scheduler.rb # Configuração do agendador
├── db/
│   ├── migrate/         # Migrações do banco de dados
│   └── schema.rb        # Estrutura do banco
└── storage/             # Banco de dados SQLite
```

---

## 🔒 Segurança e Privacidade

- ✅ O token da API é armazenado localmente no seu computador
- ✅ Nenhum dado é enviado para servidores externos (exceto a API brapi.dev)
- ✅ O banco de dados fica apenas na sua máquina
- ✅ O arquivo `.env` (se usado) não é commitado no Git
- ✅ Tokens podem ser alterados a qualquer momento nas configurações

---

## 🐛 Solução de Problemas

### O servidor não inicia
- Verifique se a porta 3000 não está sendo usada por outro programa
- Tente: `rails server -p 3001` para usar outra porta

### "Token da API não encontrado"
- Acesse as **Configurações** e salve um token válido
- Verifique se o token está correto no site brapi.dev

### Ações não estão atualizando
- Certifique-se de que o servidor Rails está rodando
- Verifique o token da API nas configurações
- Execute manualmente: `BuscarAcoesJob.perform_now` no console

### Erro ao instalar gems
```bash
bundle install --full-index
```

---

## 📚 Documentação Adicional

- **Ruby on Rails**: [https://guides.rubyonrails.org](https://guides.rubyonrails.org)
- **API brapi.dev**: [https://brapi.dev/docs](https://brapi.dev/docs)
- **Bootstrap 5**: [https://getbootstrap.com/docs/5.0](https://getbootstrap.com/docs/5.0)

---

## 📝 Notas Importantes

- O sistema mantém **todos os registros históricos** - quanto mais tempo usar, mais dados terá
- A **primeira ação** precisa ser cadastrada manualmente com o preço inicial
- As **atualizações automáticas** só ocorrem para ações já cadastradas
- O **banco de dados SQLite** está em `storage/development.sqlite3`
- Cada consulta à API cria um **novo registro** no histórico

---

## 🤝 Suporte e Ajuda

### Problemas com a API
- Visite: [https://brapi.dev](https://brapi.dev)
- Email de suporte da API: [suporte@brapi.dev](mailto:suporte@brapi.dev)

### Problemas com Ruby/Rails
- Comunidade Rails Brasil: [https://www.ruby.org.br](https://www.ruby.org.br)

---

## 📄 Licença

Este projeto é de código aberto e está disponível para uso pessoal e educacional.

---

**Desenvolvido com ❤️ usando Ruby on Rails**
