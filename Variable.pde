class Variable{
    public Variable(String l, float str, float d){
        valid = true;
        currentValue = str;
        delta = d;
        label = l;
    }

    public Variable(String line){
        String[] s = splitTokens(line);
        if (match(s[0],"^(v|h)*") == null){
            valid = false;
            return;
        }
        if (s.length < 3){
                valid = false;
                return;
        }
        float str = float(s[1]);
        float d = float(s[2]);
        
        valid = true;
        currentValue = str;
        delta = d;
        label = s[0];
        //this(s[0], float(s[1]), float(s[2]), float(s[3]));

    }

    public float get(){
        return currentValue;
    }

    public String getLabel(){
        return label;
    }

    public boolean isValid(){
        return valid;
    }

    public void step (int i){
        currentValue += i * delta;
    }

    private String label;
    private boolean valid;
    private float currentValue;
    private float delta;
}