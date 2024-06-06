import Foundation

public protocol SyncCommand: Command {
    func execute() -> Bool
}
