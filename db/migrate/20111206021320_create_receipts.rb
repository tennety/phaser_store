class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :quantity
      t.decimal :price,             :precision => 8, :scale => 2
      t.string  :name
      t.string  :status
      t.string  :x_receipt_link_url
      t.string  :description
      t.string  :product_type,      :default => 'product'
      t.boolean :tangible,          :default => true
      t.boolean :demo,              :default => true
      t.boolean :fixed,             :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
