# Y—Analytics Pendo
_A Pendo SDK implementation of Y—Analytics `AnalyticsEngine` protocol._

This framework links the [Pendo iOS SDK](https://github.com/pendo-io/pendo-mobile-ios) to implement a Pendo version of [Y—Analytics](https://github.com/yml-org/yanalytics-ios) `AnalyticsEngine` protocol.

Licensing
----------
Y—Analytics Pendo is licensed under the [Apache 2.0 license](LICENSE).

Documentation
----------

Documentation is automatically generated from source code comments and rendered as a static website hosted via GitHub Pages at: https://yml-org.github.io/yanalytics-pendo-ios/

Usage
----------

### `PendoAnalyticsEngine`

`PendoAnalyticsEngine` implements the `AnalyticsEngine` protocol, and in its `track(event:)` method it maps the `AnalyticsEvent` enum to the appropriate Pendo methods.

When unit testing various components of your project, you should inject an instance of MockAnalyticsEngine instead of the Pendo engine. This allows your unit tests to run without any Pendo dependency and allows you to verify which events are tracked and when.

#### Simple use case
 We can initialise `PendoAnalyticsEngine` just by configuring the `PendoAnalyticsConfiguration` object as shwon below and use this `config` object in the Engine initialiser. We need a Pendo app key to configure  `PendoAnalyticsConfiguration`.

```swift
import YAnalyticsPendo

final class AppCoordinator {
    let engine: PendoAnalyticsEngine = {
        let config = PendoAnalyticsConfiguration(appKey: "S3cr3t!")
        return PendoAnalyticsEngine(configuration: config)
    }()
    
    func trackSomething(someData: [String: Any]?) {
        engine.track(
            event: .event(name: "Something", parameters: someData)
        )
    }
}
```

#### Custom Configuration
`PendoAnalyticsConfiguration` can be initialised with following arguments where app key is required and for mappings, sessionData and debugMode we have a default value for each.

```swift
import YAnalyticsPendo

final class AppCoordinator {
    let engine: PendoAnalyticsEngine = {
        let config = PendoAnalyticsConfiguration(
            appKey: "S3cr3t!",
            mappings: [:],
            sessionData: PendoSessionData(),
            debugMode: false
        )
        return PendoAnalyticsEngine(configuration: config)
    }()
}
```

Dependencies
----------

Y—Analytics Pendo depends upon our [Y—Analytics](https://github.com/yml-org/yanalytics-ios) framework (which is also open source and Apache 2.0 licensed).

Installation
----------

You can add Y—Analytics Pendo to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Add Packages...**
2. Enter "[https://github.com/yml-org/yanalytics-pendo-ios](https://github.com/yml-org/yanalytics-pendo-ios)" into the package repository URL text field
3. Click **Add Package**

Contributing to Y—Analytics Pendo
----------

### Requirements

#### SwiftLint (linter)
```
brew install swiftlint
```

#### Jazzy (documentation)
```
sudo gem install jazzy
```

### Setup

Clone the repo and open `Package.swift` in Xcode.

### Versioning strategy

We utilize [semantic versioning](https://semver.org).

```
{major}.{minor}.{patch}
```

e.g.

```
1.0.5
```

### Branching strategy

We utilize a simplified branching strategy for our frameworks.

* main (and development) branch is `main`
* both feature (and bugfix) branches branch off of `main`
* feature (and bugfix) branches are merged back into `main` as they are completed and approved.
* `main` gets tagged with an updated version # for each release
 
### Branch naming conventions:

```
feature/{ticket-number}-{short-description}
bugfix/{ticket-number}-{short-description}
```
e.g.
```
feature/CM-44-button
bugfix/CM-236-textview-color
```

### Pull Requests

Prior to submitting a pull request you should:

1. Compile and ensure there are no warnings and no errors.
2. Run all unit tests and confirm that everything passes.
3. Check unit test coverage and confirm that all new / modified code is fully covered.
4. Run `swiftlint` from the command line and confirm that there are no violations.
5. Run `jazzy` from the command line and confirm that you have 100% documentation coverage.
6. Consider using `git rebase -i HEAD~{commit-count}` to squash your last {commit-count} commits together into functional chunks.
7. If HEAD of the parent branch (typically `main`) has been updated since you created your branch, use `git rebase main` to rebase your branch.
    * _Never_ merge the parent branch into your branch.
    * _Always_ rebase your branch off of the parent branch.

When submitting a pull request:

* Use the [provided pull request template](.github/pull_request_template.md) and populate the Introduction, Purpose, and Scope fields at a minimum.
* If you're submitting before and after screenshots, movies, or GIF's, enter them in a two-column table so that they can be viewed side-by-side.

When merging a pull request:

* Make sure the branch is rebased (not merged) off of the latest HEAD from the parent branch. This keeps our git history easy to read and understand.
* Make sure the branch is deleted upon merge (should be automatic).

### Releasing new versions
* Tag the corresponding commit with the new version (e.g. `1.0.5`)
* Push the local tag to remote

Generating Documentation (via Jazzy)
----------

You can generate your own local set of documentation directly from the source code using the following command from Terminal:
```
jazzy
```
This generates a set of documentation under `/docs`. The default configuration is set in the default config file `.jazzy.yaml` file.

To view additional documentation options type:
```
jazzy --help
```
A GitHub Action automatically runs each time a commit is pushed to `main` that runs Jazzy to generate the documentation for our GitHub page at: https://yml-org.github.io/yanalytics-pendo-ios/
