# 🚀 Guia Rápido para Rodar o Projeto

## ⚠️ Flutter não encontrado no sistema

Para rodar este projeto Flutter, você precisa ter o Flutter SDK instalado e configurado.

## 📥 Instalação do Flutter

### 1. Baixar o Flutter SDK

1. Acesse: https://docs.flutter.dev/get-started/install/windows
2. Baixe o Flutter SDK (arquivo ZIP)
3. Extraia o arquivo para uma localização (ex: `C:\src\flutter`)

### 2. Adicionar Flutter ao PATH

1. Abra "Variáveis de Ambiente" no Windows
2. Edite a variável `Path` do usuário
3. Adicione o caminho: `C:\src\flutter\bin` (ou onde você extraiu)

### 3. Verificar Instalação

Abra um novo PowerShell e execute:

```powershell
flutter doctor
```

## ▶️ Rodar o Projeto

Após instalar o Flutter, execute os seguintes comandos:

```powershell
# 1. Navegar para o diretório do projeto
cd "C:\Users\Michelle\Downloads\N2_Mobile-main\N2_Mobile-main"

# 2. Instalar dependências
flutter pub get

# 3. Gerar arquivos de modelo (se necessário)
dart run build_runner build --delete-conflicting-outputs

# 4. Verificar dispositivos disponíveis
flutter devices

# 5. Rodar o aplicativo
flutter run
```

## 📱 Dispositivos

Você pode rodar em:
- **Emulador Android** (precisa ter Android Studio instalado)
- **Dispositivo Android físico** (com depuração USB habilitada)
- **Chrome** (para teste web): `flutter run -d chrome`

## 🔧 Resolução de Problemas

### Flutter não encontrado
- Verifique se o Flutter está no PATH
- Abra um novo terminal após adicionar ao PATH
- Execute `flutter doctor` para diagnosticar problemas

### Dependências não instaladas
```powershell
flutter pub get
```

### Arquivos de modelo não gerados
```powershell
dart run build_runner build --delete-conflicting-outputs
```

### Firebase não configurado
- O arquivo `firebase_options.dart` já está incluído
- Se houver problemas, verifique as configurações do Firebase

## 📝 Comandos Úteis

```powershell
# Verificar versão do Flutter
flutter --version

# Ver dispositivos conectados
flutter devices

# Limpar build anterior
flutter clean

# Atualizar dependências
flutter pub upgrade

# Rodar em modo release (otimizado)
flutter run --release
```

---

**Nota:** Este projeto requer Flutter SDK 3.0.0 ou superior.

