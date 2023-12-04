namespace :pdf do
  desc "Process PDF file"
  task :embed, [:filepath] => :environment do |task, args|
    controller = PdfEmbedController.new
    controller.process(args[:filepath])
  end
end