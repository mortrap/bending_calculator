module Vmatrix
  def self.v_matrix(radius)
    case  radius
    when (0.8..1)  
      6
    when (1.3..1.5)
      8 
    when (1.7..1.8)
      10
    when (2.0..2.2)
      12
    when (2.5..2.7)
      16
    when (3.0..3.4)
      20
    when (3.5..3.7)
      22
    else
      puts "There is no such matrix"
    end
  end
end
