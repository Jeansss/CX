#language: pt

Funcionalidade: Cadastrar Tasks
  Eu como candidato da vaga
  Quero automatizaro cenário de cadastro de tasks
  Para validar a funcionalidade

  @cadastro
  Esquema do Cenário: Cadastro de task
    Dado realizar login no site suite crm
    Quando acessar a sessão de tasks
    E cadastrar uma task "<task>"
    Então devo validar a task cadastrada com sucesso

    Exemplos:
      | task   |
      | Task_1 |
      | Task_2 |
      | Task_3 |

