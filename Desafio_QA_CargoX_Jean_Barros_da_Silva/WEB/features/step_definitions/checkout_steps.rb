Dado('que o consumer tenha avançado com um pedido até o checkout com produto {string} na loja {string}') do |product_type, store|
  @home_page = Home.new
  @product_type = product_type

  store = "https://#{store}.apps-logos.nubestaging.com"
  visit store
  @home_page.has_products?
  if @product_type.eql?('fisico')
    @home_page.products.first.hover
    @home_page.addProducts.first.click
  else @product_type.eql?('digital')
    @home_page.products.last.hover
    @home_page.addProducts.last.click
  end
  @home_page.has_viewCart?
  @home_page.viewCart.click
  @price = @home_page.price_product.text
  @home_page.finishOrder.click
  # new_url = URI.parse(page.current_url).to_s.gsub(/\.n/, '.feature-address-schema.n')
  # visit(new_url)
end

Quando('o consumer finalizar um pedido com o meio de entrega {string} e método de pagamento {string}') do |shippingOption, paymentMethod|
  @document = '19100000000' if @document.nil?
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.postalCode.set('03171020')
    @checkout_start_page.btnNext.click
    #entrega
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('sedex')
    @checkout_start_page.shippingOption.last.click if shippingOption.eql?('pac')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
  end
  if shippingOption.eql?('sedex') || shippingOption.eql?('pac') || shippingOption.eql?('customMX')
    #dados destinatário
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('1199999999')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.visible?
    expect(@checkout_start_page.shippingAddress.disabled?).to be_truthy
    expect(@checkout_start_page.shippingAddress.value).to eql('Rua Caa-Açu')
    @checkout_start_page.shippingNumber.visible?
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingComplement.visible?
    expect(@checkout_start_page.shippingComplement.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.visible?
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_truthy
    expect(@checkout_start_page.shippingNeighborhood.value).to eql('Belenzinho')
    @checkout_start_page.shippingCity.visible?
    expect(@checkout_start_page.shippingCity.disabled?).to be_truthy
    expect(@checkout_start_page.shippingCity.value).eql?('São Paulo')
    @checkout_start_page.shippingPostalCode.visible?
    expect(@checkout_start_page.shippingPostalCode.disabled?).to be_truthy
    expect(@checkout_start_page.shippingPostalCode.value).to eql('03171020')
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.disabled?).to be_truthy
    expect(@checkout_start_page.shippingState.value).to eql('São Paulo')
    @checkout_start_page.shippingNumber.set('5555')
  else shippingOption.eql?('pickup') || @productType.eql?('digital')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingPostalCode.set('03171020')
    @checkout_start_page.billingNumber.set('12')
  end
  #dados de cobrança
  @checkout_start_page.billingIdDoc.set(@document)
  @checkout_start_page.btnContinue.click

  @checkout_payment_page = CheckoutPayment.new
  @checkout_payment_page.has_paymentCustom?
  @checkout_payment_page.paymentCustom.click unless @checkout_payment_page.paymentCustom['class'].eql?('radio payment-option active')
  @checkout_payment_page.noteText.set('ok')
  @total_price = @checkout_start_page.total_price.text
  @checkout_payment_page.closeOrder.click
end

Então('validar que o pedido foi finalizado com sucesso') do |table|
  shipping_option = table.rows_hash['shipping_option']
  store = table.rows_hash['store']
  @checkout_success_page = CheckoutSuccess.new
  @checkout_success_page.wait_until_orderId_visible(wait: 25)
  @checkout_success_page.has_orderId?
  expect(@checkout_success_page.orderId.text).not_to be_nil
  expect(@checkout_success_page.orderSuccess.first.text).to eql('Pedido realizado')
  expect(@checkout_success_page.prices.first.text[0..8].gsub(',','.')).to eql(@price.gsub(',','.'))

  expect(@checkout_success_page.prices.last.text).to eql(@total_price)

  unless shipping_option.eql?('digital')
    shipping_options = {"sedex" => 'Correios - SEDEX', "pac" => 'Correios - PAC', "pickup" => 'Pedido a ser retirado em EstoqueJean.'} if store.eql?('testjeans')
    shipping_options = {"custom" => 'Envio Especial', "pickup" => 'Pedido para ser recogido en EstoqueJean'} if store.eql?('testjeanmx')
    shipping_options = {"OCA_estandar_envio_domicílio" => 'OCA Estándar - Envío a domicilio', "pickup" => 'Retiras en EstoqueJean', "retirar_sucursal_oca" => 'OCA Estándar - Retirar por una sucursal de OCA'} if store.eql?('testjeanarr')

    expect(@checkout_success_page.shipping_option.last.text).to eql(shipping_options[shipping_option])
  end
