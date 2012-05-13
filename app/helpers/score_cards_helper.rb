# encoding: utf-8

module ScoreCardsHelper  
  def tee_boxes
    [['黑','black'], ['金','gold'], ['蓝','blue'], ['白','white'], ['红','red']]
  end
  
  def t_clubs
    ['1W', '3W', '5W', '1Hy', '2Hy', '3i', '4i', '5i', '6i', '7i', '8i', '9i', 'Pw', 'Gw', 'Sw', 'Lw']
  end
  
  def fairways
    [['长','long'], ['左侧','left'], ['命中','hit'], ['右侧','right'], ['短','short']]
  end
  
  def start_hole
    [1, 10]
  end
end
