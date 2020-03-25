#language: pt

Funcionalidade: Deletar Tasks
  Eu como candidato da vaga
  Quero automatizaro cenário de deleção de tasks
  Para validar a funcionalidade

  Contexto:
    Dado realizar login no site suite crm
    Quando acessar a sessão de tasks
    E cadastrar uma task "Task_1"
    Então devo validar a task cadastrada com sucesso

  @delecao
  Cenário: Deletar task
    Quando selecionar a opção de deletar
    Então devo validar que a task foi deletada com sucesso
