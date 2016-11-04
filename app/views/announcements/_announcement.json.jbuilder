json.extract! announcement, :id, :title, :description, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)