import Foundation

public protocol ModelBackend: Sendable {
    func generate(messages: [AgentMessage]) async throws -> String
}

public protocol AgentTool: Sendable {
    var name: String { get }
    var requiresApproval: Bool { get }
    func execute(argumentsJSON: String) async throws -> String
}

public enum AgentError: LocalizedError, Equatable {
    case invalidTask
    case toolRejected(String)

    public var errorDescription: String? {
        switch self {
        case .invalidTask: return "The task is not valid."
        case .toolRejected(let name): return "Tool requires approval and was rejected: \(name)"
        }
    }
}

public protocol ApprovalProvider: Sendable {
    func approve(tool: ToolCall) async -> Bool
}