end


Dado('que estou na tela de checkout com um produto {string} {string}') do |productType, store|
  @home_page = Home.new
  @productType = productType

  store = "https://#{store}.apps-logos.nubestaging.com"
  visit store
  @home_page.has_products?
  if @productType.eql?('fisico')
    @home_page.products.first.hover
    @home_page.addProducts.first.click
  else @productType.eql?('digital')
    @home_page.products.last.hover
    @home_page.addProducts.last.click
  end
  @home_page.has_viewCart?
  @home_page.viewCart.click
  @price = @home_page.price_product.text
  @home_page.finishOrder.click
  new_url = URI.parse(page.current_url).to_s.gsub(/\.n/, '.feature-address-schema.n')
  # visit(new_url)
end

E('preencher os dados do formulário {string}') do |shippingOption|
  @document = '19100000000' if @document.nil?
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.postalCode.set('03171020')
    @checkout_start_page.btnNext.click
    #entrega
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('sedex')
    @checkout_start_page.shippingOption.last.click if shippingOption.eql?('pac')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
  end
  if shippingOption.eql?('sedex') || shippingOption.eql?('pac') || shippingOption.eql?('customMX')
    #dados destinatário
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('1199999999')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.visible?
    expect(@checkout_start_page.shippingAddress.disabled?).to be_truthy
    expect(@checkout_start_page.shippingAddress.value).to eql('Rua Caa-Açu')
    @checkout_start_page.shippingNumber.visible?
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingComplement.visible?
    expect(@checkout_start_page.shippingComplement.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.visible?
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_truthy
    expect(@checkout_start_page.shippingNeighborhood.value).to eql('Belenzinho')
    @checkout_start_page.shippingCity.visible?
    expect(@checkout_start_page.shippingCity.disabled?).to be_truthy
    expect(@checkout_start_page.shippingCity.value).eql?('São Paulo')
    @checkout_start_page.shippingPostalCode.visible?
    expect(@checkout_start_page.shippingPostalCode.disabled?).to be_truthy
    expect(@checkout_start_page.shippingPostalCode.value).to eql('03171020')
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.disabled?).to be_truthy
    expect(@checkout_start_page.shippingState.value).to eql('São Paulo')
    @checkout_start_page.shippingNumber.set('5555')
  else shippingOption.eql?('pickup') || @productType.eql?('digital')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingPostalCode.set('03171020')
    @checkout_start_page.billingNumber.set('12')
  end
  #dados de cobrança
  @checkout_start_page.billingIdDoc.set(@document)
  @checkout_start_page.btnContinue.click
end

Quando('selecionar o método de pagamento {string}') do |paymentMethod|
  @checkout_payment_page = CheckoutPayment.new
    @checkout_payment_page.has_paymentCustom?
    paymentMethod = 'customMX' if ENV['ENV'].eql?('mx')
    # if paymentMethod.eql?('customMX')
      # binding.pry
      # @checkout_payment_page.paymentCustomMX.click
    # else
      @checkout_payment_page.paymentCustom.click unless @checkout_payment_page.paymentCustom['class'].eql?('radio payment-option active')
    # end
  @checkout_payment_page.noteText.set('ok')
  @total_price = @checkout_start_page.total_price.text
  @checkout_payment_page.closeOrder.click
end

