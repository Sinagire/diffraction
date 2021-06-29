public class Pattern{

    public Pattern(String file){

        opts = new ArrayList<Operation> ();
        vars = new ArrayList<Variable>  ();
        scale = 1.0;
        intensity = 100;
        zoomout = 1.0;
        String[] lines = loadStrings(file);

        boolean vflag = false;
        boolean hflag = false;
        for (int i = 0; i < lines.length; i++){
            String[] temp = splitTokens(lines[i]);
            if (temp.length == 0 || match(temp[0],"^#") != null) {continue;}
            Operation o = new Operation(lines[i]);
            if (o.isValid()) {opts.add(o);}
            // register as a Variable
            else{
                Variable v = new Variable(lines[i]);
                if (v.isValid()) {
                    vars.add(v);
                    if (match(v.getLabel(),"^v") != null) {vflag = true;}
                    if (match(v.getLabel(),"^h") != null) {hflag = true;}
                }
                else{
                    if (temp[0].equals("scale") && temp.length >= 2){
                        scale = float (temp[1]);
                    }
                    if (temp[0].equals("intensity") && temp.length >= 2){
                        intensity = float (temp[1]);
                    }
                    if (temp[0].equals("zoomout") && temp.length >= 2){
                        zoomout = float (temp[1]);
                    }
                }
            }
        }
        s = ""; 
        if (vflag || hflag) {s += "Control: ";}
        if (hflag) {s += "←→";}
        if (vflag) {s += "↑↓";}
    }

    public Pattern(){
        s="";
        scale = 1.0;
        intensity = 100;
        zoomout = 1.0;
        opts = new ArrayList<Operation> ();
        opts.add(new Operation("rr 0 -0.4 15"));
    }

    public void show(){
        ListIterator<Operation> i = opts.listIterator();
        while (i.hasNext()){
            Operation o = i.next();
            o.operate(vars, scale);
        }
    }

    public String get_s(){
        return s;
    }

    public float getScale(){
        return scale;
    }

    public float getIntensity(){
        return intensity;
    }

    public float getZoomout(){
        return zoomout;
    }

    public void step (int i){
        ListIterator<Variable> j = vars.listIterator();
        while (j.hasNext()){
            Variable v = j.next();
            v.step(i);
        }
    }

    public void step (String regex, int i){
        ListIterator<Variable> j = vars.listIterator();
        while (j.hasNext()){
            Variable v = j.next();
            //println(v.getLabel());
            if (match(v.getLabel(),regex) != null){
                //println(v.getLabel());
                //println(match(v.getLabel(),regex));
                v.step(i);
            }
        }
    }

    private ArrayList<Operation> opts;
    private ArrayList<Variable>  vars;
    private String s;
    private float scale;
    private float intensity;
    private float zoomout;
}