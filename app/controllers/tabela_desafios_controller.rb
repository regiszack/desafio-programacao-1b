class TabelaDesafiosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @tabela_desafios = TabelaDesafio.all
  end

  def show
  end

  def create
      uploaded_file = params[:file]
      uploaded_file.open.readlines.drop(1).each do |line|
      columns = line.split("\t")
      @valor_total = (columns[2].to_f*columns[3].to_i)
      TabelaDesafio.create(:comprador => columns[0], :descricao => columns[1], :preco_unit => columns[2], :quantidade => columns[3], :endereco => columns[4], :fornecedor => columns[5], :valor_total => @valor_total)  
      end
    redirect_to tabela_desafios_path
  end  

  def destroy
      @tabela_desafio = TabelaDesafio.find(params[:id])
    if  @tabela_desafio.present?
       @tabela_desafio.destroy
    end
    redirect_to tabela_desafios_path
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tabela_desafio
      @tabela_desafio = TabelaDesafio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tabela_desafio_params
      params.permit(:comprador, :descricao, :preco_unit, :quantidade, :endereco, :fornecedor)
    end
end
