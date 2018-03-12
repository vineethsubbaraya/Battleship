class Battleship
  attr_reader :board, :size
  SHIPS = {T: 2, D: 3, S: 3, B: 4, C: 5} #Hash of ships
  DIR = ["H", "V"] #two direction (horizontal & vertical)

  #initialize a 10x10 board with "."
  def initialize(size = 10)
    @size = size
    @board = Array.new(@size) {Array.new(@size, ".") }
  end

  #Create the initial board
  def create_board
    SHIPS.each do |key, val|
      place_ship(key, val)
    end
  end

  #Place each ship on the board
  def place_ship(name, len)
    coordinates = get_random
    dir = get_dir
    if is_empty?(coordinates)
      if dir == "H"
        size = len + coordinates[1]-1
        if row_clear(coordinates, size)
          add_ships(coordinates,coordinates[1], size, dir, name)
        else
          if free_rows_cols(coordinates,name,len)
            place_ship(name,len)
          end

        end
      else
        size = len + coordinates[0]-1
        if col_clear(coordinates, size)
          add_ships(coordinates, coordinates[0], size, dir, name)
        else
          if free_rows_cols(coordinates,name,len)
            place_ship(name,len)
          end
        end
      end
    else
      place_ship(name,len)
    end
  end

  #Add a ship on the board based on free places in a row or column
  def free_rows_cols(coordinates,name, len)
    free_rows = free_rows(coordinates[0])
    free_rows.each do |arr|
      if arr.first && len<=arr.last
        add_ships(coordinates,arr[1], (arr[1]+len-1), "H", name)
        return false
      end
    end

    free_cols = free_cols(coordinates[1])
    free_cols.each do |arr|
      if arr.first && len<=arr.last
        add_ships(coordinates,arr[1], (arr[1]+len-1), "V", name)
        return false
      end
    end
    return true

  end

  #Add ships on the board based on the direction
  def add_ships(coordinates,start,finish, dir, name)
    if dir == "H"
      for i in start..finish
        @board[coordinates[0]][i] = "#{name}"
      end
    elsif dir == "V"
      for i in start..finish
        @board[i][coordinates[1]] = "#{name}"
      end
    end
  end

  # Print the board
  def print_board
    @board.each { |arr| puts arr.join(" ")}
  end

  private
  
  #Get random coordinates
  def get_random
    [rand(0..(@size-1)), rand(0..(@size-1))]
  end

  #Get random direction
  def get_dir
    DIR.sample
  end

  #Check if coordinate is empty
  def is_empty?(xy)
    @board[xy[0]][xy[1]] == "."
  end

  #Check if ship length goes out of board
  def out_of_bound?(len)
    len >= @size
  end

  #Get all array chunks that are free in a row
  def free_rows(row)
    @board[row].each_with_index.chunk {|x,i| x=="."}.map do |flag, arr|
      [flag, arr.first[1], arr.last[1] - arr.first[1] + 1]
    end
  end

  #Get all array chunks that are free in a column
  def free_cols(col)
    @board.transpose[col].each_with_index.chunk {|x,i| x=="."}.map do |flag, arr|
      [flag, arr.first[1], arr.last[1] - arr.first[1] + 1]
    end
  end

  #Check if place is clear next to a coordinate along the row
  def row_clear(xy,len)
    if out_of_bound?(len)
      return false
    end
    i=xy[1]
    while(i<=len) do
      if @board[xy[0]][i] != "."
        return false
      end
      i +=1
    end

    return true
  end

  #Check if place is clear next to a coordinate along the column
  def col_clear(xy, len)
    if out_of_bound?(len)
      return false
    end
    i=xy[0]
    while(i<=len) do
      if @board[i][xy[1]] != "."
        return false
      end
      i +=1
    end

    return true
  end
end

