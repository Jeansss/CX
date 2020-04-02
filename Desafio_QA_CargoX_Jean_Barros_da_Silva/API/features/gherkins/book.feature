#language:pt

Funcionalidade: Criar book
  Eu Como candidato do teste
  Quero realizar a criação, consulta e edição do livro via api
  Para validar o funcionamento da mesma

  @criar
  Cenário: Validar o endpoint post da api fakerestapi
    Dado ter dados de um livro para criação
    Quando chamar o endpoint de post para criar o livro
    Então validar o livro criado

  @buscar
  Cenário: Validar o endpoint get da api fakerestapi
    Dado ter um livro criado
    Quando chamar o endpoint de get para buscar o livro
    Então validar os dados do livro

  @alterar
  Cenário: Validar o endpoint put da api fakerestapi
    Dado ter um livro criado
    E alterar os dados do mesmo
    Quando chamar o endpoint de put para alterar o livro
    Então validar que os dados foram alterados
