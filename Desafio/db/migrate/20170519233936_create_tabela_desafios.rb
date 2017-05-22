class CreateTabelaDesafios < ActiveRecord::Migration[5.1]
  def change
    create_table :tabela_desafios do |t|
      t.string :comprador
      t.string :descricao
      t.float :preco_unit
      t.integer :quantidade
      t.string :endereco
      t.string :fornecedor
      t.float :valor_total

      t.timestamps
    end
  end
end
