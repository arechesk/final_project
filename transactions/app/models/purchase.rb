class Purchase < ApplicationRecord
  enum doc_type: {
    passport: 'passport',
    birth_certificate: 'birth_certificate',
    driver_licence: 'driver licence'
  }
end
