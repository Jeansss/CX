class Admin < SitePrism::Page
  element :inpt_email, '.input-group-lg #user-mail'
  element :inpt_password, '.input-group-lg #pass'
  element :btn_login, '.m-top .btn'
  element :a_sales, '.ajax-container-load  a[title="Vendas" ].js-show-placeholder'
  element :order_list, '#order-table .js-order-table-body .p-bottom-quarter-xs'

end