# DOCUMENTO DE IDENTIFICAÇÃO DA EQUIPE

## 1. IDENTIFICAÇÃO DA EQUIPE

### Integrantes do Grupo

1. **Lucas Mendonça**
2. **Heloisa Rebello Cabral**
3. **Henrique Xavier**
4. **Rodrigo Xavier**
5. **Heitor Reis**

### Informações do Projeto

- **Nome do Projeto:** Chamada Automatizada (N3)
- **Tema:** Aplicativo para automatização da chamada em sala de aula
- **API/Serviços Utilizados:** Firebase Firestore (Firebase Cloud Firestore)
- **Curso:** [PREENCHER: Nome do Curso]
- **Turma:** [PREENCHER: Número/Turma]
- **Período:** [PREENCHER: Período/Semestre]
- **Instituição:** [PREENCHER: Nome da Instituição]

### Confirmação de Grupo

Confirmamos que este é o mesmo grupo utilizado nas etapas N2 e N3 do projeto de Desenvolvimento Mobile.

---

## 2. FAIXA DE NOTA ALMEJADA

**Faixa de Nota Pretendida: 10 (dez)**

Justificativa: O projeto atende a todos os requisitos para a nota máxima, incluindo:
- ✅ Aplicativo funcional em dispositivo Android físico
- ✅ Persistência local de dados (Shared Preferences)
- ✅ Sincronização em nuvem (Firebase Firestore)
- ✅ Exportação de relatórios em formato CSV
- ✅ Sistema de antifraude implementado e documentado
- ✅ Funcionamento offline (sem infraestrutura externa da instituição)
- ✅ Detecção automática de faltas

---

## 3. DESCRIÇÃO DA ESTRUTURA DE ENTREGA

### Organização do Arquivo Compactado (.zip)

A entrega está organizada da seguinte forma:

```
N2_Mobile-main/
│
├── 📄 IDENTIFICACAO_EQUIPE.md (este documento)
│
├── 📁 lib/                          # Código-fonte do aplicativo
│   ├── main.dart                    # Arquivo principal e configuração de rotas
│   ├── firebase_options.dart        # Configuração do Firebase
│   ├── 📁 models/                   # Modelos de dados
│   │   ├── rodada_model.dart
│   │   └── rodada_model.g.dart
│   ├── 📁 screens/                  # Telas do aplicativo
│   │   ├── dashboard_screen.dart    # Tela principal de controle
│   │   ├── history_screen.dart      # Tela de histórico
│   │   ├── export_screen.dart       # Tela de exportação CSV
│   │   └── status_geral_screen.dart # Tela de status geral da turma
│   └── 📁 services/                 # Lógica de negócio
│       └── chamada_service.dart     # Serviço principal (timer, Firebase, persistência)
│
├── 📁 docs/                         # Documentação do projeto
│   ├── IDENTIFICACAO_EQUIPE.md      # Este documento
│   ├── 📁 requisitos/
│   │   └── requisitos.pdf           # Documento de requisitos
│   ├── 📁 modelagem/
│   │   ├── caso_de_uso.png
│   │   ├── caso_detalhado.png
│   │   ├── caso_detalhado2.png
│   │   ├── caso_detalhado3.png
│   │   ├── diagrama_de_atividades.png
│   │   ├── diagrama_de_classe.png
│   │   ├── diagrama_de_componente.png
│   │   ├── diagrama_de_fluxo.png
│   │   └── mapa_de_navegacao.png
│   ├── 📁 antifraude/
│   │   └── antifraude.pdf           # Documento sobre solução de antifraude
│   ├── csv_layout.csv               # Layout do CSV de exportação
│   └── csv_layout.pdf               # Documentação do formato CSV
│
├── 📁 android/                      # Configurações Android
│   └── app/                         # Configurações específicas do app
│
├── 📄 pubspec.yaml                  # Dependências do projeto
├── 📄 pubspec.lock                  # Versões fixadas das dependências
├── 📄 README.md                     # Documentação geral do projeto
│
└── 📁 [OUTRAS PASTAS]               # Configurações de outras plataformas (iOS, Windows, etc.)
```

### Localização dos Itens por Faixa de Nota

#### **Faixa 6 (Básico)**
- ✅ Aplicativo rodando em emulador → **Localização:** Projeto completo em `/lib/`
- ✅ Documentação básica → **Localização:** `/docs/requisitos/requisitos.pdf`
- ✅ Modelagem → **Localização:** `/docs/modelagem/`

#### **Faixa 7-8 (Intermediário)**
- ✅ Funcionamento em dispositivo físico → **Localização:** Projeto configurado em `/android/`
- ✅ Persistência local → **Localização:** `/lib/services/chamada_service.dart` (linhas 33-45)
- ✅ Interface aprimorada → **Localização:** `/lib/screens/dashboard_screen.dart`

