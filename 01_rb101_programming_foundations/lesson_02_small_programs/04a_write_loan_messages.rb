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

  loan_duration: {
    input_message: "Please enter loan duration in parenthesis in the "\
                   "following format: (years, months)",
    invalid_format: "Your loan duration is not in the right format. "\
                   "Please enter loan duration in parenthesis in the "\
                   "following format: (years, months)",
    invalid_range: "Loan duration have to be at least 1 month. "\
                   "Please try again!",
    non_numeric: "One or more of the duration inputs doesn't look like "\
                 "a number... Please try again!"
  },

  loan_summary: <<-MSG,
  *** Your Loan Summary ***
    
    Loan Principal: $%.2f
    Annual Percentage Rate: %.4g \%
    Loan Duration: %.4g years, %.4g months
    
    Monthly repayment: $%.2f
    Monthly interest rate: %.4g \%
    # of repayment months: %.4g
    Total interest: $%.2f
    
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
