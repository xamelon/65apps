import Foundation

struct task4 {
    private static let emailRegexp = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
    "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
    "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
    "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
    "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
    "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    
    private static let nicknameRegexp = "^[a-z][a-z0-9.-]*$"
    
    static func isValidLogin(_ login: String) -> Bool {
        if !(login.count > 2 && login.count < 33) {
            return false
        }
        
        if login.contains("@") {
            return isValidEmail(login)
        } else {
            return isValidNickname(login)
        }
    }
    
    
    
    static private func isValidEmail(_ email: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegexp)
        let result = predicate.evaluate(with: email)
        
        return result
    }
    
    static private func isValidNickname(_ nickname: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", nicknameRegexp)
        return predicate.evaluate(with: nickname)
    }
    
}
