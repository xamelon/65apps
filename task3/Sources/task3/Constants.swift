struct Constants {
    enum RequestError : String {
        case noInternetConnection = "You are not connected to the internet"
        case userNotFound = "User not found"
        case unknownError = "Unknown error"
        case parseError = "Cannot parse response"
    }
}
