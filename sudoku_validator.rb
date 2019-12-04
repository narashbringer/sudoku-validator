class SudokuValidator

  def valid?(str)
    row_items=valid_rows(str)
    if row_items==false
      return false
    end
    # validate vertical rows
    i = 0
    column_index = 0
    while i < 9
      row_items = []
      str.split("\n").each { |row|
        if row != '------+------+------'
          row_items << row[column_index]
        end
      }
        if row_items.uniq.count < 9
          return false
        else
          column_index += 2
          if str.split("\n").first[column_index] == '|'
            column_index += 2
          end
        end

        i += 1
      end

    # validate squares
    # squares blocks row group 1
    temp = validate_block(str,0,3,0,3)
    if temp == false
      return false
    end
    temp = validate_block(str,0,3,4,7)
    if temp == false
      return false
    end
    temp = validate_block(str,0,3,8,11)
    if temp==false
      return false
    end
    # squares blocks row group 2
    temp = validate_block(str,4,7,0,3)
    if temp==false
      return false
    end
    temp = validate_block(str,4,7,4,7)
    if temp==false
      return false
    end
    temp = validate_block(str,4,7,8,11)
    if temp==false
      return false
    end
    # squares blocks row group 3
    temp = validate_block(str,8,11,0,3)
    if temp==false
      return false
    end
    temp = validate_block(str,8,11,4,7)
    if temp==false
      return false
    end
    temp = validate_block(str,8,11,8,11)
    if temp==false
      return false
    end
    return true
  end

  def valid_rows(str)
    # validate rows
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