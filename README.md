# 🚀 N2: Protótipo de Aplicativo para Chamada Automatizada

Este projeto é um protótipo funcional de um aplicativo móvel para automatização da chamada em sala de aula, desenvolvido como parte da avaliação N2.

## 🎯 Objetivo do Projeto

[cite_start]O objetivo principal é projetar e modelar um aplicativo móvel que automatize o registro de presença dos alunos, sem a necessidade de intervenção manual do professor[cite: 6].

[cite_start]O protótipo da N2 foca em entregar uma aplicação funcional no emulador Android [cite: 7][cite_start], simulando 4 rodadas de chamada por noite [cite: 8] e implementando a lógica de negócio principal, incluindo a persistência de dados local e a simulação da automação das chamadas.

## 🛠️ Tecnologias Utilizadas

* [cite_start]**Flutter** [cite: 2]
* [cite_start]**Dart** [cite: 2]
* [cite_start]**VS Code** [cite: 2] (como IDE)
* [cite_start]**Android Emulator** [cite: 2] (para execução e testes)
* **Provider** (para gerenciamento de estado)
* **Shared Preferences** (para persistência local de dados)

## 💻 Como Executar o Protótipo

**Pré-requisitos:**
* Ter o [SDK do Flutter](https://flutter.dev/docs/get-started/install) instalado.
* Ter o Android Studio instalado com um Emulador Android configurado.

**Passos:**

1.  Clone este repositório:
    ```bash
    git clone [URL_DO_SEU_REPOSITORIO]
    ```

2.  Navegue até a pasta do projeto:
    ```bash
    cd chamada_automatizada_n10
    ```

3.  Instale as dependências:
    ```bash
    flutter pub get
    ```

4.  Gere os arquivos de serialização (necessário para a persistência):
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  Inicie o Emulador Android.

6.  Execute o aplicativo:
    ```bash
    flutter run
    ```

## 👥 Equipe (Grupo N2/N3)

* **Heloísa Rebello Cabral**
* **Heitor Reis**
* **Henrique Xavier**
* **Lucas Rogério Mendonça**
* **Rodrigo Xavier**
