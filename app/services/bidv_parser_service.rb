class BidvParserService
  def initialize
    @errors = []
    @results = []
  end

  def parse_to_rows(online_file)
    return [] unless online_file

    filename = Rails.root.join("tmp/storage/#{online_file.id}.pdf")
    reader = PDF::Reader.new(filename)

    reader.pages.each do |page|   
      parse_normal_page(page)
    end

    return @results
  end

  def get_errors()
    return @errors
  end

  private

  def parse_normal_page(page)
    # regex = /(\d+)\s+(\d{2}\/\d{2}\/\d{4}\s+\d{2}:\d{2}:\d{2})\s+(\d+(?:\.\d+))\s+([\s\S]*?(?=(\d+)\s+(\d{2}\/\d{2}\/\d{4}\s+\d{2}:\d{2}:\d{2})))/
    regex = /(\d+)\s+(\d{2}\/\d{2}\/\d{4}\s+\d{2}:\d{2}:\d{2})\s+(\d+(?:\.\d{3})*)\s+([\s\S]*?(?=(\d+)\s+(\d{2}\/\d{2}\/\d{4}\s+\d{2}:\d{2}:\d{2})))/
    
    begin
      # Normalize whitespace and remove extra newlines
      normalized_text = page.text
      rows = normalized_text.scan(regex)
      # debugger
      rows.each do |row|
        record = {  row_number: row[0].to_i, 
                    date_time: row[1],
                    amount: row[2].gsub(".", "").to_i,
                    content: row[3].strip,
                    status: :ok,
                    page_number: page.number }
        
        unless @results.empty?
          for i in (@results.last[:row_number]+1)...record[:row_number]
            debugger
            add_error_row(i, page.number)
          end
        end
        
        @results << record
      end
    rescue => e
      @errors << {
        page_index: page.number,
        normalized_text: normalized_text,
        error: e.message
      }
    end
  end

  def add_error_row(row_number, page_number)
    @results << {
      row_number: row_number,
      date_time: nil,
      amount: nil,
      content: nil,
      status: :nok,
      page_number: page_number
    }
  end
end