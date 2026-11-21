# name-x

A privacy-first personal AI agent for iPhone.

> **Status:** Concept and implementation scaffold. The native iOS app, bundled model runtime, and real model loading are not yet complete.

Copyright (c) 2026 Bryant Isaiah Morris Jr.

## Repository layout

- `Packages/NameXCore` — portable Swift agent core, persistence, memory, checkpoints, and model/tool protocols
- `Apps/NameX-iOS` — SwiftUI iPhone app scaffold
- `docs/` — architecture and build documentation
- `scripts/` — local development helpers

## Architecture

```text
Siri / SwiftUI / terminal
            |
      AgentController
            |
  +---------+---------+---------+
  |         |         |         |
Model     Memory     Tools   Checkpoints
  |
Local MLX  | Ollama | Cloud
```

## Current implementation

The initial version provides:

- One persistent conversation
- Durable step checkpoints
- Memory storage
- A model backend protocol
- An approval-gated tool protocol
- Fake/local backends for deterministic testing
- Swift Package Manager tests

It does **not** yet contain a bundled 7B–8B model. Model weights are intentionally not committed until a license, quantization, and runtime are selected.

## Requirements

- macOS with Xcode 16 or newer for iOS builds
- iOS 18 or newer
- Apple Developer account for device installation beyond free 7-day profiles
- A real A-series/iPhone target for model performance testing

## Building

```bash
swift test --package-path Packages/NameXCore
```

Open `Apps/NameX-iOS/NameX-iOS.xcodeproj` once generated in Xcode.

## Safety

Web content is untrusted. Side-effect tools require explicit approval. Checkpoints should be encrypted if they contain sensitive content.

## License

Apache-2.0. See [LICENSE](LICENSE).
