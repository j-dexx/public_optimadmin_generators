class PageUploader < Optimadmin::ImageUploader
  version :show do
    process resize_to_fill: [200, 200]
  end
end
