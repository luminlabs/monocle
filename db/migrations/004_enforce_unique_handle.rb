Sequel.migration do
	change do
		alter_table(:userz) do 
			add_unique_constraint [:handle]
		end
	end
end