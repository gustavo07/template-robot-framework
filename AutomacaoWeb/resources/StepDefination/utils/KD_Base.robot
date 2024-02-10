***Settings***
Documentation
Library     SeleniumLibrary
Resource    ../../Variables/variables_url_pages.robot
Resource    KD_Help.robot


*** Keywords ***
#### Setup e Teardown

Abrir navegador   
    ${chrome_options}=    Evaluate    
      ...    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    # Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Set Window Size             1366     768

Fechar navegador
    Close Browser
    Adicionar arquivos no PDF

