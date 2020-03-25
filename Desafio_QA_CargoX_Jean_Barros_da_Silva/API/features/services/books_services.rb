class FakeRest
  include HTTParty

  base_uri CONFIG['url_default'].to_s
  headers 'Content-Type' => 'application/json'
  format :json

  def post_request(body)
    self.class.post('/api/books', body: body.to_json)
  end

  def get_request(id)
    self.class.get("/api/books/#{id}")
  end

  def put_request(body, id)
    self.class.put("/api/books/#{id}", body: body.to_json)
  end
end
