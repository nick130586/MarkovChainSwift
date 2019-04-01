class TextGenerator {
    
    var corpus: String
    
    init(_ corpusName: String) {
        self.corpus = corpusName
    }

    func buildText(length: Int, start: String) {
        let analyser = CorpusAnalyser(corpusName: self.corpus)
        analyser.buildMatrix { ( result ) in
            var initial = Substring(start)
            var text = String(start)
            for _ in 0...length {
                if let next = analyser.nextWord(matrix: result, currentWord: initial) {
                    text.append(String(" \(next)"))
                    initial = next
                }
            }
            print("\(text)")
        }
    }
}
