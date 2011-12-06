class Phaser < ActiveRecord::Base

  def decrement(receipt)
    ActiveRecord::Base.transaction do
      self.update_attribute(:quantity, (self.quantity - receipt.quantity))
    end
  end

end
