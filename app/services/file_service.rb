require 'open-uri'

class FileService
  def self.download(online_file)
    response = HTTParty.get(online_file.path)
    if response.code == 200
      filename = Rails.root.join("tmp/storage/#{online_file.id}.pdf")
      File.open(filename, 'wb') do |file|
        file.write(response.body)
      end
      return true
    end
  rescue StandardError => e
    Rails.logger.error "Error downloading file with ID #{online_file.name}: #{e.message}"
    return false
  end
end
