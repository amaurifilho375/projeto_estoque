class Movimentation < ApplicationRecord
    has_many :products
    has_many :storages
    self.inheritance_column = :_type_disabled
end
