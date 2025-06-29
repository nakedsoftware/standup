# Software Requirements

## Platform Notes

Naked Standup supports developers using Apple macOS, Linux, or Microsoft Windows. Not all software is required on all platforms. Each software package contains a table showing which operating systems the product is required for. The following symbols are used:

- :white_check_mark:: The software package is required on this operating system.
- :grey_question:: The software package is optional on this operating system.
- :x:: The software package is not required or is not supported on this operating system.

## Required Software

Naked Standup requires that you have the following software installed in your development environment in order to build, run, and debug the Naked Standup applications and services:

1. [Homebrew](#homebrew)
1. [Git](#git)
1. [Git LFS](#git-lfs)
1. [GitHub CLI](#github-cli)
1. [PowerShell](#powershell)
1. [Fast Node Manager](#fast-node-manager)
1. [Node.js](#nodejs)
1. [Docker Desktop](#docker-desktop)
1. [Visual Studio Code](#visual-studio-code)
1. [Remote Development Extension Pack for Visual Studio Code]()

### Homebrew

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :x: |

[Homebrew](https://brew.sh) is a package manager for Apple macOS and Linux. Homebrew is used to install many popular software packages including programming languages, development tools, and libraries. The Naked Standup team prefers to use Homebrew when possible to install external software packages and receive updates.

To install Homebrew, open a terminal and run:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

After Homebrew installs, you will need to stop and restart your terminal for the changes to the environment to take effect.

### Git

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Git](https://git-scm.com) is a distributed version control system that was originally created to manage the Linux kernel source code. Git is a very powerful version control system that has quickly become one of the most popular tools in software development. Git is a distributed version control system. In a distributed version control system, each developer maintains their own copy of the repository that includes all of the history and changes. Developers can work in isolation, either online or offline. Git makes it easy for developers to share changes with each other either directly or by using a shared repository, such as our repository on [GitHub](https://github.com).

- __Apple macOS or Linux__: Git can be installed using [Homebrew](#homebrew). In a terminal and run:

```shell
brew install git
```

- __Microsoft Windows__: Git can be installed using [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/). In a Command Prompt or PowerShell window, run:

```batch
winget install --id Git.Git -e --source winget
```

### Git LFS

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Git LFS](https://git-lfs.com/) is an extension for [Git](#git) that is used to store large, non-versionable files in blob storage outside of the Git repository. By using external storage to store larger or unversionable files like images, the size of the Git repository can be kept manageable and large binary objects or documents are not being stored and processed by Git.

- __Apple macOS or Linux__: Git LFS can be installed using [Homebrew](#homebrew). In a terminal, run:

```shell
brew install git-lfs
```

- __Microsoft Windows__: Git LFS is included in the [Git](#git) installation package for Windows and does not need to be installed separately.

### GitHub CLI

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[GitHub CLI](https://cli.github.com) is a command line interface for [GitHub](https://github.com). GitHub CLI provides commands that can be used to interact with GitHub repositories and projects, and can be used to build automations or perform one-time tasks involving the GitHub repository.

- __Apple macOS or Linux__: GitHub CLI can be installed using [Homebrew](#homebrew). In a terminal, run:

```shell
brew install gh
```

- __Microsoft Windows__: GitHub CLI can be installed using [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/). In a Command Prompt or PowerShell window, run:

```batch
winget install --id GitHub.cli
```

### PowerShell

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :grey_question: |
| Linux | :grey_question: |
| Microsoft Windows | :white_check_mark: |

[PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview) is a command shell created by Microsoft and based on [.NET](https://dotnet.microsoft.com). PowerShell is typically used to build administrative scripts or automations, but can also be used as a general purpose programming language for building CLI tools. PowerShell is used to build automations and administrative scripts for Naked Standup for Microsoft Windows developers.

PowerShell is optional, but strongly recommended, for Apple macOS and Linux developers.

- __Apple macOS or Linux__: PowerShell can be installed using [Homebrew](#homebrew). In a terminal, run:

```shell
brew install --cask powershell
```

- __Microsoft Windows__: PowerShell can be installed using [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/). In a Command Prompt or PowerShell window, run:

```batch
winget install --id Microsoft.PowerShell --source winget
```

### Fast Node Manager

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Fast Node Manager](https://github.com/Schniz/fnm) is a version manager for [Node.js](https://nodejs.org). Fast Node Manager can be used to install and manage multiple versions of Node.js and can switch between them as necessary for different projects. Naked Standup stores the currently supported version of Node.is in the [`.node-version`](../.node-version) file in the root directory of the Git repository. When Fast Node Manager is integrated into the shell, Fast Node Manager will automatically switch to that version of Node.js to ensure that developers are working with the correct Node.js version.

- __Apple macOS or Linux__: Fast Node Manager uses an installation script that will internally use [Homebrew](#homebrew) to install Fast Node Manager. In a terminal, run:

```shell
curl -fsSL https://fnm.vercel.app/install | bash
```

- __Microsoft Windows__: Fast Node Manager can be installed using [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/). In a Command Prompt or PowerShell window, run:

```batch
winget install Schniz.fnm
```

### Node.js

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Node.js](https://node.js) is a platform and runtime environment for programs written in JavaScript. Node.js is useful for development tools and is also used for building backend services. Node.js is used mostly for running development tools needed by the Naked Standup product.

Node.js is installed using [Fast Node Manager](#fast-node-manager). In a terminal, navigate to the repository directory and run:

```shell
fnm use
```

### Docker Desktop

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :x: |
| Microsoft Windows | :white_check_mark: |

[Docker Desktop](https://www.docker.com/products/docker-desktop/) provides the tools to build and run containers on a desktop or laptop computer. Docker Desktop is intended to be run locally and used by software developers or individual users for running containerized software. Docker Desktop is needed to run development containers. Docker Desktop can be installed by downloading the installer from the [Docker website](https://www.docker.com/products/docker-desktop/).

### Visual Studio Code

| Operating System | Required? |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Visual Studio Code](https://code.visualstudio.com) is a free and open source text editor and development environment created and maintained by [Microsoft](https://www.microsoft.com). Visual Studio Code provides a rich extension ecosystem that adds support for different programming languages and software development tools. Visual Studio Code can be installed by downloading the installer from the [Visual Studio Code website](httos://code.visualstudio.com).

### Remote Development Extension Pack for Visual Studio Code

[Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extends [Visual Studio Code](#visual-studio-code) with tools that allow for connecting to and developing on remote machines or environments. This extension pack also includes support for building and running development containers locally and installing a server component that will allow Visual Studio Code to interact with the development container. Remote Development Extension Pack can be installed from the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
