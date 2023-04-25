class AddActiveDiscountToMerchant < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :active_discount, :boolean, default: false
  end
end
