class Job < ApplicationRecord
  belongs_to :resource, polymorphic: true, optional: true

  def finished?
    state == "finished"
  end
end
