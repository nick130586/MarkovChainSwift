import Foundation

enum ParseError: String, Error {
    case invalidPath = "invalid path"
}

class CorpusParser {
    
    func parse(fileName: String) -> [Substring]? {
        do {
            let filePath = try path(to: fileName)
            return text(at: filePath)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func path(to fileName: String) throws -> String {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            return path
        }
        throw ParseError.invalidPath
    }
   
    private func text(at path: String) -> [Substring]? {
        do {
            let fileContents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let filtered = fileContents.replacingOccurrences(of: "\\\n", with: " ")
            return filtered.split(separator: " ")
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

