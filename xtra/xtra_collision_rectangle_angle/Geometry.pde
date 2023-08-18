static class Geometry {
  
  static float pointToLineDistance(PVector point, PVector p1, PVector p2) {
    float result = 0;
    
    float segmentLength = PVector.dist (p1, p2);
    
    if (segmentLength == 0) {
      return  PVector.dist (p1, point); 
    }
    
    float t = ((point.x - p1.x) * (p2.x - p1.x) + (point.y - p1.y) * (p2.y - p1.y)) / segmentLength;
    
    t = Math.max(0, Math.min (1, t));
    
    float tX = p1.x + t * (p2.x - p1.x);
    float tY = p1.y + t * (p2.y - p1.y);
    
    result = (point.x - tX) * (point.x - tX) + (point.y - tY) * (point.y - tY);
    
    result = sqrt (result);
    
    return result;
  }
  
  // Retourne les valeurs m et b
  // Pour l'équation de la droite y = mx + b
  static float[] pointsToMxB (PVector p1, PVector p2) {
    
    float [] result = new float[2];
    
    result[0] = getSlope (p1, p2);
    
    result[1] = p1.y - result[0] * p1.x;
    
    return result;
  }
  
  static float getSlope (PVector p1, PVector p2) {
    return (p2.y - p1.y) / (p2.x - p1.x);
  }
  
  // Retourne les valeurs A, B et C
  // Pour l'équation de la droite Ax + Bx + C = 0
  static float[] pointsToAxBxC (PVector p1, PVector p2) {
    float[] result = new float[3];
    
    result[0] = p1.y - p2.y;
    result[1] = p2.x - p1.x;
    result[2] = p1.x*p2.y - p2.x*p1.y;
    
    return result;
  }
  
  // Retourne le point le plus proche
  // d'une droite ax + bx + c = 0
  static PVector closestPointToLine(float a, float b, float c, PVector p) {
    if (b == 0 && a == 0) return null;
    
    PVector result = new PVector();
    
    float denom = a * a + b * b;
    
    result.x = (b * (b * p.x - a * p.y) - a * c) / denom;
    result.y = (a * (-b * p.x + a * p.y) - b * c) / denom;
    
    return result;  
  }
  
  static PVector closestPointToLine(PVector p1, PVector p2 , PVector p) {
    PVector result = null;
    
    float abc[] = pointsToAxBxC(p1, p2);
    
    result = closestPointToLine(abc[0], abc[1], abc[2], p);
    
    return result;  
  }
  
  // Regarde si un point est sur une droite
  // Src : https://stackoverflow.com/questions/11907947/how-to-check-if-a-point-lies-on-a-line-between-2-other-points
  static boolean pointInLine (PVector p1, PVector p2, PVector p) {
    if (p1.x == p2.x && p1.y == p2.y) return false;
    
    float epsilon = 0.1; // Niveau d'intolerance
    
    float dxc = p.x - p1.x;
    float dyc = p.y - p1.y;
    
    float dy = p2.y - p1.y;
    float dx = p2.x - p1.x;
    
    float cross = dxc * dy - dyc * dx;

    return (abs(cross) < epsilon); 
  }
  
  static boolean pointInSegment(PVector p1, PVector p2, PVector p) {
    if (!pointInLine(p1, p2, p)) return false;
    
    float dy = p2.y - p1.y;
    float dx = p2.x - p1.x;
    
    if (abs(dx) >= abs (dy)) {
      return dx > 0 ?
        p1.x <= p.x && p.x <= p2.x :
        p2.x <= p.x && p.x <= p1.x ;
      
    } else {
      return dy > 0 ?
        p1.y <= p.y && p.y <= p2.y :
        p2.y <= p.y && p.y <= p1.y ;
    }
   
  }
}