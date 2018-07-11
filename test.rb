@uppercase_alphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
@lowercase_alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"

def downcase_word(word)
	return word.tr(@uppercase_alphabet, @lowercase_alphabet)
end

puts downcase_word("Привет Првет")
puts "HEY"
