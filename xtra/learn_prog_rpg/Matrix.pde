class Matrix {
  int x;
  int y;
  int cols;
  int rows;
  
  int cellWidth;
  int cellHeight;
  
  ArrayList<ArrayList<Cell>> cells;
  
  Matrix (int nbRows, int nbColumns) {
    x = 0;
    y = 0;
    
    cols = nbColumns;
    rows = nbRows;
    
    cellWidth = width / cols;
    cellHeight = height / rows;
    
    init();
  }      
  
  void init() {
    
    cells = new ArrayList<ArrayList<Cell>>();
    
    for (int j = 0; j < rows; j++){
      // Instanciation des rangees
      cells.add (new ArrayList<Cell>());
      
      for (int i = 0; i < cols; i++) {
        Cell temp = new Cell(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
        cells.get(j).add (temp);
      }
    }
  }
  
  void displayRow (int j) {
    ArrayList<Cell> row = cells.get(j);
    
    for (int i = 0; i < row.size(); i++) {
      Cell current = row.get(i);
      current.display();       
    }
  }
  
  void display () {
    for (int j = 0; j < cells.size(); j++) {
      displayRow(j);
    }
  }
  
  Cell getCell (int i, int j) {
    return cells.get(j).get(i);
  }
  
}
