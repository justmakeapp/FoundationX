import Foundation

@available(iOS 16, macOS 13.0, watchOS 9.0, *)
public extension Locale.Weekday {
    var calendarFirstWeekday: Int {
        switch self {
        case .sunday:
            return 1
        case .monday:
            return 2
        case .tuesday:
            return 3
        case .wednesday:
            return 4
        case .thursday:
            return 5
        case .friday:
            return 6
        case .saturday:
            return 7
        @unknown default:
            return 1 // Default to Sunday if unknown
        }
    }
}
