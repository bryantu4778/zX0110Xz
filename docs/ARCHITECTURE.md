# Architecture

## Model backends

All backends implement `ModelBackend`.

- `BundledLocalBackend`: MLX or llama.cpp runtime loading an app-bundled or downloaded GGUF/MLX model
- `OllamaBackend`: local/home-network Ollama HTTP client
- `CloudBackend`: user-keyed provider adapter

The app should not bundle a 7B model until a target, format, license, and size budget are established. The package `.ipa` would otherwise include duplicate architecture assets and can exceed store transfer limits.

## Checkpointing

Save after every agent step. Store task identity, step number, messages, pending tool calls, and timestamp. Resume from the latest checkpoint after app suspension or crash.

## Long runs

Use short work units and BGAppRefreshTask/BGProcessingTask where allowed. iOS cannot guarantee hours-long execution. Surface resumable work in the app and push notifications when a decision or result is ready.

## Approval

Every tool must declare `requiresApproval`. Read-only web fetch/search may be allowed automatically. Downloading, posting, deleting, sending, purchasing, or executing shell-like actions require explicit confirmation.

## Memory

Use encrypted local storage for facts. Add embeddings later only if retrieval quality justifies the footprint.

## Siri

Use `AppIntent` for `AskNameXIntent` and `NameXStatusIntent`. Siri invokes the app or app extension and returns a task identifier and status.
