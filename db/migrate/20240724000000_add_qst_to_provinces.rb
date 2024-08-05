class AddQstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :qst, :decimal, precision: 5, scale: 2, default: 0.0
  end
end