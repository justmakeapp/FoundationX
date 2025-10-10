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

    init(from weekdayNumber: Int) {
        switch weekdayNumber {
        case 1:
            self = .sunday
        case 2:
            self = .monday
        case 3:
            self = .tuesday
        case 4:
            self = .wednesday
        case 5:
            self = .thursday
        case 6:
            self = .friday
        case 7:
            self = .saturday
        default:
            self = .sunday
        }
    }
}
