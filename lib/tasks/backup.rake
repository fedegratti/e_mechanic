namespace :emechanic do
  desc 'Export db and submit for backup'
  task :backup_db => :environment do
    puts 'Exporting db...'

    ENV['FILE'] = 'db/backup.rb'
    Rake::Task['db:seed:dump'].invoke

    #ENV['AWS_ACCESS_KEY_ID'] = 'AWS_ACCESS_KEY_ID'
    #ENV['AWS_SECRET_ACCESS_KEY'] = 'AWS_SECRET_ACCESS_KEY'

    s3 = Aws::S3::Resource.new(region:'sa-east-1')
    obj = s3.bucket('cloudtag.io').object('db_guille')
    obj.upload_file('db/backup.rb')

    puts 'Db Exported!'
  end
end
