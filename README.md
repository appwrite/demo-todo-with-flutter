# 🔖 Todo With Flutter

A simple todo app built with Flutter and Appwrite

## 🎬 Getting Started

Appwrite is an end-to-end backend server for Web, Mobile, Native, or Backend apps packaged as a set of Docker microservices. Appwrite abstracts the complexity and repetitiveness required to build a modern backend API from scratch and allows you to build secure apps faster.

### 🤘 Install Appwrite

Follow our simple [Installation Guide](https://appwrite.io/docs/installation) to get Appwrite up and running in no time. You can either deploy Appwrite on your local machine or, on any cloud provider of your choice.

```
Note: If you setup Appwrite on your local machine, you will need to create a public IP so that your hosted frontend can access it.
```

We need to make a few configuration changes to your Appwrite server.

1. Add a new Flutter App in Appwrite:

   ![Console - Add platform](docs/Console%20-%20Add%20platform.png)

   1. Android - `io.appwrite.demo_todo_with_flutter`
   2. iOS/Mac OS - `io.appwrite.demoTodoWithFlutter`
   3. Linux - `demo_todo_with_flutter`

2. Create a project in the Appwrite Console with id `demo-todos`.

3. Use the [Appwrite CLI](https://appwrite.io/docs/command-line) to deploy the required collections.

   ```shell
   appwrite deploy collections
   ```

### 🚀 Run locally

Follow these instructions to run the demo app locally.

```shell
git clone https://github.com/appwrite/demo-todo-with-flutter.git
cd demo-todo-with-flutter
```

Make `lib/constant.dart` using `lib/constants.dart.example` as a template.

Now run the following commands and you should be good to go 💪🏼

```shell
flutter pub get
flutter run
```

## 🤕 Support

If you get stuck anywhere, hop onto one of our [support channels in discord](https://discord.com/invite/GSeTUeA) and we'd be delighted to help you out 🤝
