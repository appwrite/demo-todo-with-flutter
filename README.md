# 🔖 Todo With Flutter 

A simple todo app built with Flutter and Appwrite

## 🎬 Getting Started

Appwrite is an end-to-end backend server for Web, Mobile, Native, or Backend apps packaged as a set of Docker microservices. Appwrite abstracts the complexity and repetitiveness required to build a modern backend API from scratch and allows you to build secure apps faster.

## 🤘 Install Appwrite

Follow our simple [Installation Guide](https://appwrite.io/docs/installation) to get Appwrite up and running in no time. You can either deploy Appwrite on your local machine or, on any cloud provider of your choice.

    Note: If you setup Appwrite on your local machine, you will need to create a public IP so that your hosted frontend 
    can access it.

We need to make a few configuration changes to your Appwrite server.

### Add a new Flutter App in Appwrite and enter application id of your application (io.appwrite.todo, etc)
![image](https://user-images.githubusercontent.com/3102249/223205820-3b989f50-9dca-41c6-95c7-a47cbee16826.png)

### Create a new database

  ![image](https://user-images.githubusercontent.com/3102249/223206444-fac1e291-a85c-4355-8b35-cfeb4a45d8f1.png)

### Within your new database create a new collection with the following properties

Add the following attributes to the collection.

![image](https://user-images.githubusercontent.com/3102249/223208230-2544a673-7a78-4690-b818-03d421959dd7.png)

Make sure that your key exactly matches the key in the images
   
![image](https://user-images.githubusercontent.com/3102249/223206238-ef000bf3-dff7-4ab2-ad9d-dc4fcf384a0f.png)

Add the following permissions to your collections. These permissions ensure that only registered users can access the collection.

![image](https://user-images.githubusercontent.com/3102249/223206691-7588e8a1-1646-452d-a830-12dd1ae07664.png)

### Create a new bucket

Creat a bucket with any name you would like.
![](https://user-images.githubusercontent.com/3102249/223208521-02f96657-f131-49ab-8f26-97c514351886.png)

Make sure to update the bucket permissions to allow create and file level security.

![image](https://user-images.githubusercontent.com/3102249/223221645-8ef1a40b-5ebc-4845-8a76-dc3e526eb3cc.png)

## 🚀 Deploy the Front End

You have two options to deploy the front-end and we will cover both of them here. In either case, you will need to fill in these environment variables that help your frontend connect to Appwrite.

    FLUTTER_APP_ENDPOINT - Your Appwrite endpoint
    FLUTTER_APP_PROJECT - Your Appwrite project ID
    FLUTTER_APP_DATABASE_ID = Your Appwrite database ID
    FLUTTER_APP_COLLECTION_ID - Your Appwrite collection ID
    FLUTTER_APP_STORAGE_BUCKET_ID - Your Appwrite Storage Bucket ID
  
## Run locally

Follow these instructions to run the demo app locally

`git clone https://github.com/appwrite/demo-todo-with-flutter.git`

`cd demo-todo-with-flutter`

Make a one file in the Clone Repo called `lib/res/constant.dart

```dart
class AppConstant {
    static const String endPoint = 'your own endpoint';
    static const String projectid = 'your appwrite project id';
    static const String database = 'your appwrite database id';
    static const String collection = 'your appwrite collection id';
    static const String bucket = 'your appwrite storage bucket id';
}
```

Now run the following commands and you should be good to go 💪🏼

`flutter pub get`
`flutter run`

## Features

1. User can Login and Signup the app.
2. User can add, update the profile picture.
3. User can read, create, update, and delete the task. 

## Screenshots
<p>
<img src="https://user-images.githubusercontent.com/73419211/122684082-274d5580-d223-11eb-9fda-dc49ba9277e5.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684077-25839200-d223-11eb-8d41-6402c85d3c73.jpg" height="500" width="260">  
<img src="https://user-images.githubusercontent.com/73419211/122684072-23213800-d223-11eb-882a-b7d78cddbbeb.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684078-261c2880-d223-11eb-841b-778f460e63bd.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684079-26b4bf00-d223-11eb-8c39-5c143b4d8acb.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684081-274d5580-d223-11eb-807e-33c8e3e2e84a.jpg" height="500" width="260">
</p>

## 🤕 Support

If you get stuck anywhere, hop onto one of our [support channels in discord](https://discord.com/appwrite) and we'd be delighted to help you out 🤝