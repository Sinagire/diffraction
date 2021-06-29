class PatternControl extends ArrayList<Pattern>{

    public PatternControl(){
        cur = 0;
    }
    public void step(){
        cur = (cur + 1) % size();
    }
    public void step(int i){
        cur = (cur + i) % size();
    }
    public Pattern getcur(){
        return get(cur);
    }
    private int cur;
}