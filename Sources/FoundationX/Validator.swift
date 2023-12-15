import Foundation

public enum Validator {
    public static func isValidEmail(_ email: String) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let range = NSRange(location: 0, length: email.utf16.count)
            let matches = detector.matches(in: email, options: [], range: range)

            if matches.count == 1, let match = matches.first, match.range.length == email.utf16.count {
                return match.url?.scheme == "mailto"
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
        }

        return false
    }
}
