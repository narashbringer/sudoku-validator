class SudokuValidator

  def valid?(str)
    #validate horizontal rows have 1-9 only once.
    row_items = valid_rows(str)
    if row_items==false
      return false
    end

    # validate columns have 1-9 only once.
    i = 0
    column_index = 0
    while i < 9
      row_items = []
      #split string by colums 
      str.split("\n").each { |row|
        # check it is not padding row
        if row != '------+------+------'
          row_items << row[column_index]
        end
      }
        # check if we are not fully filled out
        if row_items.uniq.count < 9
          return false
        else
          # check if we are at a breack character and skip to next interesting character
          column_index += 2
          if str.split("\n").first[column_index] == '|'
            column_index += 2
          end
        end

        i += 1
      end

    # validate squares
    #
    # Diagram of different blocks to check: 
    # 1 | 2 | 3
    # - - - - -
    # 4 | 5 | 6
    # - - - - -
    # 7 | 8 | 9
    #
    # squares blocks row group 1 from the diagram above
    temp = validate_block(str,0,3,0,3)
    if temp == false
      return false
    end
    
    # squares blocks row group 2 from the diagram above
    temp = validate_block(str,0,3,4,7)
    if temp == false
      return false
    end

    # squares blocks row group 3 from the diagram above
    temp = validate_block(str,0,3,8,11)
    if temp==false
      return false
    end
    # squares blocks row group 4 from the diagram above
    temp = validate_block(str,4,7,0,3)
    if temp==false
      return false
    end

    # squares blocks row group 5 from the diagram above
    temp = validate_block(str,4,7,4,7)
    if temp==false
      return false
    end
    
    # squares blocks row group 6 from the diagram above
    temp = validate_block(str,4,7,8,11)
    if temp==false
      return false
    end

    # squares blocks row group 7 from the diagram above
    temp = validate_block(str,8,11,0,3)
    if temp==false
      return false
    end

    # squares blocks row group 8 from the diagram above
    temp = validate_block(str,8,11,4,7)
    if temp==false
      return false
    end

    # squares blocks row group 9 from the diagram above
    temp = validate_block(str,8,11,8,11)
    if temp==false
      return false
    end

    return true
  end

  def valid_rows(str)
    # validate rows to make sure they have 1-9 only once.
    str.split("\n").each do |row|
      if row != '------+------+------'
        rowItems = []
        row.split(' ').each do |col|
          if col != '|'
            rowItems.push(col)
          end
        end
        if rowItems.uniq.count < 9
          return false
        end
      end
    end
  end

  def validate_block(str, row_min,row_max,col_min,col_max)

    row_items = []
    # Iterrate though the square and check that we are in the box.
    # After that check that each number only shows up once.
    str.split("\n").each_with_index do |row, j|
      row.split(' ').each_with_index do |col, k|
        if k >= col_min and k < col_max && j >= row_min and j < row_max
          row_items.push(col)
        end
      end
    end
    if row_items.uniq.count < 9
      return false
    end
  end
end