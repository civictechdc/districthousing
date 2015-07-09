module FindIndex
    
    extend ActiveSupport::Concern
    
    attr_accessor :applicant_collection_method   
   
    included do
        def self.part_of applicant_collection_method
            define_method :my_number do
                applicant.send(applicant_collection_method).find_index(self)+1
            end
        end
    end
end