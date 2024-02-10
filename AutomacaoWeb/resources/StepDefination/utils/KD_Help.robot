*** Settings ***
Documentation       Aqui temos a alguns métodos genéricos para desenvolver scripts

Library             SeleniumLibrary
Library             RPA.PDF
Library             String
Library             Collections
Resource            KD_Base.robot
Library             BuiltIn
Library             OperatingSystem
Library             DateTime


*** Variables ***
${tempo_espera}     30s
${i}                0


*** Keywords ***
Clicar no elemento
    [Arguments]    ${elemento}

    Wait Until Element Is Visible
    ...    ${elemento}
    ...    ${tempo_espera}
    ...    Elemento ${elemento} não é visivél após ${tempo_espera} segundos.
    Scroll Element Into View    ${elemento}
    Click Element    ${elemento}

Clicar no elemento utilizando a DOM
    [Arguments]    ${elemento}    ${code_javascript}

    Wait Until Element Is Visible
    ...    ${elemento}
    ...    ${tempo_espera}
    ...    Elemento ${elemento} não é visivél após ${tempo_espera} segundos.

    Wait Until Keyword Succeeds
    ...    5 times
    ...    3s
    ...    Execute Javascript    ${code_javascript}

Digitar no elemento
    [Arguments]    ${elemento}    ${valor_texto}
    Wait Until Element Is Visible
    ...    ${elemento}
    ...    ${tempo_espera}
    ...    Elemento ${elemento} não é visivél após ${tempo_espera} segundos.
    Scroll Element Into View    ${elemento}
    Input Text    ${elemento}    ${valor_texto}

Validar texto do elemento
    [Documentation]    Este método é utilizado para validar o texto de um elemento na tela do sistema
    [Arguments]    ${elemento}    ${texto}
    Wait Until Element Is Visible    ${elemento}
    ${textoElemento}=    Get Text    ${elemento}
    Should Be True    '${textoElemento}' == '${texto}'    Texto comparado não são iguais

Adicionar arquivos no PDF
    ${files}=    Create List
    Set Test Variable    ${cont}    1
    WHILE    ${i} > 0
        Append To List    ${files}    ${TEST TAGS}[0]\\${TEST TAGS}[1]\\Passo-${cont}.png
        ${i}=    Evaluate    ${i} - 1
        ${cont}=    Evaluate    ${cont} + 1
    END
    Add Files To PDF    ${files}    ${TEST TAGS}[0]\\${TEST TAGS}[1]\\${TEST NAME}.pdf
    Log To Console    ${i}

Tirar print da tela
    ${i}=    Evaluate    ${i} + 1
    Capture Page Screenshot    ${TEST TAGS}[0]\\${TEST TAGS}[1]\\Passo-${i}.png
    Set Test Variable    ${i}    ${i}
