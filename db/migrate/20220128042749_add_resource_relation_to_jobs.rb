class AddResourceRelationToJobs < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :resource, polymorphic: true, type: :uuid
  end
end
