*** Settings ***
Documentation       Suite dos testes - login

Resource            ../resources/StepDefination/utils/KD_Base.robot
Resource            ../resources/StepDefination/KD_Login.robot

Test Setup          Abrir navegador
Test Teardown       Fechar navegador


*** Test Cases ***
Realizo o acesso do sistema - usuario valido
    [Tags]    realizar login    usuario valido
    Given que eu estou no saucedemo
    When insiro os dados de usuario e senha    standard_user    secret_sauce
    Then verifico se estou logado no sistema

Realizo o acesso do sistema - usuario e senha invalido
    [Tags]    realizar login    usuario invalido
    Given que eu estou no saucedemo
    When insiro os dados de usuario e senha    test_user    test_pass
    Then verifico se nao estou logado no sistema com usuario incorreto

Realizo o acesso do sistema - sem usuario e senha
    [Tags]    realizar login    sem usuario
    Given que eu estou no saucedemo
    When insiro os dados de usuario e senha
    Then verifico se nao estou logado no sistema sem usuario

Realizo o acesso do sistema - usuario bloqueado
    [Tags]    realizar login    usuario bloqueado
    Given que eu estou no saucedemo
    When insiro os dados de usuario e senha    locked_out_user    secret_sauce
    Then verifico se nao estou logado no sistema usuario bloqueado
