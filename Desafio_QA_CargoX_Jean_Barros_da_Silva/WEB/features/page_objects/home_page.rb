class Home < SitePrism::Page

  # set_url ''

  element :div_account, '.js-utilities-item > :nth-child(1)'
  element :my_account, '.js-subutility-list > :nth-child(1) a'
  elements :products, '.swiper-slide .js-item-product'
  elements :addProducts, '.item-actions .js-addtocart:nth-child(2)'
  element :viewCart, '.d-none .js-modal-open'
  element :finishOrder, '.btn-primary[name=go_to_checkout]'
  element :price_product, '.js-ajax-cart-total'
end
