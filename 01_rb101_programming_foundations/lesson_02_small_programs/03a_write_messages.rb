require "yaml"

calculator_messages = {
  na: {
    language: <<-MSG
    Please select preferred language / Seleccione el idioma preferido
    1) English
    2) Español 
  MSG
  },

  en: {
    welcome: "Welcome to Calculator! Enter your name:",
    invalid_name: "Make sure to use a valid name.",
    invalid_number: "Hmm... this doesn't look like a valid number",
    hi: "Hi %{field}!",
    first_number: "What's the first number?",
    second_number: "What's the second number?",
    operation_prompt: <<-MSG,
      What operation would you like to perform?
      1) add
      2) subtract
      3) multiply
      4) divide
    MSG
    invalid_operation: "Must choose 1, 2, 3 or 4",
    div_zero: "Invalid calculation, division by zero encountered!",
    computing: "%{field} the two numbers...",
    result: "The result is %{field}",
    new_calculation: "Do you want to perform another calculation?"\
                     " ('Y' to continue, any other key to quit)",
    thank_you: "Thank you for using the calculator. Good bye!"
  },

  es: {
    welcome: "¡Bienvenido a Calculadora! Introduzca su nombre:",
    invalid_name: "Asegúrate de usar un nombre válido.",
    invalid_number: "Hmm ... esto no parece un número válido",
    hi: "Hola %{field}!",
    first_number: "¿Cuál es el primer número?",
    second_number: "¿Cuál es el segundo número?",
    operation_prompt: <<-MSG,
      ¿Qué operación le gustaría realizar?
      1) agregar
      2) sustraer
      3) multiplicar
      4) dividir
    MSG
    invalid_operation: "Debe elegir 1, 2, 3 o 4",
    div_zero: "¡Cálculo no válido, se ha encontrado una división por cero!",
    computing: "%{field} los dos números...",
    result: "El resultado es %{field}",
    new_calculation: "¿Quieres realizar otro cálculo?"\
                     " ('Y' para continuar, cualquier otra tecla para salir)",
    thank_you: "Gracias por usar la calculadora. ¡Adiós!"
  }
}

File.write("03b_calculator_messages.yml", calculator_messages.to_yaml)
