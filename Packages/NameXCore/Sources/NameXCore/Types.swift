import Foundation

public struct AgentMessage: Codable, Sendable, Equatable {
    public enum Role: String, Codable, Sendable { case user, assistant, system, tool }
    public let role: Role
    public let content: String
    public let createdAt: Date

    public init(role: Role, content: String, createdAt: Date = Date()) {
        self.role = role
        self.content = content
        self.createdAt = createdAt
    }
}

public struct AgentCheckpoint: Codable, Sendable {
    public let taskID: UUID
    public let step: Int
    public let messages: [AgentMessage]
    public let pendingToolCalls: [ToolCall]
    public let updatedAt: Date

    public init(taskID: UUID, step: Int, messages: [AgentMessage], pendingToolCalls: [ToolCall] = [], updatedAt: Date = Date()) {
        self.taskID = taskID
        self.step = step
        self.messages = messages
        self.pendingToolCalls = pendingToolCalls
        self.updatedAt = updatedAt
    }
}

public struct ToolCall: Codable, Sendable, Equatable {
    public let id: UUID
    public let name: String
    public let argumentsJSON: String

    public init(id: UUID = UUID(), name: String, argumentsJSON: String) {
        self.id = id
        self.name = name
        self.argumentsJSON = argumentsJSON
    }
}
