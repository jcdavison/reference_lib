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



[evaluating single resp]:02-single-responsibility.md#single-responsibility-evaluation
[casual interrogation]:02-single-responsibility.md#evaluating-single-responsibility-via-casual-interrogation
[hide instance variables]:02-single-responsibility.md#hide-instance-variables
[hide data structures]:02-single-responsibility.md#hide-data-structures
[global single resp]:02-single-responsibility.md#enforce-single-responsibility-everywhere
[extra responsibilities]:02-single-responsibility.md#isolate-extra-responsibilities-in-classes
[Full Gear/Wheel]:02-single-responsibility.md#someone-introduces-change

[catch22]:03-dependency-management.md#the-catch-22s-of-objects
[dependency]:03-dependency-management.md#a-dependency-occurs-when
[injection]:03-dependency-management.md#inject-dependencies
[isolate instances]:03-dependency-management.md#isolate-instance-creation
[isolate external messages]:03-dependency-management.md#isolate-vulnerable-external-messages
[remove argument order]:03-dependency-management.md#remove-argument-order-dependencies
[define default args]:03-dependency-management.md#explicitly-define-default-values
[multiparam init]:03-dependency-management.md#isolate-multiparameter-initialization
[dependency direction]:03-dependency-management.md#dependency-direction-reversal