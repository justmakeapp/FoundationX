import Foundation

public extension Calendar {
    func endOfDayBeforeDay(_ date: Date) -> Date {
        return startOfDay(for: date).addingTimeInterval(-1)
    }

    func endOfDay(_ date: Date) -> Date? {
        let startOfDay = self.startOfDay(for: date)
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return self.date(byAdding: components, to: startOfDay)
    }

    func startOfDayAfterDay(_ date: Date) -> Date? {
        return endOfDay(date)?.addingTimeInterval(1)
    }

    var tomorrow: Date? {
        return startOfDayAfterDay(Date())
    }
}
