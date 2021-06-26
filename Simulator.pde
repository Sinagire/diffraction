public class Simulator{

    public Simulator(int x, int y){
        Nx = x;
        Ny = y;
        value    = new float[Nx+1][Ny+1];
        spectrum = new float[Nx+1][Ny+1];
    }
    public Simulator(){
        this(100,100);
    }
    public void scan(){
        for (int i=0; i<=Nx; i++){
            for (int j=0; j<=Ny; j++){
                float x = i*2.0/Nx - 1.0;
                float y = j*2.0/Ny - 1.0;
                PVector p = _xy2screen(x,y);
                color c = get(int(p.x),int(p.y));
                value[i][j]=brightness(c)/255;
            }
        }
    }
    public void calculate(float scale){
        float re[][] = new float[Nx+1][Ny+1];
        float im[][] = new float[Nx+1][Ny+1];

        // Fourier transform
        float alpha = 1.7/scale*min(Nx,Ny)*.25;
        for (int ki=0; ki<=Nx; ki++){
        float kx = (ki*2.0/Nx - 1.0)*alpha;
            for (int kj=0; kj<=Ny; kj++){
                float ky = (kj*2.0/Ny - 1.0)*alpha;
                re[ki][kj] = 0.0;
                im[ki][kj] = 0.0;
                for (int i=0; i<=Nx; i++){
                    float x = i*2.0/Nx - 1.0;
                    float temp = kx * x;
                        for (int j=0; j<=Ny; j++){
                            float y = j*2.0/Ny - 1.0;
                            if (value[i][j] == 0) continue;
                            float temp2 = temp + ky * y;
                            re[ki][kj] += value[i][j] * cos(temp2); 
                            im[ki][kj] += value[i][j] * sin(temp2);
                        }
                    }
                spectrum[ki][kj] = re[ki][kj]*re[ki][kj] + im[ki][kj]*im[ki][kj];
            }
        }  
    }
    public void calculate(){
        calculate(1.0);
    }
    public void show(){
        float dx = 2.0/Nx;
        float dy = 2.0/Ny;
        fill(255);
        rect(width/2.0,0,width/2.0,height);
            for (int i=0; i<=Nx; i++){
                for (int j=0; j<=Ny; j++){
                float x = i*2.0/Nx - 1.0;
                float y = j*2.0/Ny - 1.0;
                PVector p = _xy2screen(x,y);
                //color c = color((re[i][j]*re[i][j]+im[i][j]*im[i][j])/Nx/Ny*70);
                color c = color((spectrum[i][j])/Nx/Ny*100);
                c = color(255-brightness(c));
                //color c = color(value[i][j]*255);
                stroke(c);
                fill(c);
                rect(p.x+width/2.0,p.y,_convScalar(dx),_convScalar(dy));
            }
        }
        stroke(255);
        line(width/2,0,width/2,height);
    }

    private PVector _xy2screen(float x,float y){
  
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

    private float _convScalar(float x){
        float s = min (width/2.0, height);
        float r = x * s / 2.0;
        return r;
    }

    private float value[][];
    private float spectrum[][];
    private int Nx, Ny;

}