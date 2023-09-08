enum AppError: Error {
    case decoding
    case networking
    case unknown
    
    var title: String {
        switch self {
        case .decoding:
            return "Decoding error"
        case .networking:
            return "Networking error"
        case .unknown:
            return "Unknown error"
        }
    }
    
    var message: String {
        switch self {
        case .decoding:
            return "Can't decode data"
        case .networking:
            return "Check your url adress"
        case .unknown:
            return "Something went wrong"
        }
    }
}
