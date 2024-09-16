## This is backend for a check_var_sao_ke application written in Ruby on Rails
The purpose is for **studying** with points of interest as below

- Download an online file via http
- Use a gem to process PDF file (extract to text)
- Use a gem for Pagination of transactions
- Use Regex to parse list of transactions from PDF text
- Saving mutiple records in a batch
- Resources rounting

## Flow of files
- Create a new file status will be created
- Download all files then set status to downloaded
- Process files, then set status to processed
- All transactions are saved, there will be OK or NOK (in case parsing got issue, need to fix that records)
- Confirm the file processed OK, set status to confirmed
- Load transactions with pagination
## APIs
- get online_files: http://localhost:3000/online_files
- download online_files: http://localhost:3000/online_files/download_files
- process online_files: http://localhost:3000/online_files/process_files
- confirm process_files: http://localhost:3000/online_files/:online_file_id/confirm
- get transactions: http://localhost:3000/transactions
- get transactions stats: http://localhost:3000/transactions/stats
