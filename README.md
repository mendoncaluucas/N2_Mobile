# 🚀 Chamada Automatizada (N3)

> **Avaliação N3 - Desenvolvimento Mobile**
> Aplicativo para automatização de controle de presença em sala de aula, com persistência local, sincronização em nuvem e exportação de relatórios.

---

## 📱 Sobre o Projeto

Este aplicativo foi desenvolvido para solucionar o problema de chamadas manuais em sala de aula. Ele simula um sistema automático que gerencia **4 rodadas de chamada** por noite, permitindo que o aluno registre presença apenas dentro da janela de tempo correta.

O projeto atende aos requisitos da **Nota 10**, incluindo:
1.  **Persistência Local:** Dados salvos no dispositivo (funciona offline).
2.  **Sincronização Nuvem:** Envio em tempo real para o **Firebase Firestore**.
3.  **Relatórios:** Geração e compartilhamento de arquivo **CSV** real.
4.  **Lógica de Falta:** Detecção automática de ausência caso a rodada encerre sem registro.

---

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** Dart
* **Framework:** Flutter (Material Design 3)
* **Gerenciamento de Estado:** Provider
* **Banco de Dados (Nuvem):** Firebase Firestore
* **Persistência Local:** Shared Preferences
* **Exportação:** Path Provider & Share Plus
* **Serialização:** JSON Serializable & Build Runner

---

## ✨ Funcionalidades Principais

### 1. Automação de Rodadas
- O sistema gerencia 4 horários (Ex: 19:00, 19:50, 20:40, 21:30).
- Mudança visual de status: **Aguardando** (Cinza), **Em Andamento** (Azul), **Encerrada** (Vermelho/Verde).

### 2. Registro de Presença Híbrido
- O aluno clica em "PRESENTE".
- O dado é salvo instantaneamente no celular (Local).
- O dado é enviado para a coleção `presencas` no Firebase (Nuvem).

### 3. Detecção de Falta
- Se a rodada encerra e o aluno não clicou no botão, o sistema envia automaticamente um registro de **FALTA** para o banco de dados.

### 4. Exportação de CSV (Nota 9)
- Gera um arquivo `.csv` com o histórico completo.
- Colunas detalhadas: `student_id`, `date`, `round`, `status`, `validation_method`.
- Integração com WhatsApp, Drive, Gmail, etc.

---

## 📸 Capturas de Tela

| Painel Principal | Histórico | Exportação CSV |
|:---:|:---:|:---:|
| | | |
| *Controle das 4 Rodadas* | *Log Diário* | *Compartilhamento* |

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos
* Flutter SDK instalado.
* Dispositivo Android (Físico ou Emulador) configurado.
* Git instalado.

### Passo a Passo

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/chamada_automatizada_n10.git](https://github.com/seu-usuario/chamada_automatizada_n10.git)
    cd chamada_automatizada_n10
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Gere os arquivos de modelo (se necessário):**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

---

## 📂 Estrutura do Projeto

A organização segue o padrão MVC/Service:

* `lib/models/`: Modelos de dados (`Rodada`).
* `lib/screens/`: Telas do aplicativo (`Dashboard`, `Export`, `History`).
* `lib/services/`: Lógica de negócio, Timer e conexão com Firebase (`ChamadaService`).
* `lib/main.dart`: Configuração de rotas, tema e inicialização.

---

## 👥 Autores

Trabalho desenvolvido pela equipe:

* **[Lucas Mendonça]**
* **[Heloisa Rebello Cabral]**
* **[Henrique Xavier]**
* **[Rodrigo Xavier]**
* **[Heitor Reis]**

---

> Projeto desenvolvido para fins acadêmicos - 2025.
