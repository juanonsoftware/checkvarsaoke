class OnlineFilesController < ApplicationController
  def index
    render json: OnlineFile.all
  end

  def show
    file = OnlineFile.find(params[:id])
    render json: file
  end

  def create
    file = OnlineFile.create(file_params)
    render json: file, status: :create
  end

  def download_files
    counter = 0
    
    OnlineFile.where(status: :created).each do |file|
      result = FileService.download(file)
      file.status = result ? 'downloaded' : 'error'
      file.save!
      counter += 1
    end

    render json: { new_downloaded_files: counter }
  end

  def process_files
    file_to_process = OnlineFile.where(status: :downloaded).first
    return render json: { message: 'There is no file to process' }, status: :not_found unless file_to_process

    # TODO: Create a service for parsing the file
    service = create_service(file_to_process)
    processed_rows = service.parse_to_rows(file_to_process)

    process_errors = service.get_errors()
    if process_errors.empty?
      TransactionService.save_transactions(processed_rows, file_to_process)
      render json: { file: file_to_process.id, processed_rows: processed_rows.size }
    else
      file_to_process.status = 'error'
      file_to_process.save
      render json: { file: file_to_process.id, errors: errors }, status: :unprocessable_entity
    end
  end

  def confirm
    file = OnlineFile.find(params[:online_file_id])
    file.status = :confirmed
    file.save!
    render json: file
  end

  private

  def create_service(online_file)
    return BidvParserService.new() 
  end

  def file_params
    params.require(:online_file).permit(:name, :path)
  end
end
