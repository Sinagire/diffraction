Syntax for data files
=====================

[syntax.ja.md in 日本語](syntax.ja.md) is also available.

Coordinates
-----------

The horizontal coordinate (x) and the vertical coordinate (y) indicate a point in the left pannel. The range is -1/s <= x, y
< 1/s, where s is a scale factor, whose default value is 1.

In the right panel, the reciprocal coordinates (kx, ky) 
corresponds to (x, y). The range is set to
-0.425 N z <= kx, ky < 0.425 N z, where z is a zoom-out factor
(whose default value is 1) and N is a one-dimensional resolution for the left panel (N = 100 by default). The magic number does not have 
much meaning. I chose it as a number reasonably smaller
than 0.5.


Configuration
-------------
* `scale num` sets the scale factor to num.
* `zoomout num` sets the zoomout factor to num.
* `intensity num` sets a factor that controls the contrast of the diffraction pattern to num. When the factor is large, the right panel is sensitive to the diffraction signal and easy to saturate.

Variables
---------
* `v1 init diff` sets a variable that one can control by the vertical arrow keys (↑, ↓). The initial value is set to init, and the increment is to diff. You can use 'v1' as a value in the pattern commands. Any labels that start with 'v' work in the same manner, and can coexist with each other.

* `h1 init diff` sets a variable that is controlable by the horizontal arrow keys (←, →). Any labels that start with 'h' also work.

Patterns
--------
* `f1 g` sets a grayscale color indicated by g (0: black, 255: white) for the following elements. 
* `f3 r g b` sets a color indicated by RGB for the following elements.
* `rr x y angle` puts a slit so that its center is on (x, y) in the left panel with a rotation of angle.
* `circ x y r` puts a circle whose radius is r so that its center is on (x, y).
* `img5 filename x y s1 s2` puts an image indicated by filename (.gif, .jpg, .tga, .png) so that its center is on (x, y). The image is elongated along x by the factor of s1, and along y by s2.
* `img filename x y` puts an image without elongation. This is identical to `img5 filename x y 1 1`.

Comments
--------
You can comment out a line by putting `#` on the head.

Datalist
--------
A list of the pattern files must be put on `data/datalist.txt`. The program will show the pattern from top to bottom. Add your pattern file to the list when you created a new one, otherwise it will not appear.
