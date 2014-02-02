require 'dragoman'

$field_name_translator = Dragoman.new

$field_name_translator.learn(/FirstName/, ->(first_name) { first_name })
$field_name_translator.learn(/LastName/, ->(last_name) { last_name })
$field_name_translator.learn(/DOB/, ->(dob) { dob })
$field_name_translator.learn(/SSN/, ->(ssn) { ssn })
$field_name_translator.learn(/Phone/, ->(phone) { phone })
