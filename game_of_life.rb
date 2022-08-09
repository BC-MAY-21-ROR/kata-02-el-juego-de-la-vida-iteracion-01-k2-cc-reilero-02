class Grid

  attr_accessor :grilla

  attr_reader :filas, :columnas

  def initialize(path_file)
    @grilla = []
    File.foreach(path_file) { |line|
      if line[0].to_i > 0
        @filas = line[0].to_i
        @columnas = line[2].to_i
      end

      if line[0].start_with?('.','*')
        empty_array = []
        line.split('').count.times do |v|
          if line[v] == '.' || line[v] == '*'
            empty_array.push(line[v])
          end
        end
        @grilla.push(empty_array)
      end
    }
    @generacion = 1
  end

  def next_generation
    nueva_grilla = Array.new(filas){Array.new(columnas){"."}}

    filas.times do |y|
      columnas.times do |x|
        alive = grilla[y][x] == '*'

        alive_neighbors = [
          grilla[y-1][x-1] == "*", # Top left
          grilla[y-1][x  ] == "*", # Top center
          grilla[y-1][x+1] == "*", # Top right
          grilla[y  ][x+1] == "*", # Right
          (grilla[y+1][x+1] == "*" if grilla[y+1] != nil), # Bottom right
          (grilla[y+1][x  ] == "*" if grilla[y+1] != nil), # Bottom center
          (grilla[y+1][x-1] == "*" if grilla[y+1] != nil), # Bottom left
          grilla[y  ][x-1] == "*" # Left
        ].count(true)


        if((alive && alive_neighbors.between?(2,3)) || (!alive && alive_neighbors === 3))
          nueva_grilla[y][x] = "*"
        end
      end
    end

    self.grilla = nueva_grilla
  end

  def print_grilla
    filas.times do |y|
      puts grilla[y].join
    end
  end

end


elGrid = Grid.new('./generacion_1.txt')
elGrid.print_grilla
puts "---------"
elGrid.next_generation
elGrid.print_grilla
puts "---------"
elGrid.next_generation
elGrid.print_grilla
puts "---------"
elGrid.next_generation
elGrid.print_grilla
puts "---------"
elGrid.next_generation
elGrid.print_grilla



