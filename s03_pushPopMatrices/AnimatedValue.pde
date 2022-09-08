class AnimatedValue {
    float currentValue;
    float valueFrom;
    float valueTo;

    float animationTime;
    boolean animate = false;
    boolean animationDone = false;
    float animationSpeed;

    float epsilon = 0.01;
    float roundingMultiplier = 100;
    
    void AnimatedValue(float value) {
      setValue(value);
    }
    
    void setValue(float value) {
      currentValue = value;
      valueFrom = value;
    }

    void setGoal (float to) {
        valueTo = to;
    }

    void setStart (float from) {
        valueFrom = from;
    }

    void setEpsilon (float epsilon) {
        this.epsilon = epsilon;
        roundingMultiplier = pow(10, -log(epsilon));
    }

    void setAnimationTime(float time){
        animationTime = time;

        if (animationTime >= 0.0) {
            float valueDelta = valueTo - valueFrom;
            animationSpeed = valueDelta / animationTime;
        }
    }

    float update (float deltaTime) {
        if (animate && !animationDone) {
            float delta = valueTo - currentValue;

            // FIXME : Doit atteindre l'objectif et non la dépasser
            
            float error = abs(round(delta * roundingMultiplier) / roundingMultiplier);
            println(delta);
            if (error >= epsilon) {
              currentValue += animationSpeed * (deltaTime / 1000.0);
            } else {
              currentValue = valueTo; //<>//
              animationDone = true;
            }
        }
        
        return currentValue;
    }

}
