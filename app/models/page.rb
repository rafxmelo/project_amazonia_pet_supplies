### app/models/page.rb ###
class Page < ApplicationRecord
  # Define the ransackable attributes for the Page model
  def self.ransackable_attributes(auth_object = nil)
    %w[content created_at id title updated_at]
  end
end
