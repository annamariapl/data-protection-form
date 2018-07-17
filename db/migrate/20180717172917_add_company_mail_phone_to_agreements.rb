class AddCompanyMailPhoneToAgreements < ActiveRecord::Migration[5.2]
  def change
    add_column :agreements, :mail, :string
    add_column :agreements, :phone, :string
    add_column :agreements, :company, :string
  end
end
