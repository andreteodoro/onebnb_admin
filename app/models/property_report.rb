class PropertyReport < Prawn::Document
   def to_pdf(object)
     @pdf_content = ''
     object.attributes.each{|key, value| @pdf_content << "#{key} : #{value} \n"}
     text @pdf_content
     render
   end
end
