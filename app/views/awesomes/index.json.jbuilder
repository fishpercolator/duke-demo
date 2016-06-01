json.array!(@awesomes) do |awesome|
  json.extract! awesome, :id, :title
  json.url awesome_url(awesome, format: :json)
end
