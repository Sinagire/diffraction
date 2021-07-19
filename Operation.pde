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

    public void operate(ArrayList<Variable> a, float scale, Screen scr){
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
                _rrect(float(temp [1]),float(temp [2]),radians(float(temp [3])), scale, scr);
                break;
            case "rect5":
                _rect(float(temp [1]),float(temp [2]),float(temp [3]),
                      float(temp [4]), radians(float(temp [5])), scale, scr);
                break;
            case "img":
                _putImage(temp[1], float(temp[2]), float(temp[3]), scale, scr);
                break;
            case "img5":
                _putImage(temp[1], float(temp[2]), float(temp[3]), float(temp[4]), float(temp[5]), scale, scr);
                break;
            case "circ":
                _circle(float(temp[1]), float(temp[2]), float(temp[3]), scale, scr);
                break;
            default:
                println("undefined operation");
                break;
        }
    }
    public void operate(ArrayList<Variable> a, Screen scr){
        operate(a, 1.0, scr);
    }
    public void operate(Screen scr){
        operate(null,scr);
    }

    public boolean isValid(){
        return valid;
    }

    private void _circle(float x, float y, float r, float s, Screen scr){
        PVector p, q;
        float f;
        p = scr.xy2screen(x*s, y*s);
        f = scr.convScalar(r*s);

        circle (p.x, p.y, 2.0 * f);

    }
    private void _rrect(float x, float y, float theta, float s, Screen scr){
        float w=scr.convScalar(0.8)*s;
        float h=scr.convScalar(0.05);
  
        PVector p, q;
  
        p = scr.xy2screen(x*s,y*s);
        q = scr.xy2screen(w,h);
  
        _rotateXY(p,theta);
        rect(p.x-w/2.0,p.y-h/2.0,w,h);
        _rotateXY(p,-theta);
    }

    private void _rect(float x, float y, float ww, float hh, float theta, float s, Screen scr){
        float w=scr.convScalar(ww)*s;
        float h=scr.convScalar(hh);
  
        PVector p, q;
  
        p = scr.xy2screen(x*s,y*s);
        q = scr.xy2screen(w,h);
  
        _rotateXY(p,theta);
        rect(p.x-w/2.0,p.y-h/2.0,w,h);
        _rotateXY(p,-theta);
    }

    private void _rrect(float x, float y, float theta, Screen scr){
        _rrect(x, y, theta, 1, scr);
    }

    private void _putImage(String file, float x, float y, float s, Screen scr){
        _putImage(file, x, y, 1, 1, s, scr);
    }

    private void _putImage(String file, float x, float y, float sh, float sv, float s, Screen scr){
        PVector p = scr.xy2screen(x*s,y*s);
        PImage img;
        img = loadImage(file);
        if (img == null) {
            javax.swing.JOptionPane.showMessageDialog(null, "Could not open \"" + file + "\".");
            return;
        }
        img.resize(int(img.width*sh*s),int(img.height*sv*s));
        image(img, p.x-img.width/2, p.y-img.height/2);
    }

    void _rotateXY(PVector p, float x){
        PVector q;
        q = p;
        translate(q.x, q.y);
        rotate(x);
        translate(-q.x, -q.y);
    }

    private String[] args;
    private final String[] regOpt   ={"rr", "f1", "f3", "img", "img5", "circ", "rect5"};
    private final int[]    regArgNum={   3,    1,    3,     3,      5,      3,       5};
    private boolean valid;
}