Então('validar que o pedido foi finalizado com sucesso {string} {string}') do |shippingOption, store|
  @checkout_success_page = CheckoutSuccess.new
  @checkout_success_page.wait_until_orderId_visible(wait: 25)
  @checkout_success_page.has_orderId?
  expect(@checkout_success_page.orderId.text).not_to be_nil
  expect(@checkout_success_page.orderSuccess.first.text).to eql('Pedido realizado')
  expect(@checkout_success_page.prices.first.text[0..8].gsub(',','.')).to eql(@price.gsub(',','.'))

  expect(@checkout_success_page.prices.last.text).to eql(@total_price)

  unless shippingOption.eql?('digital')
    shipping_options = {"sedex" => 'Correios - SEDEX', "pac" => 'Correios - PAC', "pickup" => 'Pedido a ser retirado em EstoqueJean.'} if store.eql?('testjeans')
    shipping_options = {"custom" => 'Envio Especial', "pickup" => 'Pedido para ser recogido en EstoqueJean'} if store.eql?('testjeanmx')
    shipping_options = {"OCA_estandar_envio_domicílio" => 'OCA Estándar - Envío a domicilio', "pickup" => 'Retiras en EstoqueJean', "retirar_sucursal_oca" => 'OCA Estándar - Retirar por una sucursal de OCA'} if store.eql?('testjeanarr')

    expect(@checkout_success_page.shipping_option.last.text).to eql(shipping_options[shippingOption])
  end

end


E('preencher os dados do formulário ar {string}') do |shippingOption|
  @document = '1234567' if @document.nil?

  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.postalCode.set('1865')
    @checkout_start_page.btnNext.click
    #entrega
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('OCA_estandar_envio_domicílio')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
    if shippingOption.eql?('retirar_sucursal_oca')
      @checkout_start_page.pickup_oca.last.click
      @checkout_start_page.wait_until_select_suboption_visible
      @checkout_start_page.select_suboption[1].click
    end
  end
  if shippingOption.eql?('OCA_estandar_envio_domicílio')
    #dados destinatário
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('542213246633')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.set('Fake')
    expect(@checkout_start_page.shippingAddress.disabled?).to be_falsey
    @checkout_start_page.shippingNumber.set('2333')
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingComplement.set('fake')
    expect(@checkout_start_page.shippingComplement.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.set('fake')
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_falsey
    @checkout_start_page.shippingCity.set('fake')
    expect(@checkout_start_page.shippingCity.disabled?).to be_falsey
    @checkout_start_page.shippingPostalCode.visible?
    expect(@checkout_start_page.shippingPostalCode.disabled?).to be_truthy
    expect(@checkout_start_page.shippingPostalCode.value).to eql('1865')
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.disabled?).to be_truthy
    expect(@checkout_start_page.shippingState.value).to eql('Buenos Aires')
  else shippingOption.eql?('pickup') || @productType.eql?('digital') || shippingOption.eql?('retirar_sucursal_oca')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('542213246633')
    #ar
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingPostalCode.set('1865')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.value).to eql('Capital Federal')
  end
  #dados de cobrança
  @checkout_start_page.billingIdDoc.set(@document)
  @checkout_start_page.btnContinue.click
end

E('preencher os dados do formulário mx {string}') do |shippingOption|
  @document = '1234567' if @document.nil?

  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.postalCode.set('53460')
    @checkout_start_page.btnNext.click
    #entrega
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('custom')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
  end
  if shippingOption.eql?('custom')
    #dados destinatário
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('1199999999')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.set('Fake')
    expect(@checkout_start_page.shippingAddress.disabled?).to be_falsey
    @checkout_start_page.shippingNumber.set('2333')
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingComplement.set('fake')
    expect(@checkout_start_page.shippingComplement.disabled?).to be_falsey
    @checkout_start_page.shippingReference.set('fake')
    expect(@checkout_start_page.shippingReference.disabled?).to be_falsey
    @checkout_start_page.betweenStret.set('fake')
    expect(@checkout_start_page.betweenStret.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.set('fake')
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_falsey
    @checkout_start_page.shippingCity.set('fake')
    expect(@checkout_start_page.shippingCity.disabled?).to be_falsey
    @checkout_start_page.shippingPostalCode.visible?
    expect(@checkout_start_page.shippingPostalCode.disabled?).to be_truthy
    expect(@checkout_start_page.shippingPostalCode.value).to eql('53460')
    @checkout_start_page.shippingState.visible?
    # expect(@checkout_start_page.shippingState.disabled?).to be_truthy

    # expect(@checkout_start_page.shippingState.value).to eql('Ciudad de México')
  else shippingOption.eql?('pickup') || @productType.eql?('digital')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingPostalCode.set('54360')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.disabled?).to be_falsey
    expect(@checkout_start_page.billingState.value).to eql('Ciudad de México')
  end
  #dados de cobrança
  @checkout_start_page.billingIdDoc.set(@document)
  @checkout_start_page.btnContinue.click
