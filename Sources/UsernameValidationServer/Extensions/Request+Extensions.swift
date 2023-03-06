import Foundation
import Embassy

extension Request {
    var input: Data? {
        set {
            guard let newValue = newValue else { self["swsgi.input"] = nil; return  }
            let inputFunc: SWSGIInput = { (function: ((Data) -> Void)?) in function?(newValue) }
            self["swsgi.input"] = inputFunc
        }
        get {
            guard let function = self["swsgi.input"] as? SWSGIInput else { return nil }
            var data: Data?

            function({ inData in
                guard inData.count > 0 else { return }
                data = inData
            })

            return data
        }


    }

    var path: String? {
        set {
            self["PATH_INFO"] = newValue
        }
        get {
            self["PATH_INFO"] as? String
        }
    }
}
