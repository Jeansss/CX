class CheckoutSuccess < SitePrism::Page
  
  element :orderId, 'div[test-id=order-id]'
  elements :orderSuccess, '.history-item-title'
  elements :prices, '.summary.d-none .summary-details .table-price'
  elements :shipping_option, ".m-top p[test-id='shipping-option']"
  element :continue, '.headbar a.headbar-continue'
  element :frete, "td[test-id='cart-shipping-cost']"


end
