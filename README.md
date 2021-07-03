Diffraction Simulator
=====================

Diffraction Simulator is a two dimensional diffraction simulator.

[README in 日本語](README.ja.md)

Requirements
============
This program works with [Processing](https://processing.org).

Usage
=====
Download [diffraction.zip](diffraction.zip) and expand it to a folder named "diffraction". Open diffraction.pde with Processing and run.

The left panel shows the scatter pattern (the program reads
only the brightness of the pattern). The right panel shows 
the Fraunhofer diffraction pattern calculated by the 2D Fourier 
transform. 

Click the left button to move on to the next pattern, the right button to go back. When some keys are available for controling the pattern, they are indicated in the left panel (like "Control:↑↓←→").

Note
====
You can make your own scatter patterns by writing a data file and registering it into data/datalist.txt. Refer to [syntax.md](syntax.md) for the syntax.

This program comes with absolutely no warranty.

Author
======
Sinagire (sinagire.k@gmail.com)

LICENSE
=======
This program is under MIT license.
