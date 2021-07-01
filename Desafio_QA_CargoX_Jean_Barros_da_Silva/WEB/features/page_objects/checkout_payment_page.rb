class CheckoutPayment < SitePrism::Page
  
  element :paymentCustom, '#radio-option-custom'
  element :paymentCustomMX, '#radio-option-cash_on_delivery-custom'
  element :noteText, 'textarea[name=note-text]'
  element :closeOrder, '.btn-primary'

end
