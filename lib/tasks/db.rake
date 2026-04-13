
# Original source: https://gist.github.com/hopsoft/56ba6f55fe48ad7f8b90
# Merged with: https://gist.github.com/kofronpi/37130f5ed670465b1fe2d170f754f8c6
namespace :db do
  desc 'Dumps the database to backups'
  task dump: :environment do
    dump_fmt   = ensure_format(ENV['format'])
    dump_sfx   = suffix_for_format(dump_fmt)
    backup_dir = backup_directory(nil, create: true)
    full_path  = nil
    cmd        = nil
    file_name  = nil

    with_config do |app, host, db, user|
      file_name  = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{db}.#{dump_sfx}"
      full_path = File.join(backup_dir, file_name)
      cmd       = "\"C:\\Program Files\\PostgreSQL\\9.6\\bin\\pg_dump\" -F #{dump_fmt} -v -O -U \"#{user}\" -d \"#{db}\" -f \"#{full_path}\""
    end

    puts cmd
    system cmd

    puts 'Uploading to aws...'
    s3 = Aws::S3::Resource.new(region:'sa-east-1')
    obj = s3.bucket('cloudtag.io').object("db/backups/#{file_name}")
    obj.upload_file(full_path)

    puts ''
    puts "Dumped to file: #{full_path}"
    puts ''
  end

  # namespace :dump do
  #   desc 'Dumps a specific table to backups'
  #   task table: :environment do
  #     table_name = ENV['table']

  #     if table_name.present?
  #       dump_fmt   = ensure_format(ENV['format'])
  #       dump_sfx   = suffix_for_format(dump_fmt)
  #       backup_dir = backup_directory(Rails.env, create: true)
  #       full_path  = nil
  #       cmd        = nil

  #       with_config do |app, host, db, user|
  #         full_path = "#{backup_dir}/#{Time.now.strftime('%Y%m%d%H%M%S')}_#{db}.#{table_name.parameterize.underscore}.#{dump_sfx}"
  #         cmd       = "pg_dump -F #{dump_fmt} -v -O -U '#{user}' -h '#{host}' -d '#{db}' -t '#{table_name}' -f '#{full_path}'"
  #       end

  #       puts cmd
  #       system cmd
  #       puts ''
  #       puts "Dumped to file: #{full_path}"
  #       puts ''
  #     else
  #       puts 'Please specify a table name'
  #     end
  #   end
  # end

  # desc 'Show the existing database backups'
  # task dumps: :environment do
  #   backup_dir = backup_directory
  #   puts "#{backup_dir}"
  #   system "/bin/ls -ltR #{backup_dir}"
  # end

  desc 'Restores the database from a backup using FILENAME'
  task restore: :environment do
    file_name = ENV['filename']

    if file_name.present?
      file = nil
      cmd  = nil

      with_config do |app, host, db, user|
        puts "Downloading backup from aws..."
        bucket_name = ENV['S3_BUCKET'] || 'cloudtag.io'
        object_key = "db/backups/#{file_name}"
        region = 'sa-east-1'

        backup_dir = backup_directory

        # Configure S3 client with SSL options for development environment
        s3_client_options = {
          region: region
        }

        # In development, handle SSL certificate issues
        if Rails.env.development?
          s3_client_options[:ssl_verify_peer] = false
          puts "SSL verification disabled for development environment"
        end

        s3_client = Aws::S3::Client.new(s3_client_options)

        # obj = s3_client.get_object({
        #   bucket: bucket_name,
        #   key: object_key
        # })

        file = "#{backup_dir}/#{file_name}"

        resp = s3_client.get_object({ bucket: bucket_name, key:object_key }, target: file)

        # files      = Dir.glob("#{backup_dir}/**/*#{file_name}*")

        # case files.size
        # when 0
        #   puts "No backups found for the file_name '#{file_name}'"
        # when 1

        # file = files.first

        puts file
        fmt  = format_for_file file

        case fmt
        when nil
          puts "No recognized dump file suffix: #{file}"
        when 'p'
          cmd = "psql -U '#{user}' -h '#{host}' -d '#{db}' -f '#{file}'"
        else
          cmd = "pg_restore -F #{fmt} -v -c -C -U '#{user}' -h '#{host}' -d '#{db}' -f '#{file}'"
        end

        # else
        #   puts "Too many files match the file_name '#{file_name}':"
        #   puts ' ' + files.join("\n ")
        #   puts ''
        #   puts "Try a more specific file_name"
        #   puts ''
        # end
      end
      unless cmd.nil?
        Rake::Task["db:drop"].invoke
        Rake::Task["db:create"].invoke
        puts cmd
        system cmd
        puts ''
        puts "Restored from file: #{file}"
        puts ''
      end
    else
      puts 'Please specify a file file_name for the backup to restore (e.g. timestamp)'
    end
  end

  private

  def ensure_format(format)
    return format if %w[c p t d].include?(format)

    case format
    when 'dump' then 'c'
    when 'sql' then 'p'
    when 'tar' then 't'
    when 'dir' then 'd'
    else 'p'
    end
  end

  def suffix_for_format(suffix)
    case suffix
    when 'c' then 'dump'
    when 'p' then 'sql'
    when 't' then 'tar'
    when 'd' then 'dir'
    else nil
    end
  end

  def format_for_file(file)
    case file
    when /\.dump$/ then 'c'
    when /\.sql$/  then 'p'
    when /\.dir$/  then 'd'
    when /\.tar$/  then 't'
    else nil
    end
  end

  def backup_directory(suffix = nil, create: false)
    backup_dir = File.join(*[Rails.root, 'db', 'backups', suffix].compact)

    if create and not Dir.exist?(backup_dir)
      puts "Creating #{backup_dir} .."
      FileUtils.mkdir_p(backup_dir)
    end

    backup_dir
  end

  def with_config
    yield Rails.application.class.name.deconstantize.underscore,
          ActiveRecord::Base.connection_config[:host],
          ActiveRecord::Base.connection_config[:database],
          ActiveRecord::Base.connection_config[:username]
  end
end
