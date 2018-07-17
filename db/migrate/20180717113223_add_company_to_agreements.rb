class AddCompanyToAgreements < ActiveRecord::Migration[5.2]
	def change
		add_column :agreements, :company, :string
		add_column :agreements, :phone, :string
		add_column :agreements, :mail, :string
	end
end
