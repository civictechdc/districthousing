require 'dragoman'

$field_name_translator = Dragoman.new do |t|
  t.learn(/FirstName/, ->(first_name) { first_name })
  t.learn(/LastName/, ->(last_name) { last_name })
  t.learn(/DOB/, ->(dob) { dob })
  t.learn(/SSN/, ->(ssn) { ssn })
  t.learn(/Phone/, ->(phone) { phone })
end
