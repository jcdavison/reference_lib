## Creating Flexible Interfaces

#### RANDOM HEURISTIC 'Depend on things that change less often than you do.'

#### SOLILOQUY ON DESIGN

An object-oriented application is more than just classes.  It is made of up classes but defined by messages.  Classes control what is in the source code, messages are the living, animated application. Design must therefore be concerned with the messages that pass between objects.  Design deals not only with what objects know (their responsibilities) and who they know (their dependencies), but also how they talk to one another. The conversation that occurs between objects relates to their interfaces.
  
Be the second pattern.
  
  ![http://cl.ly/image/0m0z1j432b1P/Image%202014-11-06%20at%201.31.03%20PM.png](http://cl.ly/image/0m0z1j432b1P/Image%202014-11-06%20at%201.31.03%20PM.png)
  
## Modeling the Public Interface

Consider the the Bicycle Tourcing Company (BTC)

BTC...

- Offers road and mountain bike trips.
- Each trip has a specific route and may occur several times throughout the year.
- Each trip can handle n customers and requires y guides who are also mechanics.
- Customers may rent or bring their own bike.
- BTC has rental bikes and shares a pool of rental bikes with local tour shops, mountain/road are avail.

#### BTC Primary 'use' case.

A `Customer`, in order to choose a `Trip` nees to see a list of available `Trips`, on a specific date, or specific difficulty, when rental bikes are available.

#### BTC Most Naive, Procedural Design

![http://cl.ly/image/1y2U0613190e/Image%202014-11-07%20at%209.46.52%20AM.png](http://cl.ly/image/1y2U0613190e/Image%202014-11-07%20at%209.46.52%20AM.png)

`Trip` becomes responsible for:

- Date
- Difficulty
- Checking availability of bikes

Problems:

- `.suitable_trip` is probably an accurate message but should `Trip` be responsible for receiving it? Who should be keeping track of available bikes?

Questions to ponder:

- "Should `Trip` be responsible for figuring out if a bicycle is avail?"
- "Should this receiver be responsible for responding to this message?"

Details to Note:

- Using UML for initial designs shifts conversation awary from "What are my Classes" to "Whate messages need to be passed around?".
- "I need to send this message, who should respond to it?"
- You don't send message because you have Objects, you have Objects because you send messages.

#### BTC Less Naive, Still Procedural Design

![http://cl.ly/image/2o2c140G251b/Image%202014-11-07%20at%209.56.31%20AM.png](http://cl.ly/image/2o2c140G251b/Image%202014-11-07%20at%209.56.31%20AM.png)

Problems: 

- `Customer` becomes responsible for knowing where to ask and how to ask, double whammy.
- `Customer` is basically going into the kitchen and making food.

Questions to ponder:

- "How to think more about asking for what vice telling how?"

#### BTC Still Naive, `Trip` and `Mechanic`

![http://cl.ly/image/1k0N0S261s0R/Image%202014-11-07%20at%2010.23.38%20AM.png](http://cl.ly/image/1k0N0S261s0R/Image%202014-11-07%20at%2010.23.38%20AM.png)

Consider the relationship from `Trip` and `Mechanic`:

- `Trip` is about to start, it needs to ensure that all `Bikes` are mechanically sound.

- `Trip` *COULD* know exactly how to make a bike ready and can ask a `Mechanic` to do each of the required actions.

- `Trip` has the public interface method `.bicycles`, `Mechanic` has the public methods `.clean_bicycle .pump_tires .lube_chain .check_brakes`.

- Given this design, `Trip` has to know what `Mechanic` can do and if `Mechanic` changes, so to does `Trip` have to change.

#### BTC Much Less Naive, `Trip` and `Mechanic`

![http://cl.ly/image/3P213j0y462w/Image%202014-11-07%20at%2010.29.31%20AM.png](http://cl.ly/image/3P213j0y462w/Image%202014-11-07%20at%2010.29.31%20AM.png)

- In this case, all `Trip` needs to know is that `Mechanic` will prepare a bike, whatever else happens in the process is the responsibility of `Mechanic`.

Food for Thought:

In this less naive example, the information that `Trip` knows about other Objects is called context.  `Trip` has a single responsibility but it expects a context.  `Trip` expects a context to be hodling onto a `Mechanic` Object that responds to `.prepare_bike`.  

Preparing a `Trip` always requires preparing a `Bike`.  A `Trip` cannot be reused with out `Mechanic`, which responds to `.prepare_bike`.

Objects that have narrow or limited context are easy to reuse and test.  Objects that are hard to reuse are brittle and can strangle an application.  In this less naive example, `Trip` sill has to know a lot about `Mechanic`, we can use dependency injection to further reduce context.

Consider that in previous designs, `Trip` is focusing on how to do something, not necessarily "what" is the something to be done.  Consider designing and telling `Mechanic`
 "Hey I want to be prepared" and then let `Mechanic` handle the rest.


#### Object Oriented `Trip` and `Mechanic`

![http://cl.ly/image/2Z0j2e0N3E3E/Image%202014-11-07%20at%2010.45.35%20AM.png](http://cl.ly/image/2Z0j2e0N3E3E/Image%202014-11-07%20at%2010.45.35%20AM.png)

- In this case, `Trip` knows almost nothing about `Mechanic` other than it exists.

`Trip` says, "I want to be prepared."  `Mechanic` says, "Ok, show me your bicycles.  I'll prepare each bike, go have coffee."  `Trip` can collaborate with `Mechanic` and has to know almost nothing about what `Mechanic` does.

#### Object Oriented `Customer`, `Trip` and `Bicycle`

![http://cl.ly/image/332M0m2U3U3h/Image%202014-11-07%20at%2010.49.09%20AM.png](http://cl.ly/image/332M0m2U3U3h/Image%202014-11-07%20at%2010.49.09%20AM.png)

- Consider the original problem, `Customer` wants to know avail `Trips` which means we need to look at available bikes.  This design, `Customer` has *MUCH* lower context.

- The behavior that is `.suitable_trip` is now isolated and it isn't the responsibilty of `Customer` any more.

#### Explicit Interface

Every time a Class is created, declare its interfaces.  Methods in the public interface should:

- Be explicitly defined as such.
- Be more about what then how.
- Have names that, as much as possible, will not change (ohhh the irony...).
- Take a hash as an options parameter.

#### Public, Protected and Private.

The distinction between these states serves two key purposes.

1. Communicate which methods are stable and unstable.
1. Control how visible the methods are to other parts of the application.

Private Methods: 

- Are the least stable, must be called with an implicit receiver and are never called with an explicit receiver.

- If `Trip` contains the private method `.fun_factor`, then `Trip`:

  - May not call `self.fun_factor` from within `Trip`.
  - May not call `instance.fun_factor` from anywhere else in the application.
  - May send `.fun_factor` which implicitly defaults to self from inside `Trip`.
  
Protected Methods:

- May have an explicit receiver, which must be `self`, or an instance of the same Class, or a sub-class of `self`.


Public Methods:

- Are stable and visible to the application.

#### Important Interface Details

1. Honor the public interfaces of other Objects.
1. Exercise caution when depending on private interfaces.
1. Minimize context.

#### Law of Demeter

Restrict the set of Objects to which a method may send messages.

Prohibit routing a message to a third Object via a second Object of a third type (WTF?).

"Only talk to your immediate neighbors" or "Use only one dot".

Consider:

`customer.bicycle.wheel.rotate`

This is a "train wreck of dots". `Customer` has to know way to much to be able to know that it can call `.rotate` on `Wheel`.














