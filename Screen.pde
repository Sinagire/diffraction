public class Screen{

    public PVector xy2screen(float x,float y){
  
        PVector p = new PVector();
        /*
        s = max (width/2.0, height);
        -1 <= x <= 1  --> 0 <= p.x <= width/2.0 
        -1 <= y <= 1  --> 0 <= p.y <= height
        */
        float s = min (width/2.0, height);
        p.x =   x * s / 2.0 + width  / 4.0;
        p.y = - y * s / 2.0 + height / 2.0;
  
        return p;
    }

    public float convScalar(float x){
        float s = min (width/2.0, height);
        float r = x * s / 2.0;
        return r;
    }

}