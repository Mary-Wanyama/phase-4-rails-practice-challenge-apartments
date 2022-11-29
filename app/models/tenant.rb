class Tenant < ApplicationRecord
    validates :name, presence: true

    validate :age_filter 

    def age_filter 
        unless(age>=18)
            error.add(:age, "must be 18year and above")
        end
    end 

    has_many :leases 
    has_many :apartments, through: :leases
end
