# 🔖 Todo With Flutter

A simple todo app built with Appwrite and Flutter

If you simply want to try out the App, go ahead and check out the demo at https://appwrite-todo-with-flutter.vercel.app


## 🎬 Getting Started

### 🤘 Install Appwrite
Follow our simple [Installation Guide](https://appwrite.io/docs/installation) to get Appwrite up and running in no time. You can either deploy Appwrite on your local machine or, on any cloud provider of your choice.

> Note: If you setup Appwrite on your local machine, you will need to create a public IP so that your hosted frontend can access it.

We need to make a few configuration changes to your Appwrite server.

1. Add a new Web App in Appwrite and enter the endpoint of your website (`localhost, <project-name>.vercel.app etc`)
![Create Web App](https://user-images.githubusercontent.com/20852629/113019434-3c27c900-919f-11eb-997c-1da5a8303ceb.png)

2. Create a new collection with the following attributes and permission level set to `document`

| Type    | Attribute ID | Required | Options        |
|---------|--------------|----------|----------------|
| String  | content      | true     | Size: 1000     |
| Boolean | isCompleted   | false    | Default: false |

### 🚀 Deploy the Front End
You have two options to deploy the front-end and we will cover both of them here. In either case, you will need to fill in these environment variables that help your frontend connect to Appwrite.

* FLUTTER_APP_ENDPOINT - Your Appwrite endpoint
* FLUTTER_APP_PROJECT - Your Appwrite project ID
* FLUTTER_APP_COLLECTION_ID - Your Appwrite collection ID

### **Run locally**

Follow these instructions to run the demo app locally

```sh
$ git clone https://github.com/appwrite/demo-todo-with-flutter
$ cd demo-todo-with-flutter
```

Run the following command to generate your `.env` vars

```sh
$ cp .env.example .env
```

Now fill in the envrionment variables we discussed above in your `.env`

Now run the following commands and you should be good to go 💪🏼

```
$ flutter pub get
$ flutter run
```

## 🤕 Support

If you get stuck anywhere, hop onto one of our [support channels in discord](https://appwrite.io/discord) and we'd be delighted to help you out 🤝
