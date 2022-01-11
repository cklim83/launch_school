=begin

Transpose 3x3

A 3 x 3 matrix can be represented by an Array of Arrays in which the main
Array and all of the sub-Arrays has 3 elements. For example:

1  5  8
4  7  2
3  9  6

can be described by the Array of Arrays:

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

An Array of Arrays is sometimes called nested arrays because each of the
inner Arrays is nested inside an outer Array.

To access an element in matrix, you use Array#[] with both the row index and
column index. So, in this case, matrix[0][2] is 8, and matrix[2][1] is 9. An
entire row in the matrix can be referenced by just using one index: matrix[1]
is the row (an Array) [4, 7, 2]. Unfortunately, there's no convenient notation
for accessing an entire column.

The transpose of a 3 x 3 matrix is the matrix that results from exchanging the
columns and rows of the original matrix. For example, the transposition of the
array shown above is:

1  4  3
5  7  9
8  2  6

Write a method that takes a 3 x 3 matrix in Array of Arrays format and returns
the transpose of the original matrix. Note that there is a Array#transpose
method that does this -- you may not use it for this exercise. You also are
not allowed to use the Matrix class from the standard library. Your task is to
do this yourself.

Take care not to modify the original matrix: you must produce a new matrix and
leave the original matrix unchanged.

Examples

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

This program should print "true" twice.
=end

=begin
Problem
- input: a 3x3 matrix in Array of Arrays format
- out: a new Array of Array representing the transpose of the input matrix

Examples
- requirements
  - new matrix, with input unchanged
  - rows of original matrix should become its column

Data Structure
- input: array of array
- output: new array of array

Algorithm
1. set transpose_matrix = duplicate of input_matrix
2. Iterate through each row with row_index in input matrix
    Iterate through each item with column_index in each row
      transpose[col_index][row_index] = item i.e. transpose[j][i] = matrix[i][j]
   end
3. Return transpose
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


matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]


=begin
Solution

def transpose(matrix)
  result = []
  (0..2).each do |column_index|
    new_row = (0..2).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end

Discussion

This is a little tricky to get right with the indexing, but is actually fairly
straightforward.

If you examine the example matrix and the resulting example transpose matrix,
you will see that what used to be the first column of the matrix becomes the
first row of the result, what used to be the second column becomes the second
row, and what used to be the third column becomes the third row. We use this
insight to implement our method.

We start by initializing the result Array, then we iterate through the columns
in our original matrix. In each iteration, we construct a new row consisting
of all of the elements in that column, and append that to our result. Thus, the
first column becomes the first row in the result, the second column becomes the
second row, and the third column becomes the third row. Finally, we return the
result.

The first p command demonstrates that the result matrix is correct, and the
second p command confirms that the original matrix is unmodified.

Further Exploration

Write a transpose! method that transposes a matrix in place. The obvious
solution is to reuse transpose from above, then copy the results back into
the array specified by the argument. For this method, don't use this approach;
write a method from scratch that does the in-place transpose.
=end


=begin
TO REVIEW (Important)
- clone/dup will only copy the object calling it, but reuse the inner elements,
  thus my initial solution below unexpectedly mutate original matrix unintentionally,
  resulting in unexpected and erroneous result
  
    def transpose(matrix)
      transpose_matrix = matrix.clone
  
      matrix.each_with_index do |row, row_index|
        row.each_with_index do |item, col_index|
          puts "#{row_index} #{col_index} #{item}"
          transpose_matrix[col_index][row_index] = item
          p matrix
          p transpose_matrix
        end
      end
  
      transpose_matrix
    end
    
=end