end

Dado('preencher os dados do formulário cl {string}') do |shippingOption|
  @document = '1234567' if @document.nil?

  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.country.visible?
    80.times do
      break if @checkout_start_page.country.value.size > 1
    end
    expect(@checkout_start_page.country.value).to eql('CL')
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.value).to eql('Aisén del General Carlos Ibáñez del Campo')
    @checkout_start_page.btnNext.click
    #entrega
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('custom')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
  end
  if shippingOption.eql?('custom')
    #dados destinatário
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('1199999999')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.set('Fake')
    expect(@checkout_start_page.shippingAddress.disabled?).to be_falsey
    @checkout_start_page.shippingNumber.set('2333')
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingComplement.set('fake')
    expect(@checkout_start_page.shippingComplement.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.set('fake')
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_falsey
    @checkout_start_page.shippingCity.set('fake')
    expect(@checkout_start_page.shippingCity.disabled?).to be_falsey
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.disabled?).to be_truthy
    expect(@checkout_start_page.shippingState.value).to eql('Aisén del General Carlos Ibáñez del Campo')
  else shippingOption.eql?('pickup') || @productType.eql?('digital')
    #dados de cobrança
    @checkout_start_page.billingCountry.visible?
    80.times do
      break if @checkout_start_page.billingCountry.value.size > 1
    end
    expect(@checkout_start_page.billingCountry.value).to eql('CL')
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.value).to eql('Aisén del General Carlos Ibáñez del Campo')
  end
  #dados de cobrança
  @checkout_start_page.billingIdDoc.set(@document)
  @checkout_start_page.btnContinue.click
end

Dado('preencher os dados do formulário co {string}') do |shippingOption|
  @document = '1234567' if @document.nil?

  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.country.visible?
    80.times do
      break if @checkout_start_page.country.value.size > 1
    end
    expect(@checkout_start_page.country.value).to eql('CO')
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.value).to eql('Amazonas')
    @checkout_start_page.btnNext.click
    #entrega
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('custom')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
  end
  if shippingOption.eql?('custom')
    #dados destinatário
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('1199999999')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.set('Fake')
    expect(@checkout_start_page.shippingAddress.disabled?).to be_falsey
    @checkout_start_page.shippingNumber.set('2333')
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.set('fake')
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_falsey
    @checkout_start_page.shippingCity.set('fake')
    expect(@checkout_start_page.shippingCity.disabled?).to be_falsey
    @checkout_start_page.shippingState.visible?
    expect(@checkout_start_page.shippingState.disabled?).to be_truthy
    expect(@checkout_start_page.shippingState.value).to eql('Amazonas')
  else shippingOption.eql?('pickup') || @productType.eql?('digital')
    #dados de cobrança
    @checkout_start_page.billingCountry.visible?
    80.times do
      break if @checkout_start_page.billingCountry.value.size > 1
    end
    expect(@checkout_start_page.billingCountry.value).to eql('CO')
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.value).to eql('Amazonas')
  end
  #dados de cobrança
  @checkout_start_page.billingIdDoc.set(@document)
  @checkout_start_page.btnContinue.click
end

