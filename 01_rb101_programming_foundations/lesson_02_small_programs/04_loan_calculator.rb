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
  - monthly_repayment = loan_principal * ( monthly_pct_rate / (1 - (1 + monthly_pct_rate)**(-loan_months)))

  Implicit requirements
  - User input numeric strings for each of the three inputs
  
  Clarifications:
  - What range of values can the inputs take?
  - loan_principal: Assume >= 0 since negative loans does not make sense
  - annual_pct_rate: Assume >= 0 since it doesnt make sense to have negative rates. For rates = 0, 
                     monthly repayment will need new computation.
  - loan_years: Assume > 0 since loan duration of 0 leads to a division by zero error

Examples
  1) loan_principal = 100_000, annual_pct_rate = 10, loan_years = 10
  - Expected output: loan_months = 120, monthly_pct_rate = 0.833%, monthly_repayment = 
  
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
  - Print out monthly_repayment to user
  - Prompt user if they like another calculate
  - Exit main loop if they choose to quit
- Print thank you! 

=end

def prompt(message)
  puts "=> " + message
end

def numeric?(string)
  Float(string, exception: false) ? true : false
end

def get_loan_principal
  loan_principal = nil
  loop do
    prompt("What is the loan amount in dollars?")
    loan_principal = gets.chomp
    
    if numeric?(loan_principal) && loan_principal.to_f >= 0
      loan_principal = loan_principal.to_f
      break
    else    
      prompt("You have entered an invalid loan amount. Please try again!")
    end
  end
  
  loan_principal 
end

def get_annual_rate
  annual_pct_rate = nil
  loop do
    prompt("What is annual percentage rate? (e.g. Enter 5 for 5%)")
    annual_pct_rate = gets.chomp
    
    if numeric?(annual_pct_rate) && annual_pct_rate.to_f >= 0
      annual_pct_rate = annual_pct_rate.to_f / 100
      break
    else
      prompt("You have entered an invalid annual percentage rate. Please try again!")
    end
  end
  
  annual_pct_rate 
end

def get_loan_years
  loan_years = nil
  loop do
    prompt("What is the loan duration (in years)?")
    loan_years = gets.chomp
    
    if numeric?(loan_years) && loan_years.to_f > 0
      loan_years = loan_years.to_f
      break
    else
      prompt("You have entered an invalid loan duration. Please try again!")
    end
  end
  
  loan_years
end

def calculate_again?
  prompt("Would you like to calculate again? ('y' to continue, 'n' to quit)")
  user_response = nil
  loop do
    user_response = gets.chomp.downcase
    
    break if %w(y yes n no).include? user_response
    prompt("Invalid response. Enter 'y' to continue, 'n' to quit!")
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

prompt("Welcome to Loan Calculator!")

loop do
  loan_principal = get_loan_principal
  annual_pct_rate = get_annual_rate
  loan_years = get_loan_years
  monthly_pct_rate = annual_pct_rate / 12.0
  loan_months = loan_years * 12
  monthly_repayment = compute_monthly_payment(loan_principal, 
                                              monthly_pct_rate, 
                                              loan_months)
  calculation_stats = <<-MSG
  *** Your Loan Summary ***
    Loan Principal: #{loan_principal}
    Annual Percentage Rate: #{annual_pct_rate*100} %
    Loan Duration (years): #{loan_years}
  MSG
  prompt("#{calculation_stats}")
  prompt("Your monthly repayment is #{monthly_repayment}!")
  break unless calculate_again?
end

prompt("Thank you for using loan calculator. Good bye!")
