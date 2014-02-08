## SERVICE ORIENTED DESIGN WITH RUBY AND RAILS
#### http://www.amazon.com/Service-Oriented-Design-Addison-Wesley-Professional-Series/dp/0321659368

questions I should care about,

how to render error status codes in rails ?
how to raise errors in rails ? 
#### Key questions to think about compartmentalizing a service

  - Which data has high read and low write fequency ?
  - Which data has high write or update frequency ? 
  - Which joins occur most frequently ? 
  - Which parts of the app have clearly defined requirements and design ? 

  * these questions lead to paritioning based on;

  - iteration speed
  - logical function
  - read/write
  - joins 



