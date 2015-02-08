module FindIndex
    
    extend ActiveSupport::Concern
   
    included do
        def self.part_of applicant_collection_method
          @@applicant_collection_method = applicant_collection_method
        end
    end
    
    def my_number
        applicant.send(@@applicant_collection_method).find_index(self)+1
    end
    
end
