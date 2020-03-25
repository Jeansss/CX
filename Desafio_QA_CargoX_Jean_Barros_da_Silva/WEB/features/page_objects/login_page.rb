class Login < SitePrism::Page
  set_url 'https://demo.suiteondemand.com/'

  element :inpt_username, '#user_name'
  element :inpt_password, '#username_password'
  element :btn_login, '#bigbutton'
end
