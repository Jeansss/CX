Before do |scenario|
  page.driver.browser.manage.window.maximize if ENV['BROWSER'].eql?('chrome')
  @tags = scenario.tags.last.name
end

After do |scenario|
  if  ENV['BROWSER'].eql?('chrome')
    nome_cenario = scenario.name.gsub(/[^A-Za-z0-9 ]/, '')
    nome_cenario = nome_cenario.tr(' ', '_').downcase!
    screenshot = "log/screenshots/#{nome_cenario}.png"
    page.save_screenshot(screenshot)
    # embed(screenshot, 'image/png', 'Evidência')
    # attach_file('/Users/jean/automacao/api_ruby/CX/Desafio_QA_CargoX_Jean_Barros_da_Silva/WEB/test_report.html', screenshot)
  end
  Capybara.current_session.driver.quit
end

  at_exit do
    ReportBuilder.input_path = File.dirname(__FILE__) + "/log/features.json"
    ReportBuilder.configure do |config|
      config.report_path = 'results/report'
      config.report_types = [:json, :html]
    options = {
      report_title: "Smoke Testing"
    }
    ReportBuilder.build_report options
  end
end