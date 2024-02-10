# Robot Framework - Automação

Um framework para realizar automação de WEB e Mainframe

## Instalação

Robot framework precisa do [Python](https://www.python.org/downloads/) v3.10.2+ para executar.

#### Após esses abaixo procedimentos é necessário reiniciar a máquina

>Caso tenha que executar testes MAINFRAME, instale o [wc3270](https://x3270.miraheze.org/wiki/Downloads), escolha pelo arquivo executável.
Salve o programa na pasta "C:\Program Files\wc3270"
Insira o mesmo caminho na varíavel de ambiente chamada Path.

>Caso tenha que executar testes WEB, instale o [Chromedriver](https://chromedriver.chromium.org/downloads) 
Salve o arquivo no diretório "C:\chromedriver"
Insira o mesmo caminho na variável de ambiente Path


Após instalar o Python, instale as seguintes dependentes com os comandos.
Execute esses comandos na pasta do projeto.

```sh
python --version 
```

```sh
pip install -r requirements.txt
```

Para verificar se as bibliotecas foram instaladas com sucesso, execute o comando:
```sh
pip list
```

## Executando o projeto local

Para executar o projeto basta abrir o CMD (prompt de comando) na pasta \test do projeto 
Executar o comando

> robot nome_do_arquivo.robot

E para gerar o Report do Metrics

> robotmetrics -M regression_metrics.html --logo "https://www.aberje.com.br/wp-content/uploads/2021/04/Novo_Logo_Via_Varejo1.jpg"

## Executando o automação WEB no git action 

Docker Action para execução dos testes automatizado WEB utilizando o Robot-Framework . A action só executa os testes para branch informada no inputs.

## Usage
```yaml
  - uses: actions/checkout@master
  - name: Service Test
    uses: /convair-actions/robot-framework
    with:
      branch: Teste-Robot
      teste_robot: './tests/AutomacaoWeb/tests/TestWeb.robot'
      stopPipeline: 'YES'
```

## Inputs
* `branch`: Obrigatório. Nome da branch que vc deseja disparar o Action, sempre que tiver um commit para essa brach o Action vai ser executado.
* `teste_robot`: Obrigatório. Caminho até o arquivo de execução dos teste no repositório.
* `stopPipeline`: Opcional. Valor default: YES. Se testes falharem, retorna saída 1, o que parará a esteira de ci/cd.
* `waitingTime`: Opcional. Valor default: 2m. Tempo de espera (em minutos) antes de começar a executar os testes. Pode ser útil quando necessário esperar pela subida da aplicação no host onde os testes foram programados para serem executados.

## Outputs
* `testReportPath`: Caminho do relatório html dos testes.

## Link do relatorio com gitpages
*  Seguir a documentação do gitpages https://docs.github.com/pt/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site
*  Se o reporte não tiver um index apos pegar a URL do git pages colocar o nome do arquivo exemplo pages.github.io/report.html

## Workflow Example
```yaml
name: Service Testing
on:
  push:
  workflow_dispatch:

env:
  SANDBOX_NAMESPACE: cargas
  SANDBOX_BRANCH: release/*
  
jobs:
  test-api:
    runs-on: self-hosted
    steps:

    - uses: actions/checkout@v2
    
    #Obtém as actions de Convair Actions
    - name: Checkout Convair Actions
      uses: actions/checkout@v2
      with:
        repository: viavarejo-internal/convair-actions
        token: ${{ secrets.ACTIONS_TOKEN }}
        path: ./.convair-actions
        ref: main
    
    #Sobe aplicação para sit para que os testes de serviço sejam exacutados nesse ambiente
    - name: AKS Sandbox Deploy
      uses: ./.convair-actions/aks-sandbox-deploy
      env:
        SHOULD_DEPLOY_SANDBOX: "YES"
      with:
        tool: kustomize
        projectNames: "${{ env.PROJECT_NAME }}"
        azureClientId: ${{ secrets.AZURE_CLIENT_ID }}
        azureClientSecret: ${{ secrets.AZURE_CLIENT_SECRET }}
        azureTenantId: ${{ secrets.AZURE_TENANT_ID }}
        namespaceSuffix: "-sit"
        sandboxPath: kustomize/base
        restrictedBranches: "${{ env.SANDBOX_BRANCH }}"
    
    #Executa os testes de serviço
    - name: Service Test Robot
      id: servicetestrobot
      uses: ./.convair-actions/robot-framework
      with:
        branch: Teste-Robot
        teste_robot: './tests/AutomacaoWeb/tests/TestWeb.robot'
        stopPipeline: 'YES'
    
    #Salva o relatório dos testes como artefato
    - name: Upload as Artifact the test html report
      uses: actions/upload-artifact@v2
      if: always()
      with:
        name: test-report
        path: ${{ steps.servicetestrobot.outputs.testReportPath }}
        if-no-files-found: ignore
        retention-days: 30
        
    #Salva o relatório dos testes em uma outra brach do git page e ele ja fica diponivel na web para todos que tiver o link  
    - name: Deploy report to Github Pages
      if: always()
      uses: peaceiris/actions-gh-pages@v2
      env:
        PERSONAL_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        PUBLISH_BRANCH: gh-pages
        PUBLISH_DIR: testResults         
```        
## Estrutura de pastas

<pre>
📦template-robotframework  
 ┣ 📂\AutomacaoWeb  
 ┃ ┣ 📂resources  
 ┃ ┃ ┣ 📜base.robot 
 ┃ ┃ ┣ 📜elements.robot
 ┃ ┃ ┣ 📜kws.robot
 ┃ ┃ ┗ 📜resource.robot   
 ┃ ┣ 📂tests  
 ┃ ┃ ┣ 📜config.robot 
 ┃ ┃ ┣ 📜package.json
 ┃ ┃ ┣ 📜package-lock.json
 ┃ ┃ ┣ 📜Testweb.robot
 ┃ ┃ ┗ 📂testResult
 ┃ ┃   ┣ 📜geckodriber-1.log
 ┃ ┃   ┣ 📜log.html
 ┃ ┃   ┣ 📜output.xml
 ┃ ┃   ┗ 📜report.html
 ┃ ┗ 📜requirements.txt 
 ┣ 📂\AutomacaoMainframe
 ┃ ┣ 📂resources  
 ┃ ┃ ┣ 📜elements.robot
 ┃ ┃ ┣ 📜kws.robot
 ┃ ┃ ┣ 📜resource.robot   
 ┃ ┃ ┗ 📜variables.robot 
 ┃ ┃ ┗ 📂Mainframe3270
 ┃ ┃    ┣ 📜__init__.py
 ┃ ┃    ┣ 📜py3270.py
 ┃ ┃    ┣ 📜version.py
 ┃ ┃    ┣ 📜x3270.p
 ┃ ┃    ┗ 📂robotframework_mainframe3270.egg-info
 ┃ ┃       ┣ 📜dependency_links.txt
 ┃ ┃       ┣ 📜PKG-INFO
 ┃ ┃       ┣ 📜SOURCES.txt
 ┃ ┃       ┗ 📜top_level.txt 
 ┃ ┣ 📂tests  
 ┃ ┃ ┣ 📜mainframe.robot
 ┃ ┃ ┗ 📂Result Test
 ┃ ┃   ┗ 📜output.xml
 ┃ ┣  📜requirements.txt  
 ┃ ┗ 📂.github  
 ┃   ┣ 📂workflows  
 ┃     ┗ 📜viaops.yml 
 ┣ 📜.gitignore  
 ┣ 📜requirements.txt
 ┗ 📜README.md  
 </pre>
     
#### Material de apoio

[Documentação Python](https://docs.python.org/3/)
[Documentação Robot Framework](https://robotframework.org/)
[Documentação WC3270 Emulador Mainframe](https://x3270.miraheze.org/wiki/Wc3270)
[Documentação Report Metrics](https://github.com/adiralashiva8/robotframework-metrics)
[Documentação Git Action](https://github.com/viavarejo-internal/convair-actions/tree/main/robot-framework)
