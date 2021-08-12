Dado('que o consumer tenha avançado com um pedido até o checkout com produto {string} na loja {string}') do |product_type, store|
  @storefront = Storefront.new

  store = "https://#{MASSA['stores'][store]}"
  visit(store)
  
  @storefront.select_product(product_type)
  @subtotal = @storefront.create_cart
end

Quando('o consumer finalizar um pedido com o meio de entrega {string} e método de pagamento {string} em loja {string}') do |shipping_option, payment_method, country|
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inpt_email.set('jeanss@teststaging.com')
  
  unless @logged
    case shipping_option
    when 'Correios - SEDEX', 'Correios - PAC', 'Envio Especial', 'OCA Estándar - Envío a domicilio'
      @checkout_start_page.fill_in_deliverable_product_form(country, shipping_option)
    when 'Pedido a ser retirado em EstoqueJean.', 'Retiras en EstoqueJean', 'OCA Estándar - Retirar por una sucursal de OCA', 'Pedido para ser recogido en EstoqueJean'
      @checkout_start_page.fill_in_withdrawal_form(country, shipping_option)
    when 'digital'
      @checkout_start_page.fill_in_digital_form(country)
    end
  end

  if @logged
    @checkout_start_page.select_shipping_option(shipping_option) 
    @checkout_start_page.btnContinue.click
  end

  @total_price = @checkout_start_page.total_price.text

  @checkout_payment_page = CheckoutPayment.new
  @checkout_payment_page.select_payment_option(payment_method)
  @checkout_payment_page.close_order
end

Então('validar que o pedido foi finalizado com sucesso') do |table|
  shipping_option = table.rows_hash['shipping_option']
  store = table.rows_hash['store']
  @checkout_success_page = CheckoutSuccess.new
  @checkout_success_page.wait_until_orderId_visible(wait: 30)
  
  expect(@checkout_success_page.orderId.text).not_to be_nil
  expect(@checkout_success_page.orderSuccess.first.text).to eql('Pedido realizado')

  unless store.eql?('mx')
    expect(@checkout_success_page.prices.first.text.gsub(',','.')).to eql(@subtotal.gsub(',','.'))
  else
    expect(@checkout_success_page.prices.first.text.gsub(',','.').gsub(/ [A-Z]+/, '')).to eql(@subtotal.gsub(',','.'))
  end
  expect(@checkout_success_page.prices.last.text).to eql(@total_price)
  expect(@checkout_success_page.shipping_option.last.text).to eql(shipping_option) unless shipping_option.eql?('digital')
end

Dado('que o consumer tenha finalizado um pedido {string} {string}') do |store, shipping_option|
  @store = store
  steps %{Dado que estou na tela de checkout com um produto "fisico" "#{store}"}
  case store
  when 'testjeans'
      steps %{
      E preencher os dados do formulário "#{shipping_option}"
      E selecionar o método de pagamento "custom"
      Então validar que o pedido foi finalizado com sucesso "#{shipping_option}" "#{store}"
    }
  end
end

Quando('o merchant validar nos detalhes do pedido') do
  admin = 'https://' + @store +'.nubestaging.com.br/admin'
  visit admin
  @admin = Admin.new
  @admin.inpt_email.set('jean.silva@nuvemshop.com.br')
  @admin.inpt_password.set('Nova5008')
  @admin.inpt_password.native.send_keys(:return)
  @admin.btn_login.click

  @admin.btn_login.click
  @admin.wait_until_vendas_visible
  @admin.vendas.click
  @admin.order_list.click
end

Dado('o consumer efetuar o login no checkout') do
  @account = Account.new
  @logged = @account.checkout_login
end

E('validar que o consumer permanece logado no storefront') do
  @storefront.verify_login
  expect(@storefront.my_account.text).to eql('Minha conta')
end

Dado('o consumer aplica o cupom de desconto {string}') do |string|
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.apply_discount_coupon
  expect(@checkout_start_page.subtotal.text.gsub(/[A-Z]\S/, '').gsub('.','').to_f / 100 * 10).to eql(@checkout_start_page.discount.text[4..@checkout_start_page.discount.text.size].to_f)
  @valor_do_produto_com_desconto = @checkout_start_page.subtotal.text.gsub(/[A-Z]\S/, '').gsub('.','').to_f - @checkout_start_page.discount.text[4..@checkout_start_page.discount.text.size].to_f
  expect(@valor_do_produto_com_desconto).to eql(@checkout_start_page.total_price.text.gsub(/[A-Z]\S/, '').gsub('.', '').to_f)
end

E('validar que o valor de desconto do cupom foi aplicado com sucesso') do
  total = @valor_do_produto_com_desconto + @checkout_success_page.frete.text.gsub(/[A-Z]\S/, '').gsub(',', '.').to_f
  expect(@checkout_success_page.prices.last.text.gsub(/[A-Z]\S/, '').gsub('.', '').gsub(',','.').to_f).to eql(total)
end
