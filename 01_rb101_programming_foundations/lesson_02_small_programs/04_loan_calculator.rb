=begin
PEDAC

Problem
  Inputs:
  - Loan Amount (loan_principal),
  - Annual Percentage Rate (annual_pct_rate),
  - Loan Duration in Years (loan_yrs)

  Output:
  - Monthly Repayment Amount (monthly_repayment),
  - Monthly Percentage Rate (monthly_pct_rate),
  - Loan Duration in Months (loan_months)

  Relationships
  - monthly_pct_rate = annual_pct_rate / 12
  - loan_months = loan_years * 12
  - numerator = loan_principal *  monthly_pct_rate
  - denominator = 1 - (1 + monthly_pct_rate)**(-loan_months)
  - monthly_repayment = numerator / denominator

  Implicit requirements
  - User input numeric strings for each of the three inputs
  - Annual percentage rate has to be in the format 0.05 for 5%
    based on the formula.

  Clarifications:
  - What range of values can the inputs take?
  - loan_principal: Assume >= 0 since negative loans does not make sense
  - annual_pct_rate: Assume >= 0 since it doesnt make sense to have negative
    rates. For rates = 0, monthly repayment will need new computation.
  - loan_years: Assume > 0 since loan duration of 0 leads to a division by
                zero error

Examples
  1) loan_principal = 100_000, annual_pct_rate = 10, loan_years = 10
  - Expected output: loan_months = 120, monthly_pct_rate = 0.833%,
                     monthly_repayment = 1321.51

  2) loan_principal = 0, annual_pct_rate = 10, loan_years = 10
  - Expected output: loan_months = 120, monthly_pct_rate = 0.833%,
                     monthly_repayment = 0

  3) loan_principal = 100_000, annual_pct_rate = 0, loan_years = 10
  - Expected output: loan_months = 120, monthly_pct_rate = 0.0%,
                     monthly_repayment = 833.33

  4) loan_principal = 100_000, annual_pct_rate = 10, loan_years = 0
  - Invalid loan period, should be greater than 0

Data structure
- All inputs and outputs can be represented by float

Algorithm
- Welcome user to loan calculator!
- Loop
  - Assign loan_principal to nil
  - Loop
      Prompt user to enter loan_principal
      Exit loop if loan_principal is a valid numeric and >= 0
      Print invalid loan_principal message and go back to start of loop
  - Assign annual_pct_rate to nil
  - Loop
      Prompt user to enter annual_pct_rate
      Exit loop if annual_pct_rate is a valid numeric and >= 0
      Print invalid annual_pct_rate message and go back to start of loop
  - Loop
      Prompt user to enter loan_years
      Exit loop if loan_years is a valid numeric and > 0
      Print invalid loan_years message and go back to start of loop
  - Compute monthly_pct_rate by dividing annual_pct_rate by 12
  - Compute loan_months by multiplying loan_years by 12
  - Compute monthly_repayment using above formula
  - Print out loan summary
  - Prompt user if they like another calculate
  - Exit main loop if they choose to quit
- Print thank you!

=end

# Code
require "yaml"

# Load message configurations
MESSAGES = YAML.load_file("04b_loan_messages.yml")

# Constants
CONTINUE_RESPONSES = %w(y yes n no)
MONTHS_IN_YEAR = 12
PRECISION = 2

# Methods
def prompt(message)
  puts "=> " + message
end

def numeric?(string)
  Float(string, exception: false) ? true : false
end

def valid_range?(input_type, value)
  if input_type == :loan_years && value > 0
    true
  elsif input_type != :loan_years && value >= 0
    true
  else
    false
  end
end

def get_input(input_type)
  input_value = nil
  loop do
    prompt(MESSAGES[input_type][:input_message])
    input_value = gets.chomp

    if numeric?(input_value)
      input_value = input_value.to_f

      break if valid_range?(input_type, input_value)
      prompt(MESSAGES[input_type][:invalid_range])

    else
      prompt(MESSAGES[input_type][:non_numeric])
    end
  end

  input_value
end

def calculate_again?
  prompt(MESSAGES[:continue][:continue_message])

  user_response = nil
  loop do
    user_response = gets.chomp.downcase

    break if CONTINUE_RESPONSES.include? user_response
    prompt(MESSAGES[:continue][:invalid_message])
  end

  if user_response == 'y' || user_response == 'yes'
    true
  else
    false
  end
end

def compute_monthly_payment(loan_principal, monthly_pct_rate, loan_months)
  if monthly_pct_rate > 0
    numerator = loan_principal * monthly_pct_rate
    denominator = 1 - ((1 + monthly_pct_rate)**(-loan_months))
    monthly_repayment = numerator / denominator
  else
    monthly_repayment = loan_principal / loan_months # edge case when rate = 0
  end

  monthly_repayment
end

# main
system("clear")
prompt(MESSAGES[:welcome])

loop do
  loan_principal = get_input(:loan_principal)
  annual_pct_rate = get_input(:annual_pct_rate) / 100
  loan_years = get_input(:loan_years)

  monthly_pct_rate = annual_pct_rate / MONTHS_IN_YEAR
  loan_months = loan_years * MONTHS_IN_YEAR
  monthly_repayment = compute_monthly_payment(loan_principal,
                                              monthly_pct_rate,
                                              loan_months)
  total_interest = monthly_repayment * loan_months - loan_principal

  prompt(format(MESSAGES[:loan_summary],
                loan_principal: loan_principal.round(PRECISION),
                annual_pct_rate: (annual_pct_rate * 100).round(PRECISION),
                loan_years: loan_years.round(PRECISION),
                monthly_repayment: monthly_repayment.round(PRECISION),
                monthly_pct_rate: (monthly_pct_rate * 100).round(PRECISION),
                loan_months: loan_months.round(PRECISION),
                total_interest: total_interest.round(PRECISION)))

  break unless calculate_again?
  system("clear")
end

prompt(MESSAGES[:goodbye])
