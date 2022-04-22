# 🔖 Todo With Flutter 

A simple todo app built with Flutter and Appwrite

## 🎬 Getting Started

Appwrite is an end-to-end backend server for Web, Mobile, Native, or Backend apps packaged as a set of Docker microservices. Appwrite abstracts the complexity and repetitiveness required to build a modern backend API from scratch and allows you to build secure apps faster.

### 🤘 Install Appwrite

Follow our simple [Installation Guide](https://appwrite.io/docs/installation) to get Appwrite up and running in no time. You can either deploy Appwrite on your local machine or, on any cloud provider of your choice.

    Note: If you setup Appwrite on your local machine, you will need to create a public IP so that your hosted frontend 
    can access it.

We need to make a few configuration changes to your Appwrite server.

1. Add a new Flutter App (Android or iOS or both) in Appwrite and enter application id of your application (io.appwrite.todo, etc) 
![image](https://user-images.githubusercontent.com/73419211/122684732-e9eac700-d226-11eb-954c-f7cb5327d042.png)

2. Create a new collection with the following properties

  - Rules

Add the following rules to the collection.

    Make sure that your key exactly matches the key in the images
   
  ![image](https://user-images.githubusercontent.com/73419211/122684906-0a675100-d228-11eb-91d0-ff70e216b7cb.png)
  ![image](https://user-images.githubusercontent.com/73419211/122684925-2965e300-d228-11eb-87a6-301cff857fb9.png)

 - Permissions

Add the following permissions to your collections. These permissions ensure that only registered users can access the collection.

![image](https://user-images.githubusercontent.com/73419211/122684974-819ce500-d228-11eb-93c6-4d2b05167633.png)

## 🚀 Deploy the Front End

You have two options to deploy the front-end and we will cover both of them here. In either case, you will need to fill in these environment variables that help your frontend connect to Appwrite.

    FLUTTER_APP_ENDPOINT - Your Appwrite endpoint
    FLUTTER_APP_PROJECT - Your Appwrite project ID
    FLUTTER_APP_COLLECTION_ID - Your Appwrite collection ID
  
## Run locally

Follow these instructions to run the demo app locally

$ git clone https://github.com/devkishor8007/todo-with-flutter.git
$ cd todo-with-flutter

Make a one file in the Clone Repo called constant.dart

    class AppConstant {
    static const String projectid = 'your appwrite project id';
    static const String endPoint = 'your own endpoint';
    static const String database = 'your appwrite database id';
    }

Now run the following commands and you should be good to go 💪🏼

$ flutter pub get
$ flutter run


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

If you get stuck anywhere, hop onto one of our [support channels in discord](https://discord.com/invite/GSeTUeA) and we'd be delighted to help you out 🤝

## 😧 Help Wanted

Our access credentials were recently compromised and someone tried to ruin these demos. They decided to leave behind 15 easter eggs 🥚 for you to discover. If you find them, submit a PR cleaning up that section of the code (One PR per person across all the repos). You can track the number of claimed Easter Eggs using the badge at the top.

The first 15 people to get their PRs merged will receive some Appwrite Swags 🤩 . Just head over to our [Discord channel](https://discord.com/invite/GSeTUeA)
 and share your PR link with us.
