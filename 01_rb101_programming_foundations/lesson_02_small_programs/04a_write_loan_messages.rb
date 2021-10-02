require "yaml"

LOAN_MESSAGES = {
  welcome: "Welcome to Loan Calculator!",

  loan_principal: {
    input_message: "What is the loan amount in dollars?",
    invalid_range: "Loan principal cannot be negative. Please try again!",
    non_numeric: "This doesn't look like a number... Please try again!"
  },

  annual_pct_rate: {
    input_message: "What is annual percentage rate? (e.g. Enter 5 for 5%)",
    invalid_range: "Annual percentage rate cannot be negative."\
                   "Please try again!",
    non_numeric: "This doesn't look like a number... Please try again!"
  },

  loan_years: {
    input_message: "What is the loan duration in years?",
    invalid_range: "Loan duration have to be a positive number. "\
                   "Please try again!",
    non_numeric: "This doesn't look like a number... Please try again!"
  },

  loan_summary: <<-MSG,
  *** Your Loan Summary ***
    
    Loan Principal: $%{loan_principal}
    Annual Percentage Rate: %{annual_pct_rate} \%
    Loan Duration (years): %{loan_years}
    
    Monthly repayment: $%{monthly_repayment}
    Monthly interest rate: %{monthly_pct_rate} \%
    # of repayment months: %{loan_months}
    Total interest: $%{total_interest}
    
    *** END ***
    
  MSG

  continue: {
    continue_message: "Would you like to calculate again? "\
                      "('y' to continue, 'n' to quit)",
    invalid_message: "Invalid response. Enter 'y' to continue, 'n' to quit!"
  },

  goodbye: "Thank you for using loan calculator. Good bye!"
}

File.write("04b_loan_messages.yml", LOAN_MESSAGES.to_yaml)
