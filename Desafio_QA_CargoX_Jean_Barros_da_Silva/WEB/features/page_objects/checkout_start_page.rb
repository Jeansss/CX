class CheckoutStart < SitePrism::Page

  element :inpt_email, 'input[type=email]'
  element :login, '.login-info a'
  element :btn_coupon, '.summary-details .box-discount-coupon-applied'
  element :inpt_coupon, '#coupon'
  element :btn_apply_cupom, "button[test-id='apply-coupon-btn']"
  element :subtotal, "td[test-id=cart-subtotal"
  element :discount, "td[test-id=cart-discount"

  element :inpt_postalcode, "input[id='shippingAddress.zipcode']"
  element :btn_next, 'div[data-testid=btnSubmitZipcode]'
  elements :shippings, '.shipping-method-item-name'
  elements :shipping_options, '.shipping-options-ship .radio'
  element :withdraw, '.shipping-options-pickup'
  elements :withdraw_oca, '.shipping-options-pickup .radio'
  elements :select_suboption, '#shipping-suboption option'
  element :select_country, "select[id='shippingAddress.country']"
  elements :countries, "select[id='shippingAddress.country'] option"

  element :name, "input[id='shippingAddress.first_name']"
  element :last_name, "input[id='shippingAddress.last_name']"
  element :phone, "input[id='shippingAddress.phone']"

  element :shipping_address, "input[id='shippingAddress.address']"
  element :shipping_number, "input[id='shippingAddress.number']"
  element :shipping_complement, "input[id='shippingAddress.floor']"
  element :shipping_reference , "input[id='shippingAddress.reference']"
  element :betweenStret, "input[id='shippingAddress.between_streets']"
  element :shippingNeighborhood, "input[id='shippingAddress.locality']"
  element :shippingCity, "input[id='shippingAddress.city']"
  element :shippingPostalCode, "input[name='shippingAddress.zipcode']"
  element :shippingState, "select[id='shippingAddress.state']"
  element :inptShippingState, "input[id='shippingAddress.state']"

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
  element :total_price, "td[test-id='cart-total']"
  element :btnContinue, 'button[type=submit]'

  
  def search_shipping_option(zipcode)
    self.inpt_postalcode.set(zipcode)
    self.btn_next.click
  end

  def select_shipping_option(shipping_option)
    self.shippings.each do |option|

      break option.click if option.text.eql?(shipping_option)
    end

    if shipping_option.eql?('OCA Estándar - Retirar por una sucursal de OCA')
      self.wait_until_select_suboption_visible
      self.select_suboption[1].click
    end
  end

  def enter_consumer_data(phone)
    self.name.set('test')
    self.last_name.set('last')
    self.phone.set(phone)
  end

  def enter_shipping_data(country)
      self.wait_until_shipping_address_visible(wait: 20)
      case country
      when 'br'
        self.shipping_address.visible?
        self.shipping_number.visible?
        self.shipping_complement.visible?
        self.shippingNeighborhood.visible?
        self.shippingCity.visible?
        self.shippingPostalCode.visible?
        self.shippingState.visible?
        self.shipping_number.set('5555')
      when 'ar'
        self.shipping_address.set('Fake')
        self.shipping_number.set('2333')
        self.shipping_complement.set('fake')
        self.shippingNeighborhood.set('fake')
        self.shippingCity.set('fake')
        self.shippingPostalCode.visible?
        self.shippingState.visible?
      when 'mx'
        self.shipping_address.set('Fake')
        self.shipping_number.set('2333')
        self.shipping_complement.set('fake')
        self.shipping_reference.set('fake')
        self.betweenStret.set('fake')
        self.shippingNeighborhood.set('fake')
        self.shippingCity.set('fake')
        self.shippingPostalCode.visible?
        self.shippingState.visible?
      end
    end

    def enter_billing_data(phone, zipcode, document, country)
        self.billingName.set('test')
        self.billingLastName.set('test')
        self.billingPhone.set(phone)
      case country
      when 'br'
        self.billingPostalCode.set(zipcode)
        self.billingNumber.set('12')
      when 'ar', 'mx'
        self.billingAddress.set('Fake')
        self.billingNumber.set('122')
        self.billingComplement.set('Fake')
        self.billingNeighborhood.set('Fake')
        self.billingCity.set('Fake')
        self.billingPostalCode.set(zipcode)
        self.billingState.visible?
      end
    end

    def next_checkout_step(document)
      self.wait_until_billingIdDoc_visible(wait: 26)
      self.billingIdDoc.set(document)
      self.btnContinue.click
    end

    def fill_in_deliverable_product_form(country, shipping_option)
      self.search_shipping_option(MASSA['data'][country]['zipcode'])
      self.select_shipping_option(shipping_option)
      self.enter_consumer_data(MASSA['data'][country.to_s]['phone'])
      self.enter_shipping_data(country)
      self.next_checkout_step(MASSA['data'][country]['document'])
    end

    def fill_in_withdrawal_form(country, shipping_option)
      self.search_shipping_option(MASSA['data'][country]['zipcode'])
      self.select_shipping_option(shipping_option)
      self.enter_billing_data(MASSA['data'][country.to_s]['phone'], MASSA['data'][country]['zipcode'], MASSA['data'][country]['document'], country)
      self.next_checkout_step(MASSA['data'][country]['document'])
    end

    def fill_in_digital_form(country)
      self.enter_billing_data(MASSA['data'][country.to_s]['phone'], MASSA['data'][country]['zipcode'], MASSA['data'][country]['document'], country)
      self.next_checkout_step(MASSA['data'][country]['document'])
    end

    def apply_discount_coupon
      self.btn_coupon.click
      self.inpt_coupon.set('NOVA1011')
      self.btn_apply_cupom.click
    end

end
