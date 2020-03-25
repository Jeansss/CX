#language: pt

Funcionalidade: Editar Tasks
  Eu como candidato da vaga
  Quero automatizaro cenário de edição de tasks
  Para validar a funcionalidade

  Contexto:
    Dado realizar login no site suite crm
    Quando acessar a sessão de tasks
    E cadastrar uma task "Task_1"
    Então devo validar a task cadastrada com sucesso

  @edicao
  Cenário: Editar task
    Quando selecionar a opção de editar
    E editar os dados que desejo
    Então devo validar a task editada com sucesso
