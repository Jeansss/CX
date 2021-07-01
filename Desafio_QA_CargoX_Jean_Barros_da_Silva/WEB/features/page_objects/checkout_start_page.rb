class CheckoutStart < SitePrism::Page

  element :inptEmail, 'input[type=email]'
  element :login, '.login-info a'
  element :btn_cupom, '.summary-details .box-discount-coupon-applied'
  element :inpt_cupom, '#coupon'
  element :btn_apply_cupom, "button[test-id='apply-coupon-btn']"
  element :subtotal, "td[test-id=cart-subtotal"
  element :desconto, "td[test-id=cart-discount"
  element :total_price, "td[test-id='cart-total']"

  element :postalCode, "input[id='shippingAddress.zipcode']"
  element :btnNext, 'div[data-testid=btnSubmitZipcode]'
  elements :shippingOption, '.shipping-options-ship .radio'
  element :pickup, '.shipping-options-pickup'
  elements :pickup_oca, '.shipping-options-pickup .radio'
  elements :select_suboption, '#shipping-suboption option'
  #chile
  element :country, "select[id='shippingAddress.country']"
  elements :countries, "select[id='shippingAddress.country'] option"

  #dados destinatário
  element :name, "input[id='shippingAddress.first_name']"
  element :lastName, "input[id='shippingAddress.last_name']"
  element :tel, "input[id='shippingAddress.phone']"

  #endereço do destinatário
  element :shippingAddress, "input[id='shippingAddress.address']"
  element :shippingNumber, "input[id='shippingAddress.number']"
  element :shippingComplement, "input[id='shippingAddress.floor']"
  element :shippingReference , "input[id='shippingAddress.reference']"
  element :betweenStret, "input[id='shippingAddress.between_streets']"
  element :shippingNeighborhood, "input[id='shippingAddress.locality']"
  element :shippingCity, "input[id='shippingAddress.city']"
  element :shippingPostalCode, "input[name='shippingAddress.zipcode']"
  element :shippingState, "select[id='shippingAddress.state']"
  element :inptShippingState, "input[id='shippingAddress.state']"

  #dados de cobrança
  element :billingIdDoc, "input[id='billingAddress.id_number']"
  element :billingName, "input[id='billingAddress.first_name']"
  element :billingLastName, "input[id='billingAddress.last_name']"
  element :billingPhone, "input[id='billingAddress.phone']"
  element :billingAddress, "input[id='billingAddress.address']"
  element :billingNumber, "input[id='billingAddress.number']"
  element :billingComplement, "input[id='billingAddress.floor']"
  element :billingNeighborhood, "input[id='billingAddress.locality']"
  element :billingCity, "input[id='billingAddress.city']"
  element :billingPostalCode, "input[id='billingAddress.zipcode']"
  element :billingState, "select[id='billingAddress.state']"
  element :billingStateInpt, "input[id='billingAddress.state']"
  element :billingCountry, "select[id='billingAddress.country']"
  elements :billingCountries, "select[id='billingAddress.country'] option"


  element :btnContinue, 'button[type=submit]'

end
