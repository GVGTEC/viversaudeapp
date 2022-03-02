class ArquivoImportado < ApplicationRecord
  def processar
    require 'csv'
    debugger
    # batch_rows = CSVParser.new(batch.spreadsheet)

    # batch.update_column(:rows_size, batch_rows.size)

    # batch_rows.each_with_index do |row, index|
    #   batch_row = BatchRow.new(row: index, status: "Queued", batch_id: batch.id)
    #   CreateLoansJob.perform_async(batch.id, batch_row.id)
    # end
  end
end
