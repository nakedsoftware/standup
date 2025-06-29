# Naked Standup

## About Naked Standup

Naked Standup is a software product that can be used by individuals or globally distributed teams to create daily standup reports that can be viewed or searched later by the user or other team members, managers, or stakeholders. At the start of each day, users can use the Naked Standup application on their phone, tablet, or computer to record and post a new standup video. If the user is a member of a team and is producing a status report for a specific project, the video will be shared automatically with all team members and stakeholders. Team members and stakeholders can view or replay the videos at any time. Naked Standup will also use AI to transcribe the video to send out text summaries via email or team chat applications, and allow users to search for videos based on keywords or phrases used in the reports.

## Getting Started

### Cloning the Git Repository Locally

Before cloning the Git repository from GitHub, please ensure that your development environment has the [required software](docs/software_requirements.md) installed and configured. After ensuring that your development environment is set up correctly, open a terminal (Apple macOS or Linux) or Command Prompt or PowerShell window (Microsoft Windows) and run:

    gh repo clone nakedsoftware/standup

Naked Standup has dependencies on external libraries and tools that need to be installed before you can build and run Naked Standup locally. In addition, some source code and project files need to be generated. The steps for preparing your local Git repository for development have been automated using the `do setup` command. In the same terminal or Command Prompt/PowerShell window, run:

- __Apple macOS or Linux__:

```shell
cd standup
./do setup
```

- __Microsoft Windows Command Prompt__:

```batch
cd standup
do.bat setup
```

- __PowerShell__:

```powershell
cd standup
& "./do.ps1" setup
```

Once the `do setup` command has completed, your local Naked Standup repository is ready for development, building, and running the Naked Standup application and services locally.

### Do Commands

To make it easier for you to get up and running locally with the Naked Standup source code, we have created a set of standard commands that can be run using our `do` tool. These commands cover the most common operations that developers will want to perform. The `do` commands are designed to help you get Naked Standup running locally without requiring any knowledge about how the source code is organized.

The syntax for the `do` command differs depending on the operating system and execution tool:

- __Apple macOS__: `./do <command> [<arg>...]`
- __Microsoft Windows Command Prompt__: `do.bat <command> [<arg>...]`
- __PowerShell__: `& "./do.ps1" <command> [<arg>...]`

The `<command>` parameter can be one of the following:

- `setup`: performs one-time initialization of the local repository including downloading dependencies, generating source code, and configuring the repository. The `setup` command needs to be run once, immediately after cloning the Naked Standup repository.
- `build`: compiles all of the source code to ensure that the source code is configured correctly and does not contain any syntax or language errors.
- `test`: runs the automated test suites to ensure that the source code does not have any breaking errors.
- `start`: runs the Naked Standup services locally for debugging and testing.
