# CX

### Executar local:

Necessário executar comando 'bundle' para instalar as dependências , e em seguida executar os testes com 'cucumber'.  

As tags disponiveis para os testes web são: @cadastro, @edicao, @delecao.  
As tags disponiveis para os testes api são: @criar, @buscar, @alterar.  

### Executar no container:

Necessário possuir o docker instalado, e executar os comandos a seguir:  

*Para buildar a imagem do docker executar comando abaixo dentro da pasta WEB:*
* docker build -f Dockerfile -t jeansbs/ruby_aut_api .  

*Para subir o container e executar os testes de API (deve estar na pasta api):*  
* docker run -v $(pwd):/home/test jeansbs/ruby_aut cucumber features/gherkins/book.feature  

*Para subir o container e executar os testes de WEB (deve estar na pasta web):*  
* docker run -v $(pwd):/home/test jeansbs/ruby_aut cucumber features -p chrome_headless



