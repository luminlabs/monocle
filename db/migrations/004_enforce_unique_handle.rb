Sequel.migration do
	change do
		alter_table(:users) do 
			add_unique_constraint [:handle]
		end
	end
end