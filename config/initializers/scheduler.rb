require 'rufus-scheduler'

# Inicia o scheduler apenas em ambiente de desenvolvimento ou produção
# e evita inicializar durante migrações ou console
return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == 'rake'

scheduler = Rufus::Scheduler.new

# Executa o job todos os dias à meia-noite
scheduler.cron '0 0 * * *' do
  Rails.logger.info "Executando BuscarAcoesJob em #{Time.current}"
  BuscarAcoesJob.perform_later
end

Rails.logger.info "Scheduler iniciado - BuscarAcoesJob agendado para executar diariamente à meia-noite"
