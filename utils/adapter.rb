require 'json'

module Adapter
  def self.write_file(file_path, data)
    File.open(file_path, 'w') do |f|
      f.write(data.to_json)
    end
  end

  def self.read(file_path, &callback)
    File.open(file_path, 'r') do |f|
      data = JSON.load(f)
      callback.call(data)
    end
  end

  def self.read_write(file_path, &callback)
    data = read(file_path, &callback)
    write_file(file_path, data)
  end
end
