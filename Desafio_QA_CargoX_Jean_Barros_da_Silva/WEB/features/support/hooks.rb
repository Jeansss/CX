Before do
  page.driver.browser.manage.window.maximize if ENV['BROWSER'].eql?('chrome')
  @login_page = Login.new
  @home_page = Home.new
  @tasks_page = Tasks.new
end

After do |scenario|
  if  ENV['BROWSER'].eql?('chrome')
    nome_cenario = scenario.name.gsub(/[^A-Za-z0-9 ]/, '')
    nome_cenario = nome_cenario.tr(' ', '_').downcase!
    screenshot = "log/screenshots/#{nome_cenario}.png"
    page.save_screenshot(screenshot)
    embed(screenshot, 'image/png', 'Evidência')
  end
  Capybara.current_session.driver.quit
end