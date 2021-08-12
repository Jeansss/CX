#language: pt 
@smoke-testing
Funcionalidade: Smoke Testing
  Eu como cliente
  Quero realizar um pedido de um produto e realizar o pagamento com o método de pagamento custom
  Para adquirir meu produto

  @orderbr @smoke @sanity
  Esquema do Cenário: Finalizar Pedido com diferentes meios de entrega - BR
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option                       |
      | br    | Correios - SEDEX                      |
      | br    | Correios - PAC                        |
      | br    | Envio Especial                        |
      | br    | Pedido a ser retirado em EstoqueJean. |

  @order_ar1 @orderar @smoke @sanity
  Esquema do Cenário: Finalizar Pedido com diferentes meios de entrega - AR
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option                                |
      | ar    | OCA Estándar - Envío a domicilio               |
      | ar    | Retiras en EstoqueJean                         |
      | ar    | OCA Estándar - Retirar por una sucursal de OCA |

  @order_mx1 @ordermx @smoke @sanity
  Esquema do Cenário: Finalizar Pedido com diferentes meios de entrega - MX
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option                         |
      | mx    | Envio Especial                          |
      | mx    | Pedido para ser recogido en EstoqueJean |

  @orderbr @digitalbr @smoke @sanity
  Cenário: Finalizar Pedido com produto digital - BR
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "digital" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option |
      | br    | digital         |

  @order_ar3  @orderar @smoke @sanity
  Cenário: Finalizar Pedido com produto digital - AR
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "digital" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option |
      | ar    | digital         |

  @order_mx3  @ordermx @smoke @sanity
  Cenário: Finalizar Pedido com produto digital - MX
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "digital" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option |
      | mx    | digital         |

  @orderbr @paghiper @smoke @sanity
  Cenário: Finalizar Pedido com meios de pagamentos transparentes - PagHiper
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "<payment_option>" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |

    Exemplos:
      | store | shipping_option  | payment_option  |
      | br    | Correios - SEDEX | boleto_paghiper |

  # @redirect
  # Cenário: Finalizar Pedido com meios de pagamentos externos
  #   Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
  #   Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "<payment_option>" em loja ar
  #   Então validar que o pedido foi finalizado com sucesso
  #     | shipping_option | <shipping_option> |
  #     | store           | <store>           |

  #   Exemplos:
  #     | store | shipping_option                  | payment_option |
  #     | ar    | OCA Estándar - Envío a domicilio | payU           |


  @cupom @orderbr @smoke @sanity
  Esquema do Cenário: Finalizar pedido com cupom de desconto aplicado
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    E o consumer aplica o cupom de desconto "NOVA1011"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |
    E validar que o valor de desconto do cupom foi aplicado com sucesso

    Exemplos:
      | store | shipping_option  |
      | br    | Correios - SEDEX |

  @login_checkout @smoke @sanity
  Esquema do Cenário: Finalizar pedido com usuário logado
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    E o consumer efetuar o login no checkout
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "custom" em loja "<store>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | store           | <store>           |
    E validar que o consumer permanece logado no storefront

    Exemplos:
      | store | shipping_option  |
      | br    | Correios - SEDEX |

  @boleto
  Esquema do Cenário: Finalizar Pedido com boleto - BR (Mercado Pago, Nuvem Pago)
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "<payment_option>" em loja "<country>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | country         | <country>       |

    @smoke @sanity
    Exemplos:
      | country | store          | shipping_option                       | payment_option     |
      | br      | qacheckoutmpbr | Correios - SEDEX                      | boleto_mercadopago |
      | br      | qacheckoutmpbr | Pedido a ser retirado em EstoqueJean. | boleto_mercadopago |

    @sanity
    Exemplos:
      | country | store          | shipping_option                       | payment_option     |
      | br      | qacheckoutnpbr | Correios - PAC                        | boleto_nuvempago   |
      | br      | qacheckoutnpbr | Pedido a ser retirado em EstoqueJean. | boleto_nuvempago   |

  @pixe @smoke @sanity
  Esquema do Cenário: Finalizar Pedido com pix - BR (Mercado Pago, Nuvem Pago)
    Dado que o consumer tenha avançado com um pedido até o checkout com produto "fisico" na loja "<store>"
    Quando o consumer finalizar um pedido com o meio de entrega "<shipping_option>" e método de pagamento "<payment_option>" em loja "<country>"
    Então validar que o pedido foi finalizado com sucesso
      | shipping_option | <shipping_option> |
      | country         | <country>       |

    
    Exemplos:
      | country | store          | shipping_option                       | payment_option  |
      | br      | qacheckoutmpbr | Correios - SEDEX                      | pix_mercadopago |
      | br      | qacheckoutmpbr | Pedido a ser retirado em EstoqueJean. | pix_mercadopago |

    Exemplos:
      | country | store          | shipping_option                       | payment_option  |
      | br      | qacheckoutnpbr | Correios - PAC                        | pix_nuvempago   |
      | br      | qacheckoutnpbr | Pedido a ser retirado em EstoqueJean. | pix_nuvempago   |

