# Classe avec forces
## Code de base
```java
//... autre code ...

// Code de base pour update
// adapter pour la classe
void update()  {
    velocity.add(acceleration);
    velocity.limit(maxSpeed); // Si limite de vitesse
    location.add(velocity);

    acceleration.mult(0); // On remet l'accélération à 0
}

// Fonction pour ajouter une force à l'accélération
void applyForce(PVector force) {
    var f = PVector.div(force, mass);
    acceleration.add(f);
}

//... autre code ...
```