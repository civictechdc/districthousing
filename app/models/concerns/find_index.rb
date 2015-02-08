module FindIndex
    
    extend ActiveSupport::Concern
   
    def index_class
        self.class.index_class
    end
    
    included do
        def self.index_class
            @index_class ||=[]
        end
        
        def self.index_class_includes index_class_attribute
          index_class << index_class_attribute
        end
    end
    
    def my_number
        @applicant.index_class.my_number(self)+1
    end
    
end