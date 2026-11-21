import XCTest
@testable import NameXCore

final class NameXCoreTests: XCTestCase {
    func testRunCreatesCheckpointAndRecoversIt() async throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let checkpointer = try JSONCheckpointer(directory: root)
        let memory = try MemoryStore(fileURL: root.appendingPathComponent("memory.json"))
        let agent = AgentController(model: FakeModelBackend(), checkpointer: checkpointer, memory: memory, approvals: NoApprovalProvider())
        let taskID = UUID()
        let messages = [AgentMessage(role: .user, content: "Hello")]

        let checkpoint = try await agent.run(taskID: taskID, messages: messages)
        let recovered = try await agent.resume(taskID: taskID)

        XCTAssertEqual(checkpoint.step, 1)
        XCTAssertEqual(recovered?.messages.last?.content, "Received: Hello")
    }
}
