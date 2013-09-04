Resident.destroy_all
Resident.create(first_name: "Walter", last_name: "White", middle_name: "Hartwell", res_street_address: "308 Negra Arroyo Lane", res_city: "Albuquerque", res_state: "New Mexico", res_zip: "87122", ssn: "123-45-6789", dob:"7/9/1959", gender:"Male")

HousingForm.destroy_all
HousingForm.create(name: "Benning Heights", uri: "http://192.241.132.194:8080/housing-apps/BenningHeights2013.pdf")
HousingForm.create(name: "Hedin House", uri:"http://192.241.132.194:8080/housing-apps/HedinHouse05-12.pdf")
