class HistoricoController < ApplicationController
  def index
    @historico = Acao.where(sigla: params[:sigla]).order(data_busca: :desc)
  end

  def destroy
    @acao = Acao.find(params[:id])
    sigla = @acao.sigla
    @acao.destroy!

    respond_to do |format|
      format.html { redirect_to historico_path(sigla: sigla), notice: "Histórico deletado com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end
end
