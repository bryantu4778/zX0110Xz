import Foundation

public actor JSONCheckpointer {
    private let directory: URL

    public init(directory: URL) throws {
        self.directory = directory
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    }

    public func save(_ checkpoint: AgentCheckpoint) throws {
        let url = directory.appendingPathComponent("\(checkpoint.taskID.uuidString).json")
        let data = try JSONEncoder().encode(checkpoint)
        try data.write(to: url, options: .atomic)
    }

    public func load(taskID: UUID) throws -> AgentCheckpoint? {
        let url = directory.appendingPathComponent("\(taskID.uuidString).json")
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        return try JSONDecoder().decode(AgentCheckpoint.self, from: Data(contentsOf: url))
    }
}

public actor MemoryStore {
    private let fileURL: URL
    private var entries: [String]

    public init(fileURL: URL) throws {
        self.fileURL = fileURL
        if let data = try? Data(contentsOf: fileURL) {
            entries = (try? JSONDecoder().decode([String].self, from: data)) ?? []
        } else {
            entries = []
        }
    }

    public func remember(_ fact: String) async throws {
        entries.append(fact)
        try JSONEncoder().encode(entries).write(to: fileURL, options: .atomic)
    }

    public func all() -> [String] { entries }
}
