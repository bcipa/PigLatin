class PigLatinTranslator
	VOWELS = "aeiouy"

	def translate_phrase(phrase)
		allWords = phrase.split(" ")

		completedTranslation = allWords.map{|word| translate_word(word)}
		completedTranslation.join(" ")
	end

	def translate_word(word)			
    wordToTranslate, punctuation = remove_punctuation(word)
    
		if VOWELS.include?(wordToTranslate[0].downcase)
			translation = "#{wordToTranslate}way#{punctuation}"
		else
			translation = "#{append_leading_consonants(wordToTranslate) + "ay#{punctuation}"}"
		end

    translation.capitalize! if word[0] == word[0].upcase 
		translation.upcase! if word == word.upcase
		
		return translation
	end

  def remove_punctuation(word)
    word.scan(/[\w'-]+|[[:punct:]]+/)
  end

	def append_leading_consonants(word)
		word.concat(word.slice!((/^(qu|[^aeiou])*/i) || ""))
	end
end

testCases = ["hello", "eat", "yellow", "eat world", "Hello", "Apples", "eat... world?!", "school", "quick", "she's great!", "HELLO", "Hello There"]
expectedResults = ["ellohay", "eatway", "yellowway", "eatway orldway", "Ellohay", "Applesway", "eatway... orldway?!", "oolschay", "ickquay", "e'sshay eatgray!", "ELLOHAY", "Ellohay Erethay"]

translator = PigLatinTranslator.new

testCases.each_with_index do |phrase, i|
	translation = translator.translate_phrase(phrase)
  p "-------------------"
	p "Expected: #{expectedResults[i]}"
  p "Result: #{translation}"
  p translation == expectedResults[i] ? "Correct" : "Incorrect"
	p "-------------------"
end
