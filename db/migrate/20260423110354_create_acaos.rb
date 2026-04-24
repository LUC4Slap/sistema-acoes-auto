class CreateAcaos < ActiveRecord::Migration[7.1]
  def change
    create_table :acaos do |t|
      t.string :sigla
      t.float :preco
      t.date :data_busca

      t.timestamps
    end
  end
end
