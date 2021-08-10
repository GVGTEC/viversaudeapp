namespace :jobs do
  desc "Download TxT"
  task download_txt: :environment do
    out_file = File.new("tmp/nota.txt", "w")
    #...
    out_file.puts("write your stuff here")
    #...
    out_file.close

    #send_file "/tmp/nota.txt"
  end
end