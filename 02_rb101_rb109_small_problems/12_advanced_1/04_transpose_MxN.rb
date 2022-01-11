=begin

Transpose MxN

In the previous exercise, you wrote a method to transpose a 3 x 3 matrix
as represented by a ruby Array of Arrays.

Matrix transposes aren't limited to 3 x 3 matrices, or even square matrices.
Any matrix can be transposed by simply switching columns with rows.

Modify your transpose method from the previous exercise so it works with any
matrix with at least 1 row and 1 column.

Examples:

transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
transpose([[1]]) == [[1]]
=end

=begin
Already solve problem dynamically in 03_transpose_3by3. Hence same solution.
=end

def transpose(matrix)
  transpose_matrix = []
  matrix.each_with_index do |row, row_index|
    row.each_with_index do |item, col_index|
      if transpose_matrix[col_index] == nil
        transpose_matrix[col_index] = [] # cannot use a[index] << [] as it will raise error as a[index] return nil which do not have << method
      end
      transpose_matrix[col_index][row_index] = item
    end
  end
  
  transpose_matrix
end

p transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) == [[1]]


=begin
Solution

def transpose(matrix)
  result = []
  number_of_rows = matrix.size
  number_of_columns = matrix.first.size
  (0...number_of_columns).each do |column_index|
    new_row = (0...number_of_rows).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end

Discussion

With our previous solution, this exercise boils down to just determining the
correct number of rows and columns in the matrix. The number of rows is easy,
and we can get the number of columns by looking at any row and getting its
size (we assume that we have a well-formed matrix with rows of equal length).
After that, we just need to update our loops to use the new results.

Note that we also switch to using the 3 dot (...) form of the range operator
so we don't have to do (number_of_columns - 1) and (number_of_rows - 1).

Further Exploration

Some of you may have been able to solve this exercise without doing a thing;
if you determined your matrix size dynamically in the previous exercise
instead of relying on the 3 x 3 requirement, you solved both problems in one
step. However, almost everybody probably did a strict 3 x 3 solution for the
first exercise.

How do you think you would have fared if you had to start with this exercise?
How much harder would you have found the solution to be if you hadn't
encountered and solved the 3x3 case first?
=end