## Creating Flexible Interfaces

#### RANDOM HEURISTIC 'Depend on things that change less often than you do.'

#### SOLILOQUY ON DESIGN

An object-oriented application is more than just classes.  It is made of up classes but defined by messages.  Classes control what is in the source code, messages are the living, animated application. Design must therefore be concerned with the messages that pass between objects.  Design deals not only with what objects know (their responsibilities) and who they know (their dependencies), but also how they talk to one another. The conversation that occurs between objects relates to their interfaces.
  
Be the second pattern.
  
  ![http://cl.ly/image/0m0z1j432b1P/Image%202014-11-06%20at%201.31.03%20PM.png](http://cl.ly/image/0m0z1j432b1P/Image%202014-11-06%20at%201.31.03%20PM.png)
  
There are two types of interfaces to be considered in this conversation.  The first interface is internal to a class that manages the public facing and private only methods.  The second interface deals with the set of messages that exist across all Classes in an application.  This section will deal primarily with the interface internal to a Class. 

##### Public Interface Methods

Think of the public interface as the same as a person entering a restaurant and using a menu to get food.  The customer doens't really need to or want to know what is happening in the kitchen.  The customer calls on something 'food' and the kitchen produces it.

- Reveal its primary responsibility.
- Are expected to be invoked by others.
- Will not change on a whim.
- Are safe for others to depend on.
- Are thoroughly documented in the tests.

#### Private Interace Methods.

- Handle implementation details.
- Are not expected to be sent by other objects.
- Can change for any reason whatsoever.
- Are usafe for others to depend on.
- May not even be referenced in tests.

#### ON DESIGN

When given a large, complex system to model, it could be common to start building Classes based on the big Nouns, but frequently, those nouns are Domain Objects and not really the ultimate classes to be used.

Think about using UML, uniform modeling language, diagrams, to model and understand the objects and messages.

An important shift in thinking is from "I know I need this class, what should it do" to "I need to send this message, who should respond to it?"

You don't send messages because you have objects, you have objects because you need to send messages. 

#### CREATE EXPLICIT INTERFACES, METHODS IN THE PUBLIC INTERFACE SHOULD

- Be explicitly indentified as such.
- Be more about what than how.
- Have names that, insofar as you be anticipated, will not change.
- Take a hash as an options parameter.
- private methods are the least stable and provide the most resctricted visibility, private methods should never be called from other objects.
- protected keywords indicates unstable methods, slightly less visiblity restrictions.
- public indicates it is a stable method and may be called in many places.

