%% A Hilbert curve on a surface and Chebsnake2
% Georges Klein, March 2013

%%
% (Chebfun2 example fun/HilbertSurfaceChebsnake2.m)
% [Tags: #Chebfun2, #chebsnake, #chebsnake2, #Hilbert]

%%
% Functions of two variables can be plotted easily in Chebfun2; see for instance
% the examples "Pretty Functions" and "Bump Functions" ([1], [2]). Here is the
% plot of a hilly surface:

hilly = chebfun2(@(x,y) cos(2*(x.^2+y)).*sin(3*(-x+y.^2)));
plot(hilly)

%%
% Chebfun deals with functions of one variable. Let us construct the 1024
% corners of the fifth iterate of a Hilbert curve (see [3], code inspired by
% that of Federico Forte), define them as points in the complex plane and
% interpolate them with Chebfun,

x = 0; y = 0; k = 0;
while ( k < 5 )
    xtemp = [-.5+y -.5+x .5+x  .5-y];
    ytemp = [-.5+x  .5+y .5+y -.5-x];
    x = 0.5*xtemp; y = 0.5*ytemp; k = k+1;
end
x = 2*x; y = 2*y;
plot(x,y,'.'), hold on
hilbert = chebfun(x+1i*y);
valhilb = hilbert(chebpts(5000)); plot(valhilb)  % sample finely and plot
title('Chebyshev interpolant through the corner points of a Hilbert curve')

%%
% Note that the figure does not display a Hilbert curve; it is a smooth
% Chebyshev interpolant through the corner points that define a Hilbert curve.
% Chebfun and Chebfun2 can be combined to study curves on surfaces, e.g. to
% compute the integral of a function f(x,y) along a curve (x(t),y(t)) defined in
% the complex plane; see chapter 2.5 of the Chebfun2 Guide [4]. Here we contruct
% the approximate Hilbert curve on the above hilly surface:

hold off, plot(hilly), hold on
plot3(real(valhilb),imag(valhilb),hilly(valhilb),'k','linewidth',2), hold off

%%
% Any smooth curve can be drawn on a surface generated by Chebfun2, and also a
% chebsnake [5], which is a piecewise smooth curve, can be evaluated on a
% chebfun2 object. Here is chebsnake2, the analogue of Chebfun's snake; the user
% can specify a chebfun2 object, the kind of nodes for the one-dimensional
% chebsnake, and a speed parameter. Since this is a bit more challenging than
% chebsnake, the shadow of the snake and the "food" are displayed as well

f = chebfun2(@(x,y) (x.^2-1).*(y.^2-1)-.4*exp(-10*(x.^2+y.^2)));
chebsnake2(f)


%% References
%
% 1. Chebfun Example [approx/PrettyFunctions](approx/PrettyFunctions.html)
%
% 2. Chebfun Example [approx/BumpFunction](approx/BumpFunction.html)
%
% 3. D. Hilbert, Uber die stetige Abbildung einer Linie auf ein Flachenstuck,
%    Mathematische Annalen 38 (1891), 459-460.
%
% 4. Chebfun Guide, [Chapters 11-15](../../docs/guide)
%
% 5. Chebfun Example [fun/PiecewiseLinear](fun/PiecewiseLinear.html)
%