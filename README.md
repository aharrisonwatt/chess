#Chess
Ruby chess program with well defined organizational structure and formulaic math to flexibly determine potential piece movement.     
###Checking Legal Moves
Determines if there is a piece between by recursively checking spaces between the end position and current position.  Utilizes the spaceship operator to increment correctly between the two points.

```Ruby
def piece_between?(new_pos)
  current_row, current_col = @pos
  new_row, new_col = new_pos
  #move new_row/col one set closer to @pos
  new_row += (current_row <=> new_row)
  new_col += (current_col <=> new_col)
  #no piece between if they == to eachother
  return false if [new_row, new_col] == @pos
  #recursive call
  if @board.empty?([new_row, new_col])
    piece_between?([new_row, new_col])
  else
    true
  end
end
```
###Knight movement
Knight is dynamically generated based on the difference between a potential position and the knights current position taking into account if the potential position is currently occupied or not.

```Ruby
def moves
  current_row, current_col = @pos
  @board.all_pos.reject do |new_row, new_col|
    row_diff = (new_row - current_row).abs
    col_diff = (new_col - current_col).abs
    row_diff > 2 ||
    col_diff > 2 ||
    row_diff + col_diff != 3 ||
    not_takeable?([new_row, new_col])
  end
end
```
