# Complex Number Linear Interpolation Test

I had a hypothesis: if lerping between two complex numbers A and B with a complex number lerp factor L, does L's imaginary component cause "motion" perpendicular to the line in the complex plane from A to B?

I was right, and everything I saw made sense.
My understanding: to perform a lerp, the line from 0 to 1 is dragged to go from A to B, dragging the whole complex plane with it, and where L ends up is the result of the lerp.

Pretty cool way to visualise real number lerps, too.

I also thought that maybe lerp(a,b,l)=(1-l)a+lb wouldn't work but lerp(a,b,l)=a+l(b-a) would, but they both work.
Now my understanding of complex numbers has improved.

## Controls

- Left mouse: place lerp start A
- Right mouse: place lerp end B
- Middle mouse or L: place lerp end L

## Display

- The real and imaginary number lines cross the middle of the screen horizontally and vertically, respectively
- The complex plane's equivalent to the unit circle is drawn, too. Whatever it's called
- 1, i, -1, and -i are drawn as small grey points
- A is a red point
- B is a green point
- L is a blue point
- The lerped quantity is a large grey point

## Start

- A is -1+i
- B is 2+2i
- L is 1
