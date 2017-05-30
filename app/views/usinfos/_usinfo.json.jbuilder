json.extract! usinfo, :id, :username, :birthday, :user_id, :created_at, :updated_at
json.url usinfo_url(usinfo, format: :json)
