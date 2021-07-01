#language: pt 
@smoke
Funcionalidade: Fechar Pedido com método de pagamento custom
  Eu como cliente
  Quero realizar um pedido de um produto e realizar o pagamento com o método de pagamento custom
  Para adquirir meu produto

  @order1 @smoke @orderbr
  Esquema do Cenário: Finalizar Pedido com diferentes meios de entrega - BR
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store     | shipping_option |
      | testjeans | sedex           |
      | testjeans | pac             |
      | testjeans | pickup          |

  @order_ar1 @smoke @orderar
  Esquema do Cenário: Finalizar Pedido com diferentes meios de entrega - AR
    Dado que estou na tela de checkout com um produto "fisico" "<store>"
    E preencher os dados do formulário ar "<shipping_option>"
    E selecionar o método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso "<shipping_option>" "<store>"

    Exemplos:
      | store       | shipping_option              |
      | testjeanarr | OCA_estandar_envio_domicílio |
      | testjeanarr | pickup                       |
      | testjeanarr | retirar_sucursal_oca         |

  @order_mx1 @smoke @ordermx
  Esquema do Cenário: Finalizar Pedido com diferentes meios de entrega - MX
    Dado que estou na tela de checkout com um produto "fisico" "<store>"
    E preencher os dados do formulário mx "<shipping_option>"
    E selecionar o método de pagamento "customMX"
    Então validar que o pedido foi finalizado com sucesso "<shipping_option>" "<store>"

    Exemplos:
      | store      | shipping_option |
      | testjeanmx | custom          |
      | testjeanmx | pickup          |


  @order3 @smoke @orderbr
  Cenário: Finalizar Pedido com produto digital - BR
    Dado que estou na tela de checkout com um produto "digital" "testjeans"
    E preencher os dados do formulário "digital"
    E selecionar o método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso "digital" "testjeans"


  @order_ar3 @smoke @orderar
  Cenário: Finalizar Pedido com produto digital - AR
    Dado que estou na tela de checkout com um produto "digital" "testjeanarr"
    E preencher os dados do formulário ar "digital"
    E selecionar o método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso "digital" "testjeanarr"


  @order_mx3 @smoke @ordermx
  Cenário: Finalizar Pedido com produto digital - MX
    Dado que estou na tela de checkout com um produto "digital" "testjeanmx"
    E preencher os dados do formulário mx "digital"
    E selecionar o método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso "digital" "testjeanmx"


