Dado("ter dados de um livro para criação") do
  @body = {
            Title: 'Livro Dom Casmurro',
            Description: 'dojo@cargox.com.br',
            PageCount: 256,
            Excerpt: 'Sumário resumido',
            PublishDate: '2017-09-15T13:00:00.549505+00:00'
  }
end

Quando("chamar o endpoint de post para criar o livro") do
  @response_post = FakeRest.new.post_request(@body)
end

Então("validar o livro criado") do
  # chamaria o get nessa linha se estivesse funcionando e faria a comparação do meu body com o retorno do get
  expect(@response_post.code).to be(200)
  expect(@response_post.response.message).to eql('OK')
  expect(@response_post['ID']).not_to be_nil
  expect(@response_post['Title']).to eql(@body[:Title])
  expect(@response_post['Description']).to eql(@body[:Description])
  expect(@response_post['PageCount']).to eql(@body[:PageCount])
  expect(@response_post['Excerpt']).to eql(@body[:Excerpt])
  expect(@response_post['PublishDate']).to eql(@body[:PublishDate])
end

Dado("ter um livro criado") do
  step 'ter dados de um livro para criação'
  step 'chamar o endpoint de post para criar o livro'
  step 'validar o livro criado'
end

Quando("chamar o endpoint de get para buscar o livro") do
  @response_get = FakeRest.new.get_request(1)
end

Então("validar os dados do livro") do
  expect(@response_get.code).to be(200)
  expect(@response_get['ID']).to eql(1)
  expect(@response_get['Title']).to eql('Book 1')
  expect(@response_get['Description']).not_to be_nil
  expect(@response_get['PageCount']).not_to be_nil
  expect(@response_get['Excerpt']).not_to be_nil
  expect(@response_get['PublishDate']).not_to be_nil
end

E("alterar os dados do mesmo") do
  @body[:Excerpt] = 'Edição Especial do Dia das Mães'
end

Quando("chamar o endpoint de put para alterar o livro") do
  @response_put = FakeRest.new.put_request(@body, @response_post['ID'])
end

Então("validar que os dados foram alterados") do
  # chamaria o get nessa linha se estivesse funcionando para me certificar que foi alterado na base de dados também e faria a comparação com o retorno do body
  expect(@response_put.code).to be(200)
  expect(@response_put['ID']).to eql(@response_post['ID'])
  expect(@response_put['Title']).to eql(@response_post['Title'])
  expect(@response_put['Description']).to eql(@response_post['Description'])
  expect(@response_put['PageCount']).to eql(@response_post['PageCount'])
  expect(@response_put['Excerpt']).not_to eql(@response_post['Excerpt'])
  expect(@response_put['PublishDate']).to eql(@response_post['PublishDate'])
end
