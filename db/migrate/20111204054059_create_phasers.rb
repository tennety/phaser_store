class CreatePhasers < ActiveRecord::Migration
  def self.up
    create_table :phasers do |t|
    t.string     :name
    t.decimal    :price, :precision => 8, :scale => 2
    t.integer    :quantity
    end
  end

  def self.down
    drop_table :phasers
  end
end
