# Robot Framework - Automação

Este projeto tem o objetivo de definir um template para você que tem interesse em automatizar e não sabe por onde começar. Possui uma estrutura simples (Page Objects) e que é muito utilizada no mercado.

## Instalação

Robot framework precisa do [Python](https://www.python.org/downloads/) v3.10.2+ para executar.

#### Após esses abaixo procedimentos é necessário reiniciar a máquina

>Caso tenha que executar testes WEB, instale o [Chromedriver](https://chromedriver.chromium.org/downloads) 
Salve o arquivo no diretório "C:\chromedriver"
Insira o mesmo caminho na variável de ambiente Path [Como incluir variáveis de sistema no Windowns, Linux e MacOS](https://www.java.com/pt-BR/download/help/path_pt-br.html)


Após instalar o Python, execute os seguintes comandos (é necessário executar em sequência e na pasta do projeto)

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

E para gerar um relatório bonito utilize o Report do Metrics (será gerado um arquivo html na pasta -vale lembrar que é necessário ser no mesmo local onde executou os testes-, executando:

> robotmetrics"

## Esteira de testes automatizados CI (Continuous Integration) utilizando o próprio Github

Foi desenvolvido um script para que possa ser executado os cenários de testes de forma automática ou programável.

## Estrutura de pastas

<pre>
📦template-robotframework  
 ┣ 📂\AutomacaoWeb
 ┃ ┣ 📂resources  
  ┃ ┃ ┣ 📜Page_Elements_Login.robot (irá armazenar todos os elementos das páginas de login, caso precise de outra página é necessário criar outro arquivo como esse)
 ┃ ┣ 📂resources  
  ┃ ┃ ┣ 📜KD_Login.robot (todos as keywords referentes a essa página de login, caso precise de outra página é necessário criar outro arquivo como esse)
  ┃ ┣ 📂utils
   ┃ ┃ ┣ 📜KD_Base.robot (arquivo que possui keywords principais como: Abrir navegador e Fechar navegador)
   ┃ ┃ ┣ 📜KD_Help.robot (todas as keywords que ajudam a criar casos de teste de maneira mais eficiente e com código limpo)
 ┃ ┣ 📂variables 
  ┃ ┃ ┗ 📜variables_url_pages.robot (as variáveis do ambiente, como a URL)
 ┃ ┣ 📂tests  
 ┃ ┃ ┣ 📜Login.robot (teste propriamente dito utilizando o Gherkin como forma de escrita)
 ┃ ┗ 📂.github  
 ┃   ┣ 📂workflows  
 ┃     ┗ 📜robot-ci.yml (modelo de CI para testes E2E em uma esteira de desenvolvimento)
 ┣ 📜.gitignore  (arquivo para ignorar extensões espeficas que não indicado subir no repositório)
 ┣ 📜requirements.txt (arquivo de gerenciamento de dependencia do robot, tudo o que é necessário para o teste executar)
 ┗ 📜README.md  (arquivo de documentação do projeto)
 </pre>
     
#### Material de apoio

[Documentação Python](https://docs.python.org/3/)
[Documentação Robot Framework](https://robotframework.org/)
[Documentação Report Metrics](https://github.com/adiralashiva8/robotframework-metrics)
