# Contributing

We would ❤️ for you to contribute to Appwrite and help make it better! We want contributing to Appwrite to be fun, enjoyable, and educational for anyone and everyone. All contributions are welcome, including issues, new docs as well as updates and tweaks, blog posts, workshops, and more.

## How to Start?

If you are worried or don’t know where to start, check out our next section explaining what kind of help we could use and where can you get involved. You can reach out with questions to [Eldad Fux (@eldadfux)](https://twitter.com/eldadfux) or [@appwrite_io](https://twitter.com/appwrite_io) on Twitter, and anyone from the [Appwrite team on Discord](https://discord.gg/GSeTUeA). You can also submit an issue, and a maintainer can guide you!

## Code of Conduct

Help us keep Appwrite open and inclusive. Please read and follow our [Code of Conduct](/CODE_OF_CONDUCT.md).


## Submit a Pull Request 🚀

Branch naming convention is as following

`TYPE-ISSUE_ID-DESCRIPTION`

example:

```
doc-548-submit-a-pull-request-section-to-contribution-guide
```

When `TYPE` can be:

- **feat** - is a new feature
- **doc** - documentation only changes
- **cicd** - changes related to CI/CD system
- **fix** - a bug fix
- **refactor** - code change that neither fixes a bug nor adds a feature

**All PRs must include a commit message with the changes description!**

For the initial start, fork the project and use git clone command to download the repository to your computer. A standard procedure for working on an issue would be to:

1. `git pull`, before creating a new branch, pull the changes from upstream. Your master needs to be up to date.

```
$ git pull
```

2. Create new branch from `master` like: `doc-548-submit-a-pull-request-section-to-contribution-guide`<br/>

```
$ git checkout -b [name_of_your_new_branch]
```

3. Work - commit - repeat ( be sure to be in your branch )

4. Push changes to GitHub

```
$ git push origin [name_of_your_new_branch]
```

5. Submit your changes for review
   If you go to your repository on GitHub, you'll see a `Compare & pull request` button. Click on that button.
6. Start a Pull Request
   Now submit the pull request and click on `Create pull request`.
7. Get a code review approval/reject
8. After approval, merge your PR
9. GitHub will automatically delete the branch after the merge is done. (they can still be restored).

## Setup From Source

To set up a working development environment, just fork the project git repository and upgrade the packages.

Please note that these instructions are for setting a functional environment. If you want to run a the app on mobile phones, you should probably follow this instructions in the [getting started guide](/https://flutter.dev/docs/get-started/)

```bash
git clone git@github.com:[YOUR_FORK_HERE]/demo-todo-with-flutter.git
cd demo-todo-with-flutter
flutter packages upgrade
flutter run
```

## Get Started
After finishing the installation and upgrading process, you can start writing and editing code.

## Advanced Topics
We love to create issues that are good for beginners and label them as good first issue or hacktoberfest, but some more advanced topics might require extra knowledge. Below is a list of links you can use to learn more about some of the more advance topics that will help you master the Appwrite codebase.


### File Structure

```bash
.
├── demo-todo-with-flutter # Main application
│   ├── android # Android files
│   │   ├── app
│   │   ├── gradle/wrapper
│   │   └── gradle.properties
│   │   └── settings.gradle
│   ├── assets # Images Folder
│   ├── ios # IOS files
│   │   ├── Runner
│   │   ├── Runner.xcodeproj
│   │   └── Runner.scworkspace
│   ├── lib # Dart files
│   │   ├── main.dart # important file to run the application
│   │   ├── data # folder which contains all MVS 
│   │   └── widgets # folder with all the widget files
│   │   └── pages # folder with all the screens files
│   ├── test # It is used to test the application
│   │   └── widget_test.dart
│   ├── web # Web Application related files
│   │   └── index.html # main file
│   │   └── favicon.png # flutter icon image
│   │   └── manifest.json
│   ├── .metadata # Config files
│   ├── pubspec.lock # Which has all your packages wrt to version
│   ├── pubspec.yaml # Here we can add new packages and we can change some settings
```


## Introducing New Features

We would 💖 you to contribute to Appwrite, but we would also like to make sure Appwrite is as great as possible and loyal to its vision and mission statement 🙏.

For us to find the right balance, please open an issue explaining your ideas before introducing a new pull request.

This will allow the Appwrite community to have sufficient discussion about the new feature value and how it fits in the product roadmap and vision.

This is also important for the Appwrite lead developers to be able to give technical input and different emphasis regarding the feature design and architecture. Some bigger features might need to go through our [RFC process](https://github.com/appwrite/rfc).



## Other Ways to Help

Pull requests are great, but there are many other areas where you can help Appwrite. 

### Blogging & Speaking

Blogging, speaking about, or creating tutorials about one of Appwrite’s many features. Mention [@appwrite_io](https://twitter.com/appwrite_io) on Twitter and/or email team [at] appwrite [dot] io so we can give pointers and tips and help you spread the word by promoting your content on the different Appwrite communication channels. Please add your blog posts and videos of talks to our [Awesome Appwrite](https://github.com/appwrite/awesome-appwrite) repo on GitHub.

### Presenting at Meetups

Presenting at meetups and conferences about your Appwrite projects. Your unique challenges and successes in building things with Appwrite can provide great speaking material. We’d love to review your talk abstract/CFP, so get in touch with us if you’d like some help!

### Sending Feedbacks & Reporting Bugs

Sending feedback is a great way for us to understand your different use cases of Appwrite better. If you had any issues, bugs, or want to share about your experience, feel free to do so on our GitHub issues page or at our [Discord channel](https://discord.gg/GSeTUeA).

### Submitting New Ideas

If you think Appwrite could use a new feature, please open an issue on our GitHub repository, stating as much information as you can think about your new idea and it's implications. We would also use this issue to gather more information, get more feedback from the community, and have a proper discussion about the new feature.

### Improving Documentation

Submitting documentation updates, enhancements, designs, or bug fixes. Spelling or grammar fixes will be very much appreciated.

### Helping Someone

Searching for Appwrite on Discord, GitHub, or StackOverflow and helping someone else who needs help. You can also help by teaching others how to contribute to Appwrite's repo!
