class Forces {
  
  Forces () {
  }
  
  // Faux calcul qui prend une valeur scalaire pour la normale
  PVector friction (PVector vitesse, float coeffFriction, float normale) {
    PVector resultat = new PVector();
    
    resultat = vitesse.get();
    
    resultat.mult(-1);
    resultat.normalize(); // Réduire la direction en valeur unitaire
    

    resultat.mult(normale * coeffFriction);
    
    return resultat;
  }
}
