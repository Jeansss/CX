class Account < SitePrism::Page
    element :login, "#login-form  input[name='email']"
    element :password, "#login-form input[type='password']"
    element :btn_login, "#login-form .btn[type='submit']"
end