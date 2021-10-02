require "yaml"

# Load message configurations
MESSAGES = YAML.load_file("03b_calculator_messages.yml")

# Constants
LANGUAGES = { '1' => :en, '2' => :es }
OPERATIONS = %w(1 2 3 4)
COMPUTE_MESSAGE = {
  en: { '1' => 'Adding',
        '2' => 'Subtracting',
        '3' => 'Multiplying',
        '4' => 'Dividing' },
  es: { '1' => 'Agregando',
        '2' => 'Restando',
        '3' => 'Multiplicar',
        '4' => 'Divisor' }
}

CALCULATE_AGAIN = %w(yes y no n)

# Methods
def get_message(context, language)
  MESSAGES[language][context]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def get_language
  language = nil
  loop do
    language = Kernel.gets().chomp()
    break if LANGUAGES.keys.include?(language)
    prompt("Invalid choice. Please choose #{LANGUAGES.keys().join(' or ')}!")
  end

  LANGUAGES[language]
end

def get_name(language)
  name = ''
  loop do
    name = Kernel.gets().chomp()

    break unless name.empty?()
    prompt(get_message(:invalid_name, language))
  end

  name
end

def numeric?(string)
  Float(string, exception: false) ? true : false # truthy for any numeric string
end

def get_number(operand, language)
  number = ''
  loop do
    prompt(get_message(operand, language))
    number = Kernel.gets().chomp()

    break if numeric?(number)
    prompt(get_message(:invalid_number, language))
  end

  number.to_f
end

def get_operation(operation_prompt, language)
  prompt(get_message(operation_prompt, language))

  operation = ''
  loop do
    operation = Kernel.gets().chomp()

    break if %w(1 2 3 4).include?(operation)
    prompt(get_message(:invalid_operation, language))
  end

  operation
end

def operation_to_message(op, language)
  COMPUTE_MESSAGE[language][op]
end

def compute(number1, number2, operation)
  result = case operation
           when '1'
             number1 + number2
           when '2'
             number1 - number2
           when '3'
             number1 * number2
           when '4'
             if number2 == 0
               nil
             else
               number1 / number2
             end
           end

  result
end

def calculate_again?(language)
  prompt(get_message(:new_calculation, language))

  user_response = ''
  loop do
    user_response = Kernel.gets().chomp().downcase()

    break if CALCULATE_AGAIN.include?(user_response)
    prompt(get_message(:continue_or_not, language))
  end

  user_response == 'y' || user_response == 'yes'
end

# main
prompt(get_message(:language, :na))
language = get_language()

prompt(get_message(:welcome, language))
name = get_name(language).capitalize

system("clear")
prompt(format(get_message(:hi, language), field: name))

loop do # main loop
  number1 = get_number(:first_number, language)
  number2 = get_number(:second_number, language)

  operation = get_operation(:operation_prompt, language)
  prompt(format(get_message(:computing, language),
                field: operation_to_message(operation, language)))

  result = compute(number1, number2, operation)
  if result
    if result % 1 == 0
      result = result.to_i
    end
    prompt(format(get_message(:result, language), field: result))

  else
    prompt(get_message(:div_zero, language))
  end

  break unless calculate_again?(language)
  system("clear")
end

prompt(get_message(:thank_you, language))
