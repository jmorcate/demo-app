module StaticPagesHelper
    
    def full_title(page_title="")
        title_fixed_part ="The SSSB TDY Application"
        if page_title.empty?
            "#{title_fixed_part}"
        else 
            "#{page_title} | #{title_fixed_part}"
        end
    end
end
