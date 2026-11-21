# Xcode setup

1. Create an iOS 18 App project named `NameX-iOS`.
2. Add `Packages/NameXCore` as a local Swift package dependency.
3. Add the package product `NameXCore` to the app target.
4. Create `NameXApp`, `ConversationView`, and `SettingsView`.
5. Add `AppIntents` definitions for Ask and Status.
6. Keep model execution behind `ModelBackend`.
7. Add Push Notifications and Background Modes capabilities only after the runtime is complete.

No `.xcodeproj` is committed here yet because a project created by hand needs to be generated in Xcode to get valid signing and bundle configuration for your Apple account.