#### **Faixa 9 (Avançado)**
- ✅ Exportação de relatórios CSV → **Localização:** `/lib/screens/export_screen.dart`
- ✅ Layout do CSV documentado → **Localização:** `/docs/csv_layout.csv` e `/docs/csv_layout.pdf`
- ✅ Histórico de presenças → **Localização:** `/lib/screens/history_screen.dart`

#### **Faixa 10 (Excelência)**
- ✅ Sincronização Firebase → **Localização:** `/lib/services/chamada_service.dart` (linhas 56-75)
- ✅ Detecção automática de faltas → **Localização:** `/lib/services/chamada_service.dart` (linhas 107-117)
- ✅ Documentação de antifraude → **Localização:** `/docs/antifraude/antifraude.pdf`
- ✅ Funcionamento offline → **Localização:** Implementado em `/lib/services/chamada_service.dart` (persistência local + sincronização)

---

## 4. FUNÇÕES E RESPONSABILIDADES DOS INTEGRANTES

### Lucas Mendonça
**Responsabilidades:**
- Desenvolvimento da arquitetura do aplicativo
- Implementação do serviço principal de chamada (`chamada_service.dart`)
- Integração com Firebase Firestore
- Lógica de automação de rodadas e detecção de faltas
- Configuração de persistência local com Shared Preferences

### Heloisa Rebello Cabral
**Responsabilidades:**
- Desenvolvimento das interfaces de usuário (UI)
- Implementação das telas principais (`dashboard_screen.dart`, `status_geral_screen.dart`)
- Design e experiência do usuário (UX)
- Testes de usabilidade em dispositivo físico
- Documentação visual (modelagem de telas)

### Henrique Xavier
**Responsabilidades:**
- Implementação da funcionalidade de exportação CSV
- Desenvolvimento da tela de histórico (`history_screen.dart`)
- Implementação da tela de exportação (`export_screen.dart`)
- Definição do layout e formato do arquivo CSV
- Testes de exportação e compartilhamento de arquivos

### Rodrigo Xavier
**Responsabilidades:**
- Documentação do projeto (requisitos e modelagem)
- Criação dos diagramas UML (casos de uso, diagrama de classes, etc.)
- Documentação da solução de antifraude
- Organização da estrutura de documentos
- Revisão técnica da documentação

### Heitor Reis
**Responsabilidades:**
- Configuração do ambiente Android
- Testes em dispositivo físico Android
- Configuração do Firebase e serviços em nuvem
- Validação de funcionamento offline
- Gravação do vídeo de demonstração do aplicativo
- Suporte técnico e debugging

---

### Distribuição de Responsabilidades - Resumo

**Desenvolvimento Backend/Lógica:**
- Lucas Mendonça (Serviços e lógica de negócio)
- Henrique Xavier (Exportação e histórico)

**Desenvolvimento Frontend/UI:**
- Heloisa Rebello Cabral (Interface e experiência do usuário)

**Infraestrutura e Testes:**
- Heitor Reis (Configuração, testes e vídeo)

**Documentação:**
- Rodrigo Xavier (Documentação técnica e diagramas)

---

## 5. OBSERVAÇÕES IMPORTANTES

### Sobre o Vídeo de Apresentação

O vídeo de demonstração será entregue junto com este documento, seguindo as especificações:
- Duração máxima: 10 minutos
- Filmagem mostrando o celular físico sendo operado
- Demonstração das funcionalidades principais
- Narração explicando o funcionamento do aplicativo

### Dependências para Execução

Para executar o projeto, é necessário:
1. Flutter SDK instalado (versão 3.0.0 ou superior)
2. Dispositivo Android físico ou emulador configurado
3. Executar `flutter pub get` para instalar dependências
4. Configurar o Firebase (arquivo `firebase_options.dart` já incluído)
5. Executar `dart run build_runner build` para gerar arquivos de modelo (se necessário)

### Funcionalidades Implementadas

✅ Automação de 4 rodadas de chamada por noite
✅ Registro de presença em tempo real
✅ Persistência local (funciona offline)
✅ Sincronização com Firebase Firestore
✅ Detecção automática de faltas
✅ Exportação de relatórios em CSV
✅ Interface responsiva e intuitiva
✅ Sistema de status visual para cada rodada
✅ Histórico completo de presenças

---

## 6. CONTATO E SUPORTE

Em caso de dúvidas sobre o projeto ou a entrega, a equipe está disponível através dos canais estabelecidos pela instituição.

---

**Data de Entrega:** [PREENCHER: Data da entrega]

**Versão do Documento:** 1.0

---

*Este documento foi preparado de acordo com os requisitos da N3 - Desenvolvimento Mobile.*

