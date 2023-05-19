# ViaSat Monitor

Projeto desenvolvido no Inatel App Challenge 2023.

## 🛠️ Construído com

* [Flutter/Dart](http://www.dropwizard.io/1.0.2/docs/) - Tecnologia para desenvolvimento e funcionamento do App
* [Python](https://maven.apache.org/) - Backend fornecido pela ViaSat
* [Hive](https://rometools.github.io/rome/) - Banco de dados chave-valor


## 📋 Funcionalidades

- HomePage: Conta com medidor de gasto geral, medidores de velocidade (download,upload,ping) e o gasto individual por processo.
- AppPage: Análise individual dos gastos de cada app, mostrando o gasto total, de upload e download além de um gráfico que mostra o crescimento do gasto total.
- ConfigPage: Mostra a situação atual do plano, além de possuir funcionalidades para gerenciar melhor os créditos. 
- DetailsPage: Analise de gasto da internet de acordo com o host e de acordo com os protocolos.
- FranquisePage: Planos de internet (ViaSat) disponiveis. Também possibilita a seleção do plano utilizado. 


## ⚙️ Estruturação
IAC/<br />
  ├── lib/<br />
  │   ├── main.dart  - Inicialização e configuração de rotas internas<br />
  │   ├── models/    - Modelos para consumo e estruturação de dados<br />
  │   │   └── ...<br />
  │   ├── services/  - Integrações com banco de dados e porta socket<br />
  │   │   └── ...<br />
  │   ├── screens/   - Telas do aplicativo<br />
  │   │   └── ...<br />
  │   ├── widgets/   - Modularização de alguns Widgets usados nas Screens<br />
  │   │   └── ...<br />
  │   ├── constants/ - Constantes para utilização dos icones<br />
  │   │   └── ...<br />
  │   ├── helpers/ - Algumas funções de conversão e outras utilidades<br />
  │   │   └── ...<br />
  │   └── ...<br />
  ├── assets/<br />
  │   ├── images/    - Images usadas nas telas<br />
  │   ├── icons/     - Icones que representam os processos<br />
  │   └── ...<br />
  ├── windows/       - Alguns configurações para o app desktop<br />
  └── ...            - Outras pastas que não desenvolvidas<br />


## ✒️ Autores

Mencione todos aqueles que ajudaram a levantar o projeto desde o seu início

* **Francisco Pereira Guimarães** - [FranciscoPGuimaraes](https://github.com/linkParaPerfil)
* **Gabriel de Souza Siqueira** - [gabrielss2406](https://github.com/FranciscoPGuimaraes)
