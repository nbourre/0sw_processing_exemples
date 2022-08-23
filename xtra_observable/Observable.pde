interface IObserver {
  void update(String event);
}

interface ISubject {
  int addObserver(IObserver obs);
  int removeObserver(IObserver obs);
  void NotifyObservers(String event);
}

abstract class Observable {
  
  ArrayList<IObserver> observers;
  
  int addObserver(IObserver obs) {
    if (observers == null) {
      observers = new ArrayList<IObserver>();
    }
    
    observers.add(obs);
    
    return observers.size();
  }
  
  int removeObserver(IObserver obs) {
    observers.remove(obs);
    
    return observers.size();
  }
  
  void NotifyObservers(String event){
    observers.forEach(obs -> obs.update(event)); 
  }  
}
