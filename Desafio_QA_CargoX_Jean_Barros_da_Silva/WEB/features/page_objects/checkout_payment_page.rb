class CheckoutPayment < SitePrism::Page
    element :payment_custom, '#radio-option-custom'
    element :payment_boleto_paghiper, '#radio-option-boleto_paghiper_transparent_offline'
    element :payment_boleto_mercadopago, '#radio-option-mercadopago_transparent_offline'
    element :payment_boleto_nuvempago, '#radio-option-nuvempago_transparent_boleto'
    element :payment_pix_mercadopago, '#radio-option-mercadopago_transparent_pix'
    element :payment_pix_nuvempago, '#radio-option-nuvempago_transparent_pix'
    element :payment_payU, '#radio-option-payu_redirect'
    element :txt_note, 'textarea[name=note-text]'
    element :brn_order, '.btn-primary'

    def select_payment_option(payment_option)
      if payment_option.eql?('custom')
        self.wait_until_payment_custom_visible(wait: 22)
        self.payment_custom.click unless self.payment_custom['class'].eql?('radio payment-option active')
      elsif payment_option.eql?('boleto_paghiper')
        self.wait_until_payment_boleto_paghiper_visible(wait: 22)
        self.payment_boleto_paghiper.click unless self.payment_boleto_paghiper['class'].eql?('radio payment-option active')
      elsif payment_option.eql?('boleto_mercadopago')
        self.wait_until_payment_boleto_mercadopago_visible(wait: 22)
        self.payment_boleto_mercadopago.click unless self.payment_boleto_mercadopago['class'].eql?('radio payment-option active')
      elsif payment_option.eql?('boleto_nuvempago')
        self.wait_until_payment_boleto_nuvempago_visible(wait: 22)
        self.payment_boleto_nuvempago.click unless self.payment_boleto_nuvempago['class'].eql?('radio payment-option active')
      elsif payment_option.eql?('pix_mercadopago')
        self.wait_until_payment_pix_mercadopago_visible(wait: 22)
        self.payment_pix_mercadopago.click unless self.payment_pix_mercadopago['class'].eql?('radio payment-option active')
      elsif payment_option.eql?('pix_nuvempago')
        self.wait_until_payment_pix_nuvempago_visible(wait: 22)
        self.payment_pix_nuvempago.click unless self.payment_pix_nuvempago['class'].eql?('radio payment-option active')
      end
    end

    def close_order
      self.txt_note.set('ok')
      self.brn_order.click
    end

end
