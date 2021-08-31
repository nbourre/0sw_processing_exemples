/***
  Interface pour permettre d'avoir une
  classe qui permet d'acter dans une scène
**/
interface IActable {

  abstract void update(int deltaTime);
  abstract void display();
}
