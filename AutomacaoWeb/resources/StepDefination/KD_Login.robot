*** Settings ***
Library     SeleniumLibrary
Resource    ../Variables/variables_user_pass.robot
Resource    ../Elements/Page_Elements_Login.robot
Resource    utils/KD_Help.robot


*** Keywords ***
que eu estou no saucedemo
    Go To    ${URL_BASE}
    Tirar print da tela

insiro os dados de usuario e senha
    [Arguments]    ${User}=    ${Pass}=
    Digitar no elemento    ${TXT_USERNAME}    ${User}
    Digitar no elemento    ${TXT_PASSWORD}    ${Pass}
    Tirar print da tela
    Clicar no elemento    ${BTN_LOGIN}

verifico se estou logado no sistema
    Title Should Be    Swag Labs
    Page Should Contain    Swag Labs
    Tirar print da tela

verifico se nao estou logado no sistema com usuario incorreto
    Validar texto do elemento    ${LBL_ERRO}    Epic sadface: Username and password do not match any user in this service
    Tirar print da tela

verifico se nao estou logado no sistema sem usuario
    Validar texto do elemento    ${LBL_ERRO}    Epic sadface: Username is required
    Tirar print da tela

verifico se nao estou logado no sistema usuario bloqueado
    Validar texto do elemento    ${LBL_ERRO}    Epic sadface: Sorry, this user has been locked out.
    Tirar print da tela