E('preencher os dados do formulário padrão {string}') do |shippingOption|
  @document = '19100000000' if @document.nil?
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  unless shippingOption.eql?('digital')
    @checkout_start_page.countries[7].click
    @checkout_start_page.postalCode.set('10115')
    @checkout_start_page.btnNext.click
    @checkout_start_page.shippingOption.first.click if shippingOption.eql?('custom')
    @checkout_start_page.pickup.click if shippingOption.eql?('pickup')
  end
  #dados destinatário
  if shippingOption.eql?('custom')
    @checkout_start_page.name.set('test')
    @checkout_start_page.lastName.set('last')
    @checkout_start_page.tel.set('1199999999')
    #endereço do destinatário
    @checkout_start_page.shippingAddress.set('Fake')
    expect(@checkout_start_page.shippingAddress.disabled?).to be_falsey
    @checkout_start_page.shippingNumber.set('2333')
    expect(@checkout_start_page.shippingNumber.disabled?).to be_falsey
    @checkout_start_page.shippingComplement.set('fake')
    expect(@checkout_start_page.shippingComplement.disabled?).to be_falsey
    @checkout_start_page.shippingNeighborhood.set('fake')
    expect(@checkout_start_page.shippingNeighborhood.disabled?).to be_falsey
    @checkout_start_page.shippingCity.set('fake')
    expect(@checkout_start_page.shippingCity.disabled?).to be_falsey
    @checkout_start_page.inptShippingState.visible?
    expect(@checkout_start_page.inptShippingState.disabled?).to be_falsey
    @checkout_start_page.inptShippingState.set('Berlim')
  else shippingOption.eql?('pickup') || @productType.eql?('digital')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
  end
  @checkout_start_page.billingIdDoc.set('19100000000')
  @checkout_start_page.btnContinue.click
end


Dado('altero o país para o {string} {string}') do |country, shipping|
  @checkout_start_page = CheckoutStart.new
  @document = '19100000000' if ENV['ENV'].eql?('br')
  case country
  when 'ar'
    @checkout_start_page.countries.first.click
    step("preencher os dados do formulário ar '#{shipping}'")
  when 'br'
    @checkout_start_page.countries[1].click 
    step("preencher os dados do formulário '#{shipping}'")
  when 'cl'
    @checkout_start_page.countries[2].click
    step("preencher os dados do formulário cl '#{shipping}'")
  when 'co'
    @checkout_start_page.countries[3].click
    step("preencher os dados do formulário co '#{shipping}'")
  when 'mx'
    @checkout_start_page.countries[4].click
    step("preencher os dados do formulário mx '#{shipping}'")
  when 'af'
    @checkout_start_page.countries[5].click
    step("preencher os dados do formulário padrão '#{shipping}'")
  when 'al'
    @checkout_start_page.countries[7].click
    step("preencher os dados do formulário padrão '#{shipping}'")
  end
end


