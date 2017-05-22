class TabelaDesafiosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @tabela_desafios = TabelaDesafio.all
  end

  def show
  end
   
   # Insere na tabela os dados do arquivo dados.txt.
   # Faz o cálculo do valor total para cada comprador e tambem o valor total dos pedidos.
    def create
      if params[:file] == nil
        redirect_to tabela_desafios_path
        flash[:notice] = "Arquivo não escolhido"
        else 
          if params[:file].original_filename == 'dados.txt'
            uploaded_file = params[:file]
            if uploaded_file.open.readlines.drop(1).each do |line|
            columns = line.split("\t")
            @valor_total = (columns[2].to_f*columns[3].to_i)
            TabelaDesafio.create(:comprador => columns[0], :descricao => columns[1], :preco_unit => columns[2], :quantidade => columns[3], :endereco => columns[4], :fornecedor => columns[5], :valor_total => @valor_total)    
          end
          redirect_to tabela_desafios_path    
          flash[:notice] = "Informações salvas com sucesso."
          end else
          redirect_to tabela_desafios_path 
          flash[:notice] = "Arquivo inválido, selecoine o arquivo 'dados.txt'"
        end 
      end  
      @messages = flash[:notice]
    end 

  # Deleta os dados selecionados pelo usuário
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
