import Foundation

public actor AgentController {
    private let model: any ModelBackend
    private let checkpointer: JSONCheckpointer
    private let memory: MemoryStore
    private let tools: [String: any AgentTool]
    private let approvals: any ApprovalProvider

    public init(model: any ModelBackend, checkpointer: JSONCheckpointer, memory: MemoryStore, tools: [any AgentTool] = [], approvals: any ApprovalProvider) {
        self.model = model
        self.checkpointer = checkpointer
        self.memory = memory
        self.tools = Dictionary(uniqueKeysWithValues: tools.map { ($0.name, $0) })
        self.approvals = approvals
    }

    public func resume(taskID: UUID) async throws -> AgentCheckpoint? {
        try await checkpointer.load(taskID: taskID)
    }

    public func run(taskID: UUID, messages: [AgentMessage]) async throws -> AgentCheckpoint {
        let answer = try await model.generate(messages: messages)
        let updated = messages + [AgentMessage(role: .assistant, content: answer)]
        let checkpoint = AgentCheckpoint(taskID: taskID, step: 1, messages: updated)
        try await checkpointer.save(checkpoint)
        return checkpoint
    }

    public func execute(toolCall: ToolCall) async throws -> String {
        guard let tool = tools[toolCall.name] else { throw AgentError.invalidTask }
        if tool.requiresApproval && !await approvals.approve(tool: toolCall) {
            throw AgentError.toolRejected(toolCall.name)
        }
        return try await tool.execute(argumentsJSON: toolCall.argumentsJSON)
    }
}
