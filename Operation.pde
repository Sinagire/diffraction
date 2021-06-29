import java.util.*;

class Operation{

    public Operation(String cmd){
        args = splitTokens(cmd);
        if (args.length==0){
            args = new String[1];
            args[0]="";
            valid = false;
        }
        else{
            valid = false;
            for (int i=0; i < regOpt.length; i++){
                if (args[0].equals(regOpt[i]) ){
                    if (args.length >= regArgNum[i] + 1){
                        valid = true;
                        return;
                    }
                }
            }
        }
    }

    public void operate(ArrayList<Variable> a, float scale){
        String[] temp;
        temp = Arrays.copyOf(args,args.length);
        if (a != null){
            ListIterator<Variable> i = a.listIterator();
            while (i.hasNext()){
                Variable v = i.next();
                for (int j = 0; j < args.length; j++){
                    temp[j] = temp[j].replace(v.getLabel(),str(v.get()));
                }
            }
        }
        /*
        for (int j = 0; j < temp.length; j++){
            println(j,temp[j]);
        }
        */
        //println (args[0]);
        switch (args[0]){
            case "f1":
                fill(float(temp[1]));
                break;
            case "f3":
                fill(float(temp[1]),float(temp [2]),float(temp [3]));
                break;
            case "rr":
                _rrect(float(temp [1]),float(temp [2]),radians(float(temp [3])), scale);
                break;
            case "img":
                _putImage(temp[1], float(temp[2]), float(temp[3]), scale);
                break;
            case "img5":
                _putImage(temp[1], float(temp[2]), float(temp[3]), float(temp[4]), float(temp[5]), scale);
                break;
            case "circ":
                _circle(float(temp[1]), float(temp[2]), float(temp[3]), scale);
                break;
            default:
                println("undefined operation");
                break;
        }
    }
    public void operate(ArrayList<Variable> a){
        operate(a,1.0);
    }
    public void operate(){
        operate(null);
    }

    public boolean isValid(){
        return valid;
    }

    private void _circle(float x, float y, float r, float s){
        PVector p, q;
        float f;
        p = _xy2screen(x*s, y*s);
        //q = _xy2screen(r*s, r*s);
        f = _convScalar(r*s);

        circle (p.x, p.y, 2.0 * f);

    }

    private void _rrect(float x, float y, float theta, float s){
        float w=_convScalar(0.8)*s;
        float h=_convScalar(0.05);
  
        PVector p, q;
  
        p = _xy2screen(x*s,y*s);
        q = _xy2screen(w,h);
  
        //rotateOrigin(theta);
        _rotateXY(p,theta);
        rect(p.x-w/2.0,p.y-h/2.0,w,h);
        //rotateOrigin(-theta);
        _rotateXY(p,-theta);
    }

    private void _rrect(float x, float y, float theta){
        _rrect(x, y, theta, 1);
    }

    private void _putImage(String file, float x, float y, float s){
        _putImage(file, x, y, 1, 1, s);
    }

    private void _putImage(String file, float x, float y, float sh, float sv, float s){
        PVector p = _xy2screen(x*s,y*s);
        PImage img;
        img = loadImage(file);
        img.resize(int(img.width*sh*s),int(img.height*sv*s));
        image(img, p.x-img.width/2, p.y-img.height/2);
    }

    void _rotateOrigin(float x){
        PVector p = new PVector(0,0);
        _rotateXY(p,x);
    }

    void _rotateXY(PVector p, float x){
        PVector q;
        q = p;
        //q = xy2screen(p.x,p.y);
        translate(q.x, q.y);
        rotate(x);
        translate(-q.x, -q.y);
    }
    PVector _xy2screen(float x,float y){
  
        PVector p = new PVector();
        /*
        s = max (width/2.0, height);
        -1 <= x <= 1  --> 0 <= p.x <= width/2.0 
        -1 <= y <= 1  --> 0 <= p.y <= height
        */
        float s = min (width/2.0, height);
        p.x = x * s / 2.0 + width  / 4.0;
        p.y = y * s / 2.0 + height / 2.0;
  
        return p;
    }

    float _convScalar(float x){
        float s = min (width/2.0, height);
        float r = x * s / 2.0;
        return r;
    }

    private String[] args;
    private final String[] regOpt   ={"rr", "f1", "f3", "img", "img5", "circ"};
    private final int[]    regArgNum={   3,    1,    3,     3,      5,      3};
    private boolean valid;
}