# ViaSat Monitor

Projeto desenvolvido no Inatel App Challenge 2023.
Baixar executável: (em breve)


## 📋 Pré-requisitos (rodar como desenvolvedor)

BACKEND<br />
Rodar o backend (na pasta com o traffic_analyzer.py)
Importar de https://github.com/Viasat/Viasat-NetworkTrafficMeter/tree/main
```
pip install -r requirements.txt
```
Baixar https://npcap.com/#download
Para rodar o backend
```
python.exe traffic_analyzer.py
```
<br />
FRONTEND<br />
Flutter devidamente instalado, teste com:
```
flutter doctor
```
Para rodar o app
```
flutter pub get
```
```
flutter run -d windows
```


## 🛠️ Construído com

* [Flutter/Dart](http://www.dropwizard.io/1.0.2/docs/) - Tecnologia para desenvolvimento e funcionamento do App
* [Python](https://maven.apache.org/) - Backend fornecido pela ViaSat
* [Hive](https://rometools.github.io/rome/) - Banco de dados chave-valor


## 📋 Funcionalidades

- HomePage: Conta com medidor de gasto geral, medidores de velocidade (download,upload,ping) e o gasto individual por processo. Além de possibilitar navegação para as outras telas.
- AppPage: Análise individual dos gastos de cada app, mostrando o gasto total, de upload e download além de um gráfico que mostra o crescimento do gasto total.
- ConfigPage: Mostra a situação atual do plano, além de possuir funcionalidades para gerenciar melhor os créditos. 
- DetailsPage: Analise de gasto da internet de acordo com o host e de acordo com os protocolos.
- FranquisePage: Planos de internet (ViaSat) disponiveis. Também possibilita a seleção do plano utilizado. 
- HistoryPage: Histórico de todos os testes de velocidade realizados pelo app.


## ⚙️ Estruturação
IAC/<br />
  ├── lib/<br />
  │   ├── main.dart  - Inicialização e configuração de rotas internas<br />
  │   ├── models/    - Modelos para consumo e estruturação de dados<br />
  │   ├── services/  - Integrações com banco de dados e porta socket<br />
  │   ├── screens/   - Telas do aplicativo<br />
  │   ├── widgets/   - Modularização de alguns Widgets usados nas Screens<br />
  │   ├── constants/ - Constantes para utilização dos icones<br />
  │   ├── helpers/ - Algumas funções de conversão e outras utilidades<br />
  ├── assets/<br />
  │   ├── images/    - Images usadas nas telas<br />
  │   ├── icons/     - Icones que representam os processos<br />
  ├── windows/       - Alguns configurações para o app desktop<br />
  └── ...            - Outras pastas não desenvolvidas<br />


## ✒️ Autores

* **Francisco Pereira Guimarães** - [FranciscoPGuimaraes](https://github.com/linkParaPerfil)
* **Gabriel de Souza Siqueira** - [gabrielss2406](https://github.com/FranciscoPGuimaraes)
