## SUMMARY OF PRACTICAL OO DESIGN

http://www.poodr.com/
code repo https://github.com/skmetz/poodr

*Object oriented design in the process of making intentioned decisions that organize code into containerized objects that have a minimal amount of inter-object dependency and the maximum amount of flexibility and repurpose-ability.*

"Changing requirements are the programming equivalent of friction and gravity."

One concrete goal of OO programming is to ensure that changes can be made to an application without creating of 'ripple' of requirements to change other parts of the application.

#### OO Design is based on the SOLID acronym.

- S single Responsibility

- O open-closed

- L liskov Substitution

- I interface Segregation

- D dependency Inversion

- Support is further added from DRY (Don't repeat yourself) and LoD (Law of Demeter)



## SINGLE PURPOSE FUNCTIONALITY

"The foundation of an object-oriented system is the message, but the most visible organizational structure is the class."

We see Classes as the dominant element of OO programming but in a more subtle sense, we care more about the messsages being passed around the application.


#### Core questions to help think about Classes

  * What are Classes?
  * How many should you have?
  * What behavior should they implement?
  * How much do they know about other classes?
  * How much of themselves should they expose?

#### Organize code to allow for easy changes; define 'easy' as,

  * Changes doen't have unexpected side effects.
  * Small changes in requirements have equally small code changes.
  * Exisiting code is easy to reuse.
  * The easiest way to make a change is to add code that in itself if easy to change.
  
#### Write TRUE code ( Transparent, Reasonable, Usable, Exemplary )

  * Transparent, the consequences of change should be obvious in the code that is changing and in distant code that relies on it.
  * Reasonable, the cost of any change should be proportional to the benefits of the change it achieves.
  * Usable, existing code should be usable in new and expected contexts.
  * Exemplary, code itself should encourage those who change it to perpetuate these qualities.

## Single Responsibility Code

- [Evaluating Single Responsibility][evaluating single resp]
- [Casual Interrogation][casual interrogation]
- [Hide Instance Variables][hide instance variables]
- [Enforce App Wide Single Responsibility][global single resp]
- [Isolate Extra Responsibilities in Classes][extra responsibilities]
- [Complete Gear/Wheel][Full Gear/Wheel]

[evaluating single resp]:02-single-responsibility.md#single-responsibility-evaluation
[casual interrogation]:02-single-responsibility.md#evaluating-single-responsibility-via-casual-interrogation
[hide instance variables]:02-single-responsibility.md#hide-instance-variables
[hide data structures]:02-single-responsibility.md#hide-data-structures
[global single resp]:02-single-responsibility.md#enforce-single-responsibility-everywhere
[extra responsibilities]:02-single-responsibility.md#isolate-extra-responsibilities-in-classes
[Full Gear/Wheel]:02-single-responsibility.md#someone-introduces-change

## Dependency Management

- [The Catch-22 of Objects][catch22]
- [A Dependency is When..][dependency]
- [Dependency Injection][injection]
- [Isolate Class Instantiation][isolate instances]
- [Isolate Vulnerable External Messages][isolate external messages]
- [Remove Argument Order Dependencies][remove argument order]
- [Explicitly Define Default Args][define default args]
- [Isolate Multi-Param Initialization][multiparam init]
- [Controlling Dependency Direction][dependency direction]

[catch22]:03-dependency-management.md#the-catch-22s-of-objects
[dependency]:03-dependency-management.md#a-dependency-occurs-when
[injection]:03-dependency-management.md#inject-dependencies
[isolate instances]:03-dependency-management.md#isolate-instance-creation
[isolate external messages]:03-dependency-management.md#isolate-vulnerable-external-messages
[remove argument order]:03-dependency-management.md#remove-argument-order-dependencies
[define default args]:03-dependency-management.md#explicitly-define-default-values
[multiparam init]:03-dependency-management.md#isolate-multiparameter-initialization
[dependency direction]:03-dependency-management.md#dependency-direction-reversal

## Flexible Interface Design

- [Modeling the Public Interface][interface modeling]
- [Most Naive, Most Procedural Design][most naive]
- [Less Naive, Mostly Procedural Design][less naive]
- [Still Naive...][still naive]
- [Much Less Naive][much less naive]
- [Object Oriented Trip/Mechanic][object oriented trip mechanic]
- [Object Oriented Customer Trip Bicycle][object oriented customer trip bicycle]

[interface modeling]:04-creating-flexible-interfaces.md#modeling-the-public-interface
[most naive]:04-creating-flexible-interfaces.md#btc-most-naive-procedural-design
[less naive]:04-creating-flexible-interfaces.md#btc-less-naive-still-procedural-design
[still naive]:04-creating-flexible-interfaces.md#btc-still-naive-trip-and-mechanic
[much less naive]:04-creating-flexible-interfaces.md#btc-much-less-naive-trip-and-mechanic
[object oriented trip mechanic]:04-creating-flexible-interfaces.md#object-oriented-trip-and-mechanic
[object oriented customer trip bicycle]:04-creating-flexible-interfaces.md#object-oriented-customer-trip-and-bicycle

## Duck Typing

- [Overlooking Duck Types][overlooking ducks]
- [Polymorphism][duck polymorphism]
- [Recognizing Hidden Ducks][recognizing hidden ducks]

[overlooking ducks]:05-duck-typing.md#overlooking-ducks 
[duck polymorphism]:05-duck-typing.md#polymorphism
[recognizing hidden ducks]:05-duck-typing.md#recognizing-hidden-ducks


## Inheritance

- [When to Use It][when to use it]
- [Concrete Classes][concrete]
- [Naive Implementation of `RoadBike` and `Mountainbike`][naive road mountain]
- [Finding Embedded Types][finding embedded types] 
- [Modeling Inheritance][Modeling Inheritance]
- [Naive Implementation re Super][Naive Implementation re Super]
- [2 Rules of Modeling][2 Rules of Modeling]
- [The Abstract SuperClass][The Abstract SuperClass]
- [The Template Method Pattern][The Template Method Pattern]
- [Naive Implementation of Subclass Specialization][Naive Implementation of Subclass Specialization]
- [Decoupling Using Hook Messages][Decoupling Using Hook Messages]


[when to use it]:06-inheritance.md#recognizing-when-to-user-inheritance
[concrete]:06-inheritance.md#concrete-classes
[naive road mountain]:06-inheritance.md#naive-implementation-of-bicycle-to-manage-both-road-and-mountain
[finding embedded types]:06-inheritance.md#finding-embedded-types
[Modeling Inheritance]:06-inheritance.md#modeling-inheritance
[Naive Implementation re Super]:06-inheritance.md#naive-implementation-of-mountainbike
[2 Rules of Modeling]:06-inheritance.md#2-rules-of-modeling
[The Abstract SuperClass]:06-inheritance.md#abstract-superclass
[The Template Method Pattern]:06-inheritance.md#template-method-pattern
[Naive Implementation of Subclass Specialization]:06-inheritance.md#somewhat-naive-implementation-of-subclass-specialization
[Decoupling Using Hook Messages]:06-inheritance.md#decoupling-using-hook-messages

## Sharing Behavior Through Modules

- [Finding Shareable Roles][Finding Shareable Roles] 
- [Using a Module to Share a Trip][Using a Module to Share a Trip]
- [Discovering the Schedulable Duck Type][Discovering the Schedulable Duck Type]
- [Inheritance Antipatterns][Inheritance Antipatterns]
- [Honor the Contract - LSP][Honor the Contract - LSP]
- [Create Shallow Hierarchies][Create Shallow Hierarchies]

[Finding Shareable Roles]:07-sharing-behavior-with-modules.md#finding-roles
[Using a Module to Share a Trip]:07-sharing-behavior-with-modules.md#using-a-module-to-schedule-a-trip
[Discovering the Schedulable Duck Type]:07-sharing-behavior-with-modules.md#discovering-the-schedulable-duck-type
[Inheritance Antipatterns]:07-sharing-behavior-with-modules.md#2-important-inheritance-antipatterns
[Honor the Contract - LSP]:07-sharing-behavior-with-modules.md#honor-the-contract
[Create Shallow Hierarchies]:07-sharing-behavior-with-modules.md#create-shallow-hierarchies

## Composition

- [Building With Composition][Building With Composition] 
- [Using Factories to Create Objects][Using Factories to Create Objects]
- [Aggregation][Aggregation]

[Building With Composition]:08-designing-with-composition.md#combining-objects-with-composition
[Using Factories to Create Objects]:08-designing-with-composition.md#creating-objects-with-factories
[Aggregation]:08-designing-with-composition.md#aggregation