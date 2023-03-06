extension Request {
//    var path: String? { self["PATH_INFO"] }
    var path: String? {
        set {
            self["PATH_INFO"] = newValue
        }
        get {
            self["PATH_INFO"] as? String
        }
    }
}
