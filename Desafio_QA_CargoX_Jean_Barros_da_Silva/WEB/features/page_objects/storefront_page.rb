class Storefront < SitePrism::Page

  set_url ''

  element :div_account, '.js-utilities-item > :nth-child(1)'
  element :my_account, '.js-subutility-list > :nth-child(1) a'
  elements :products, '.swiper-slide .js-item-product'
  elements :addProducts, '.item-actions .js-addtocart:nth-child(2)'
  element :viewCart, '.d-none .js-modal-open'
  element :start_purchase, '.btn-primary[name=go_to_checkout]'
  element :subtotal, '.js-ajax-cart-total'

  def select_product(type)
    self.wait_until_products_visible(wait: 22)
    if type.eql?('fisico')
      self.products.first.hover
      self.addProducts.first.click
    else type.eql?('digital')
      self.products.last.hover
      self.addProducts.last.click
    end
  end

  def create_cart
    self.wait_until_viewCart_visible(wait: 22)
    self.viewCart.click
    price = self.subtotal.text
    self.start_purchase.click
    price
  end

  def verify_login
    checkout_success_page = CheckoutSuccess.new
    checkout_success_page.continue.click
    self.div_account.hover
  end

end
