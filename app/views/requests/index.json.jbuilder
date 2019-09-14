json.array!(@requests) do |request|
  json.extract! request, :id, :roster_id, :user_id, :comment, :mobile, :email, :status
  json.url request_url(request, format: :json)
end
