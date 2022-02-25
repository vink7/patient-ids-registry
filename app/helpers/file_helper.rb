module FileHelper

  S3_HOST = "https://s3.amazonaws.com"

  def self.upload_files(params)
    %w'identification rec'.each do |model|
      model_attr = "#{model}_attributes".to_sym
      file = params[model_attr].delete :file
      url = self.generate_url(model, file.original_filename)
      params[model_attr][:url] = url

      self.object_upload(file, model)
    end
    return params
  end

  def self.object_upload(file, model)
    begin
      s3 = Aws::S3::Resource.new
      response = s3.bucket(ENV["S3_BUCKET_#{model.upcase}"])
                   .object(file.original_filename)
                   .put(body: file)
      return response.etag ? true : false
    rescue StandardError => e
      puts "Error uploading object: #{e.message}"
      return false
    end
  end

  def self.generate_url(model, key)
    "#{S3_HOST}/#{model == "rec" ? "medical-rec-files" : "identification-files"}/#{key}"
  end

end
