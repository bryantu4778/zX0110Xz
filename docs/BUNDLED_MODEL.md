# Bundled Model

## Recommended first target

- Runtime: MLX Swift for Apple silicon
- Format: MLX 4-bit model weights
- Initial app: one explicit model download after first launch, not an uncompressed model inside the `.ipa`
- Future: optional app-bundle mode for a small model chosen specifically for offline use

A true 7B–8B 4-bit model may require several gigabytes of space and use substantial RAM. Do not claim iPhone support until measured on a real target.

## License gate

Before shipping any model, verify:

1. Base model license
2. Quantized release terms
3. Runtime license
4. Redistribution and hosting permissions
5. Apple App Store and export obligations

## Runtime protocol

The runtime layer must expose:

- `load(modelID:)`
- `generate(messages:)`
- streaming token callbacks
- context-window limits
- cancellation
- memory-pressure handling

## Delivery rule

No model weights are stored in source control. Use signed, resumable downloads and SHA-256 verification. If a model is bundled, its license and files should be added through a documented release process, never through ad hoc Git commits.
