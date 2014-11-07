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


[evaluating single resp]:https://github.com/jcdavison/reference_lib/blob/master/object-oriented-design/02-single-responsibility.md#single-responsibility-evaluation
[casual interrogation]:https://github.com/jcdavison/reference_lib/blob/master/object-oriented-design/02-single-responsibility.md#evaluating-single-responsibility-via-casual-interrogation
[hide instance variables]:02-single-responsibility.md#hide-instance-variables

## Dependency Management