class Account < SitePrism::Page
  element :inpt_login, "#login-form  input[name='email']"
  element :inpt_password, "#login-form input[type='password']"
  element :btn_login, "#login-form .btn[type='submit']"

  def checkout_login
    checkout_start_page = CheckoutStart.new
    checkout_start_page.login.click
    self.inpt_login.set('jeanss@teststaging.com')
    self.inpt_password.set('nova1010')
    self.btn_login.click
    logado = true if ENV['ENV'].eql?('production')
  end

end