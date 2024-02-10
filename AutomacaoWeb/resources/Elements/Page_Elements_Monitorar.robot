***Settings***
Documentation       Aqui temos o mapeamento dos elementos e localizadores separado por telas

*** Variables ***
${REGIAO}                           São Paulo
${MENU_MONITORAR}                   id:menu-monitorar
${MENU_MONITORAR_ROTEIRO}           xpath:.//a[@href="/roteiroNovo/roteirosDia" and @role="menuitem"]
${SELECT_REGIAO}                    xpath://*[@id="roteiroAction"]/div/div/div
${OPCAO_SELECT_REGIAO}              xpath:.//div[contains(text(),'${REGIAO}')]
${BTN_SELECT_ALL}                   xpath:.//button[contains (@onclick, 'selectAll()')]
${BTN_CALCULAR_ROTEIRO}             xpath:.//button[contains (@onclick, 'calcularRoteiro()')]
${BTN_SALVAR_ROTEIRO}               xpath:.//button[contains (@onclick, 'salvarRoteiroSubmit()')]
