class AddFinancialImpactToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :credits_change, :integer, default: 0
    add_column :events, :financial_reason, :string
  end
end