# @vai @orderbr
#   Esquema do Cenário: Validar total do pedido com um merchant - Custom
#     Dado que o consumer tenha finalizado um pedido "<store>" "<shipping_option>"
#     Quando o merchant validar nos detalhes do pedido
#     Então deve ser exibida as informações da venda
#     @orderar
#     Exemplos:
#       | store      | shipping_option |
#       | testjeans  | sedex           |

  
  Esquema do Cenário: Finalizar pedido com usuário logado
    Dado que estou na tela de checkout com um produto "fisico" "<store>"
    E realizar o login
    E preencher os dados do formulário "<shipping_option>"
    E selecionar o método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso "<shipping_option>" "<store>"
    E retornar ao storefront logado

    Exemplos:
      | store     | shipping_option |
      | testjeans | sedex           |

  @testa
  Esquema do Cenário: Finalizar pedido com cupom de desconto aplicado
    Dado que estou na tela de checkout com um produto "fisico" "<store>"
    E aplico o cupom de desconto "NOVA1011"
    E preencher os dados do formulário "<shipping_option>"
    E selecionar o método de pagamento "custom"
    Então validar que o pedido foi finalizado com sucesso "<shipping_option>" "<store>"
    E validar que o valor de desconto do cupom foi aplicado com sucesso

    Exemplos:
      | store     | shipping_option |
      | testjeans | sedex           |





























  # @order_cl1 @ordercl
  # Cenário: Fechar Pedido - CL
  #   Dado que estou na tela de checkout com um produto "fisico"
  #   E preencher os dados do formulário cl "custom"
  #   E selecionar o método de pagamento "customCL"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_cl2 @ordercl
  # Cenário: Fechar Pedido - CL - Pickup
  #   Dado que estou na tela de checkout com um produto "fisico"
  #   E preencher os dados do formulário cl "pickup"
  #   E selecionar o método de pagamento "customCL"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_cl3 @ordercl
  # Cenário: Fechar Pedido - CL - Digital
  #   Dado que estou na tela de checkout com um produto "digital"
  #   E preencher os dados do formulário cl "digital"
  #   E selecionar o método de pagamento "customCL"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_co1 @orderco
  # Cenário: Fechar Pedido - CO
  #   Dado que estou na tela de checkout com um produto "fisico"
  #   E preencher os dados do formulário co "custom"
  #   E selecionar o método de pagamento "customCL"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_co2 @orderco
  # Cenário: Fechar Pedido - CO - Pickup
  #   Dado que estou na tela de checkout com um produto "fisico"
  #   E preencher os dados do formulário co "pickup"
  #   E selecionar o método de pagamento "customCL"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_co3 @orderco
  # Cenário: Fechar Pedido - CO - Digital
  #   Dado que estou na tela de checkout com um produto "digital"
  #   E preencher os dados do formulário co "digital"
  #   E selecionar o método de pagamento "customCL"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_padrao1 @orderp
  # Cenário: Fechar Pedido - Padrao
  #   Dado que estou na tela de checkout com um produto "fisico"
  #   E preencher os dados do formulário padrão "custom"
  #   E selecionar o método de pagamento "custom"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_padrao2 @orderp
  # Cenário: Fechar Pedido - Padrao - Pickup
  #   Dado que estou na tela de checkout com um produto "fisico"
  #   E preencher os dados do formulário padrão "pickup"
  #   E selecionar o método de pagamento "custom"
  #   Então validar que o pedido foi finalizado com sucesso

  # @order_padrao3 @orderp
  # Cenário: Fechar Pedido - Padrao - Digital
  #   Dado que estou na tela de checkout com um produto "digital"
  #   E preencher os dados do formulário padrão "digital"
  #   E selecionar o método de pagamento "custom"
  #   Então validar que o pedido foi finalizado com sucesso


  # @order_z1 @ok
  # Esquema do Cenário: Fechar Pedido - Padrao - Custom
  #   Dado que estou na tela de checkout com um produto "<product>"
  #   E altero o país para o "<country>" "<shipping>"
  #   E selecionar o método de pagamento "<shipping>"
  #   Então validar que o pedido foi finalizado com sucesso

  #   Exemplos:
  #   | country | product | shipping | 
  #   | br      | fisico  | custom   | 
  #   | ar      | fisico  | custom   | 
  #   | cl      | fisico  | custom   | 
  #   | co      | fisico  | custom   | 
  #   | mx      | fisico  | custom   | 
  #   | af      | fisico  | custom   | 
  #   # | al      | fisico  | custom   |


  # @order_z2 @ok
  # Esquema do Cenário: Fechar Pedido - Padrao - Pickup
  #   Dado que estou na tela de checkout com um produto "<product>"
  #   E altero o país para o "<country>" pickup
  #   E selecionar o método de pagamento "<shipping>"
  #   Então validar que o pedido foi finalizado com sucesso

  #   Exemplos:
  #     | country | product | shipping |
  #     | br      | fisico  | pickup   | 
  #     | ar      | fisico  | pickup   |  
  #     | cl      | fisico  | pickup   | 
  #     | co      | fisico  | pickup   | 
  #     | mx      | fisico  | pickup   | 
  #     | af      | fisico  | pickup   | 
  #     # | al      | fisico  | pickup   |

  # @order_z3 @ok
  # Esquema do Cenário: Fechar Pedido - Padrao - Digital
  #   Dado que estou na tela de checkout com um produto "<product>"
  #   E altero o país para o "<country>" pickup
  #   E selecionar o método de pagamento "<shipping>"
  #   Então validar que o pedido foi finalizado com sucesso

  #   Exemplos:
  #     | country | product | shipping |
  #     | br      | digital | custom   | 
  #     | ar      | digital | custom   | 
  #     | cl      | digital | custom   | 
  #     | co      | digital | custom   | 
  #     | mx      | digital | custom   | 
  #     | af      | digital | custom   | 
  #   # | al      | digital | custom   |
