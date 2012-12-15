# RfTouch - Sencha Touch 2 library
Currently offers a ReloadStore, which help automating retries on remote services. 
This is probably mostly useful when packing your Sencha Touch product inside a native app.

__Upcomming__: RfMap, and Ext.Map that handles connectivity problems.

# Getting started
Download the RfTouch folder, and put it inside your project. Add the project to the 
loader and start using the library like any other Sencha Touch 2 code.

For an example of the usage please read [RfTouch sees light](http://rohdef.dk/wp3/?p=176) 
and take a look at the tests, which also show the usage. A JsDuck documentation is 
on it's way.

# Building you project with RfPulse
Currentlly haven't looked into how to make Sencha CMD include this when building, 
so currently it's a DIY. If you know how to do it and make it work, please feel free 
to contact me.

# Feedback, bugs etc.
There's no such thing as without bugs or error free. Also there's always space for 
improvements. You are very welcome to contact me with ideas, suggestions and bugs.

If possible please write a test case. I use the BusterJs testing framework using 
expectations (so I write expect(foo).toEqual(bar), rather than assert.equals(foo, bar)).

If you've bug reported before you know the drill, if you haven't please have the 
following questions in mind: What is the problem? What did you expect? What did 
happen? What did you do to make this happen? What versions of RfTouch and 
Sencha Touch have you tested it with? How reproducable is it (every time, randomly or..). 
And of couse please include all the details you can that are relevant, such as 
code samles.

# Running tests
To run the tests is quite simple, first you have to install buterjs by running:

  npm install -g buster

After that you run your run the command:

  buster-server

in an terminal, and navigate your browser to the given address (most likely http://localhost:1111 ) and press the capture browser button.
After that navigate your terminal to the test-setup folder and run:

  buster-test
