import Foundation

public final class FakeModelBackend: ModelBackend, @unchecked Sendable {
    public init() {}

    public func generate(messages: [AgentMessage]) async throws -> String {
        guard let last = messages.last else { throw AgentError.invalidTask }
        return "Received: \(last.content)"
    }
}

public struct NoApprovalProvider: ApprovalProvider {
    public init() {}
    public func approve(tool: ToolCall) async -> Bool { false }
}