Dado('altero o país para o {string} pickup') do |country|
  # @cep = nil
  # case ENV['ENV']
  # when 'br'
  #   @cep = '03171020'
  # when 'ar'
  #   @cep = '1665'
  # when 'mx'
  #   @cep = '54360'
  # else
  #   @cep = '03171020'
  # end

  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.inptEmail.set('test@test.lhz')
  # # binding.pry#####
  # @checkout_start_page.postalCode.set(@cep) unless ENV['ENV'].eql?('co') || ENV['ENV'].eql?('cl')
  # @checkout_start_page.btnNext.click
  #entrega
  # @checkout_start_page.pickup.click

  case country
  when 'ar'
    @checkout_start_page.billingCountries.first.click
    @checkout_start_page.billingIdDoc.set('19100000000')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('542213246633')
    #ar
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingPostalCode.set('1865')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.value).to eql('Capital Federal')
  when 'br'
    @checkout_start_page.billingCountries[1].click 
    #dados de cobrança
    @checkout_start_page.billingIdDoc.set('19100000000')
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingPostalCode.set('03171020')
    #
    @checkout_start_page.billingAddress.visible?
    expect(@checkout_start_page.billingAddress.disabled?).to be_truthy
    expect(@checkout_start_page.billingAddress.value).to eql('Rua Caa-Açu')
    @checkout_start_page.billingNumber.visible?
    expect(@checkout_start_page.billingNumber.disabled?).to be_falsey
    @checkout_start_page.billingComplement.visible?
    expect(@checkout_start_page.billingComplement.disabled?).to be_falsey
    @checkout_start_page.billingNeighborhood.visible?
    expect(@checkout_start_page.billingNeighborhood.disabled?).to be_truthy
    expect(@checkout_start_page.billingNeighborhood.value).to eql('Belenzinho')
    @checkout_start_page.billingCity.visible?
    expect(@checkout_start_page.billingCity.disabled?).to be_truthy
    expect(@checkout_start_page.billingCity.value).eql?('São Paulo')
    @checkout_start_page.billingPostalCode.visible?
    expect(@checkout_start_page.billingPostalCode.disabled?).to be_falsey
    expect(@checkout_start_page.billingPostalCode.value).to eql('03171020')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.disabled?).to be_truthy
    expect(@checkout_start_page.billingState.value).to eql('São Paulo')
    @checkout_start_page.billingNumber.set('5555')

  when 'cl'
    @checkout_start_page.billingCountries[2].click
    @checkout_start_page.billingIdDoc.set('19100000000')
    #dados de cobrança
    @checkout_start_page.billingCountry.visible?
    80.times do
      break if @checkout_start_page.billingCountry.value.size > 1
    end
    expect(@checkout_start_page.billingCountry.value).to eql('CL')
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.value).to eql('Aisén del General Carlos Ibáñez del Campo')
  when 'co'
    @checkout_start_page.billingCountries[3].click
    @checkout_start_page.billingIdDoc.set('19100000000')
    @checkout_start_page.billingCountry.visible?
    80.times do
      break if @checkout_start_page.billingCountry.value.size > 1
    end
    expect(@checkout_start_page.billingCountry.value).to eql('CO')
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.value).to eql('Amazonas')
  when 'mx'
    @checkout_start_page.billingCountries[4].click
    @checkout_start_page.billingIdDoc.set('19100000000')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingPostalCode.set('54360')
    @checkout_start_page.billingState.visible?
    expect(@checkout_start_page.billingState.disabled?).to be_falsey
    expect(@checkout_start_page.billingState.value).to eql('Ciudad de México')
  when 'af'
    @checkout_start_page.billingCountries[5].click
    @checkout_start_page.billingIdDoc.set('19100000000')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingPostalCode.set('54360')
    @checkout_start_page.billingStateInpt.set('Fake')
  when 'al'
    @checkout_start_page.billingCountries[6].click
    @checkout_start_page.billingIdDoc.set('19100000000')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    #dados de cobrança
    @checkout_start_page.billingName.set('test')
    @checkout_start_page.billingLastName.set('test')
    @checkout_start_page.billingPhone.set('1199999999')
    @checkout_start_page.billingAddress.set('Fake')
    @checkout_start_page.billingNumber.set('122')
    @checkout_start_page.billingComplement.set('Fake')
    @checkout_start_page.billingNeighborhood.set('Fake')
    @checkout_start_page.billingCity.set('Fake')
    @checkout_start_page.billingPostalCode.set('54360')
    @checkout_start_page.billingStateInpt.set('Fake')
  end
  #dados de cobrança
  @checkout_start_page.btnContinue.click
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
  binding.pry
  @admin.inpt_password.native.send_keys(:return)
  @admin.btn_login.click

  @admin.btn_login.click
  @admin.wait_until_vendas_visible
  @admin.vendas.click
  binding.pry
  @admin.order_list.click





end

Então('deve ser exibida as informações da venda') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('realizar o login') do
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.login.click
  @account = Account.new
  @account.login.set('jeansstest@mailsac.com')
  @account.password.set('nova1010')
  @account.btn_login.click
end

E('retornar ao storefront logado') do
  @checkout_success_page.continue.click
  @home_page.div_account.hover
  expect(@home_page.my_account.text).to eql('Minha conta')
end

Dado('aplico o cupom de desconto {string}') do |string|
  @checkout_start_page = CheckoutStart.new
  @checkout_start_page.btn_cupom.click
  @checkout_start_page.inpt_cupom.set('NOVA1011')
  @checkout_start_page.btn_apply_cupom.click
  expect(@checkout_start_page.subtotal.text[2..7].to_f / 100 * 10).to eql(@checkout_start_page.desconto.text[4..7].to_f)
  @valor_do_produto_com_desconto = @checkout_start_page.total_price.text
end

E('validar que o valor de desconto do cupom foi aplicado com sucesso') do
  total = @valor_do_produto_com_desconto[2..6].to_f + @checkout_success_page.frete.text[2..6].to_f
  expect(@checkout_success_page.prices.last.text[2..6].to_f).to eql(total)
end