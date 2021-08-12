class PayU < SitePrism::Page

    element :div_payU_test, '.test-mode-notice-box'
    element :master_card, 'li #pm-MASTERCARD'
    element :master_option, '#pm-sub-franchise-MASTERCARD'
    element :card_number, '#ccNumber'
    element :expiration_month, '#expirationDateMonth'
    elements :option_month, '#expirationDateMonth option'
    element :expiration_year, '#expirationDateYear'
    elements :option_year, '#expirationDateYear option'
    element :cvv, '#securityCode'
    element :card_name, '#cc_fullName'
    element :doc_dni, '#cc_dniNumber'
    element :fone, '#contactPhone'
    element :pay, '#buyer_data_button_pay'
    element :alert_aprovado, '.bg_APPROVED'

end