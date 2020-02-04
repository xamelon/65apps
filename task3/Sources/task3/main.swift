import Foundation
import Alamofire

print("Username: ")
guard let username = readLine()?.trimmingCharacters(in: CharacterSet.urlPathAllowed.inverted),
    !username.isEmpty else {
        print(Constants.RequestError.userNotFound.rawValue)
    exit(0)
}

let url = URL(string: "https://api.github.com/users/\(username)/repos")!

Alamofire.request(url)
    .validate()
    .responseJSON(queue: DispatchQueue.global(qos: .background), options: .allowFragments) { response in
        if let error = response.error {
            switch error {
            case URLError.notConnectedToInternet:
                print(Constants.RequestError.noInternetConnection.rawValue)
                exit(0)
            case AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 404)):
                print(Constants.RequestError.userNotFound.rawValue)
                exit(0);
            default:
                print(Constants.RequestError.unknownError.rawValue)
            }
        }
        guard let data = response.data,
            let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                print(Constants.RequestError.parseError.rawValue)
            exit(0)
        }
        print("Repositories: \(repositories)")
        exit(0)
}

while(true) {}
