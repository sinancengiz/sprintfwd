class Member < ApplicationRecord
    belongs_to :team
    validates :first_name, :last_name, :team_id, presence: true

end
