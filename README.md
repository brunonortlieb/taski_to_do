# Taski To-Do App

Taski To-Do é um aplicativo de gerenciamento de tarefas simples e eficiente, desenvolvido em Flutter. Ele permite que os usuários criem, editem, marquem como concluídas e excluam tarefas. O aplicativo utiliza o **Hive** para armazenamento local, o **MobX** para gerenciamento de estado e o **Modular** para gerenciamento de rotas e injeção de dependências.

## Pré-requisitos

Antes de começar, certifique-se de que você tem os seguintes itens instalados:

- **Flutter SDK**: 3.x ou superior
- **Dart SDK**: 2.19 ou superior
- Dependências adicionais conforme listado no arquivo `pubspec.yaml`

---

## Como Executar o Projeto


```bash
git clone https://github.com/seu-usuario/taski-to-do.git
```

```bash
flutter pub get
```

```bash
flutter run
```

---

## Como Executar os Testes

```bash
flutter test
```

---

## Estrutura do Projeto

```
lib/
├── core/ 
│   ├── constants/
│   ├── entities/
│   ├── extensions/
│   ├── failures/
│   ├── theme/
│   ├── utils/
│   └── validators/
├── data/
│   ├── models/
│   └── repositories/
├── modules/ 
│   └── home/
│       ├── stores/
│       ├── views/
│       └── widgets/
├── app_module.dart 
├── app_widget.dart 
└── main.dart
```

---

##  Dependências Principais

- **Flutter Modular**: Para injeção de dependências e gerenciamento de rotas.
- **MobX**: Para gerenciamento de estado reativo.
- **Hive**: Para armazenamento local de dados.
- **Mocktail**: Para testes unitários e de widget.

Para ver todas as dependências, consulte o arquivo `pubspec.yaml`.

---

##  Contato

- **Nome**: Bruno Nunes Ortlien
- **Email**: bruno.10nuness@gmail.com
- **GitHub**: https://github.com/brunonortlieb

---