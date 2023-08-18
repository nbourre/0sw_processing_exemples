class World {
  
  Generator gen;
  Map map;
  
  World() {
    gen = new Generator();
    
    map = gen.Generate(width, height);
  }
  
  void update (float deltaTime) {
  }
  
  void display(){
    map.display();
  }
}
