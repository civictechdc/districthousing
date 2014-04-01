require 'dragoman'

$field_name_translator = Dragoman.new do |t|
  t.learn(/FirstName/, ->(first_name) { first_name })
  t.learn(/LastName/, ->(last_name) { last_name })
  t.learn(/DOB/, ->(dob) { dob })
  t.learn(/SSN/, ->(ssn) { ssn })
  t.learn(/Phone/, ->(phone) { phone })
  t.learn(/MailAddStreet/, ->(mail_street_address) { mail_street_address })
  t.learn(/MailAddCity/, ->(mail_city) { mail_city })
  t.learn(/MailAddState/, ->(mail_state) { mail_state })
  t.learn(/MailAddZip/, ->(mail_zip) { mail_zip })
  t.learn(/PreferredPhone/, ->(preferred_phone) { preferred_phone })
  t.learn(/WorkPhone/, ->(work_phone) { work_phone })
  t.learn(/RaceWhiChk/, ->(race) { race =~ /white/i and "Yes"  or "" })
  t.learn(/RaceIndChk/, ->(race) { race =~ /american indian/i and "Yes"  or "" })
  t.learn(/RaceIndChk/, ->(race) { race =~ /american indian/i and "Yes"  or "" })
  t.learn(/^HispChk/, ->(race) { race =~ /hispanic/i and "Yes"  or "" })
  t.learn(/NonHispChk/, ->(race) { race =~ /hispanic/i and ""  or "Yes" })
  t.learn(/RaceBlChk/, ->(race) { race =~ /black/i and "Yes"  or "" })
  t.learn(/RaceAsianChk/, ->(race) { race =~ /asian/i and "Yes"  or "" })
  t.learn(/NoAns/, ->(race) { race =~ /No answer/i and "Yes"  or "" })
end
