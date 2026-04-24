class CreateConfiguracaos < ActiveRecord::Migration[7.1]
  def change
    create_table :configuracaos do |t|
      t.string :chave, null: false
      t.text :valor

      t.timestamps
    end
    
    add_index :configuracaos, :chave, unique: true
  end
end
